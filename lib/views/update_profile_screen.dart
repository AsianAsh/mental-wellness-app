import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/util/edit_profile_textfield.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart'; // Import the helper functions

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();
  late String joinedDate = '';
  String? selectedCountry;
  bool isDataChanged = false;

  String? initialFirstName;
  String? initialLastName;
  String? initialBio;
  String? initialCountry;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestoreService.getMemberDetails();
      Map<String, dynamic>? userData = userDoc.data();

      if (userData != null) {
        setState(() {
          firstNameController.text = userData['firstName'] ?? '';
          lastNameController.text = userData['lastName'] ?? '';
          bioController.text = userData['bio'] ?? '';
          selectedCountry = userData['country'] ?? '';
          initialFirstName = firstNameController.text;
          initialLastName = lastNameController.text;
          initialBio = bioController.text;
          initialCountry = selectedCountry;
          Timestamp createdAtTimestamp = userData['createdAt'];
          DateTime createdAtDate = createdAtTimestamp.toDate();
          joinedDate = DateFormat('dd MMM yyyy').format(createdAtDate);
          _setupFieldListeners(); // Setup listeners after data is loaded
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  void _setupFieldListeners() {
    firstNameController.addListener(_checkIfDataChanged);
    lastNameController.addListener(_checkIfDataChanged);
    bioController.addListener(_checkIfDataChanged);
  }

  void _checkIfDataChanged() {
    // Print statements for debugging
    print(
        'First Name: ${firstNameController.text} (type: ${firstNameController.text.runtimeType})');
    print(
        'Initial First Name: $initialFirstName (type: ${initialFirstName.runtimeType})');
    print(
        'Last Name: ${lastNameController.text} (type: ${lastNameController.text.runtimeType})');
    print(
        'Initial Last Name: $initialLastName (type: ${initialLastName.runtimeType})');
    print(
        'Bio: ${bioController.text} (type: ${bioController.text.runtimeType})');
    print('Initial Bio: $initialBio (type: ${initialBio.runtimeType})');
    print(
        'Selected Country: $selectedCountry (type: ${selectedCountry.runtimeType})');
    print(
        'Initial Country: $initialCountry (type: ${initialCountry.runtimeType})');

    setState(() {
      isDataChanged = firstNameController.text != initialFirstName ||
          lastNameController.text != initialLastName ||
          bioController.text != initialBio ||
          selectedCountry != initialCountry;
    });
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country.name;
          _checkIfDataChanged();
        });
      },
    );
  }

  Future<void> _updateMemberDetails() async {
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return;
    }
    try {
      await _firestoreService.updateMemberDetails({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'bio': bioController.text.trim(),
        'country': selectedCountry,
      });
      _showDialog('Success', 'Profile updated successfully', true);
    } catch (e) {
      _showDialog('Error', 'Failed to update profile', false);
    }
  }

  void _showDialog(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Get.back(result: true); // Pass a result to indicate success
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text('Edit Profile',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/images/gong_yoo.jpg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.indigo[500]),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    EditProfileTextField(
                      labelText: 'First Name',
                      prefixIcon: Icons.person,
                      controller: firstNameController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Last Name',
                      prefixIcon: Icons.person,
                      controller: lastNameController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Bio',
                      prefixIcon: Icons.description,
                      controller: bioController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 10),

                    // Country Picker
                    GestureDetector(
                      onTap: _showCountryPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.indigo[700],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                              selectedCountry?.isNotEmpty == true
                                  ? selectedCountry!
                                  : 'Select Country',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isDataChanged ? _updateMemberDetails : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDataChanged ? Colors.amber : Colors.grey,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Save Changes',
                            style: TextStyle(color: Colors.indigo)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // -- Created Date
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Joined ',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            children: [
                              TextSpan(
                                  text: joinedDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
