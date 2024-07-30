import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/widgets/edit_profile_textfield.dart';
import 'package:validators/validators.dart';

class UpdateCounsellorProfileScreen extends StatefulWidget {
  const UpdateCounsellorProfileScreen({super.key});

  @override
  _UpdateCounsellorProfileScreenState createState() =>
      _UpdateCounsellorProfileScreenState();
}

class _UpdateCounsellorProfileScreenState
    extends State<UpdateCounsellorProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController languagesController = TextEditingController();
  final TextEditingController experienceYearsController =
      TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();
  late String joinedDate = '';
  String? selectedCountry;
  bool isDataChanged = false;
  String? profilePicUrl;
  File? _image;

  String? initialFirstName;
  String? initialLastName;
  String? initialBio;
  String? initialEducation;
  String? initialJobTitle;
  String? initialCity;
  String? initialCountry;
  String? initialLinkedin;
  String? initialLanguages;
  int? initialExperienceYears;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadCounsellorData();
  }

  Future<void> _loadCounsellorData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      DocumentSnapshot<Map<String, dynamic>> counsellorDoc =
          await FirebaseFirestore.instance
              .collection('counsellors')
              .doc(currentUser.uid)
              .get();
      Map<String, dynamic>? counsellorData = counsellorDoc.data();

      if (counsellorData != null) {
        setState(() {
          firstNameController.text = counsellorData['firstName'] ?? '';
          lastNameController.text = counsellorData['lastName'] ?? '';
          bioController.text = counsellorData['bio'] ?? '';
          educationController.text = counsellorData['education'] ?? '';
          jobTitleController.text = counsellorData['jobTitle'] ?? '';
          cityController.text = counsellorData['city'] ?? '';
          selectedCountry = counsellorData['country'] ?? '';
          linkedinController.text = counsellorData['linkedin'] ?? '';
          languagesController.text =
              (counsellorData['languages'] as List<dynamic>?)?.join(', ') ?? '';
          experienceYearsController.text =
              counsellorData['experienceYears']?.toString() ?? '';
          profilePicUrl = counsellorData['profilePic'] ?? '';
          initialFirstName = firstNameController.text;
          initialLastName = lastNameController.text;
          initialBio = bioController.text;
          initialEducation = educationController.text;
          initialJobTitle = jobTitleController.text;
          initialCity = cityController.text;
          initialCountry = selectedCountry;
          initialLinkedin = linkedinController.text;
          initialLanguages = languagesController.text;
          initialExperienceYears = int.tryParse(experienceYearsController.text);
          Timestamp joinedAtTimestamp = counsellorData['joinedAt'];
          DateTime joinedAtDate = joinedAtTimestamp.toDate();
          joinedDate = DateFormat('dd MMM yyyy').format(joinedAtDate);
          _setupFieldListeners();
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load counsellor data',
        backgroundColor: Colors.white60,
      );
    }
  }

  void _setupFieldListeners() {
    firstNameController.addListener(_checkIfDataChanged);
    lastNameController.addListener(_checkIfDataChanged);
    bioController.addListener(_checkIfDataChanged);
    educationController.addListener(_checkIfDataChanged);
    jobTitleController.addListener(_checkIfDataChanged);
    cityController.addListener(_checkIfDataChanged);
    linkedinController.addListener(_checkIfDataChanged);
    languagesController.addListener(_checkIfDataChanged);
    experienceYearsController.addListener(_checkIfDataChanged);
  }

  void _checkIfDataChanged() {
    setState(() {
      isDataChanged = firstNameController.text != initialFirstName ||
          lastNameController.text != initialLastName ||
          bioController.text != initialBio ||
          educationController.text != initialEducation ||
          jobTitleController.text != initialJobTitle ||
          cityController.text != initialCity ||
          selectedCountry != initialCountry ||
          linkedinController.text != initialLinkedin ||
          languagesController.text != initialLanguages ||
          experienceYearsController.text != initialExperienceYears.toString();
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

  bool _validateFields() {
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return false;
    }
    if (bioController.text.trim().isEmpty) {
      displaySnackBarMessage('Bio cannot be empty', context);
      return false;
    }
    if (educationController.text.trim().isEmpty) {
      displaySnackBarMessage('Education cannot be empty', context);
      return false;
    }
    if (jobTitleController.text.trim().isEmpty) {
      displaySnackBarMessage('Job title cannot be empty', context);
      return false;
    }
    if (cityController.text.trim().isEmpty) {
      displaySnackBarMessage('City cannot be empty', context);
      return false;
    }
    if (selectedCountry == null || selectedCountry!.isEmpty) {
      displaySnackBarMessage('Country cannot be empty', context);
      return false;
    }
    if (linkedinController.text.trim().isEmpty ||
        !isURL(linkedinController.text)) {
      displaySnackBarMessage('Please enter a valid LinkedIn URL', context);
      return false;
    }
    if (languagesController.text.trim().isEmpty) {
      displaySnackBarMessage('Languages cannot be empty', context);
      return false;
    }
    if (experienceYearsController.text.trim().isEmpty ||
        int.tryParse(experienceYearsController.text) == null) {
      displaySnackBarMessage('Years of experience must be a number', context);
      return false;
    }
    return true;
  }

  Future<void> _updateCounsellorDetails() async {
    if (!_validateFields()) {
      return;
    }

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(currentUser.uid)
          .update({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'bio': bioController.text.trim(),
        'education': educationController.text.trim(),
        'jobTitle': jobTitleController.text.trim(),
        'city': cityController.text.trim(),
        'country': selectedCountry,
        'linkedin': linkedinController.text.trim(),
        'languages':
            languagesController.text.split(',').map((e) => e.trim()).toList(),
        'experienceYears': int.tryParse(experienceYearsController.text) ?? 0,
        'profilePic': profilePicUrl,
      });

      _showDialog('Success', 'Profile updated successfully', true);
    } catch (e) {
      _showDialog('Error', 'Failed to update profile', false);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadImage();
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    String fileName = '${user.uid}_profile_pic.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_pics/$fileName');

    UploadTask uploadTask = storageReference.putFile(_image!);
    await uploadTask.whenComplete(() async {
      String downloadURL = await storageReference.getDownloadURL();
      setState(() {
        profilePicUrl = downloadURL;
        _firestoreService.updateMemberDetails({
          'profilePic': downloadURL,
        });
      });
    });
  }

  void _showDialog(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isSuccess
                    ? Icon(Icons.check_circle, size: 50, color: Colors.green)
                    : Icon(Icons.cancel, size: 50, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  isSuccess ? 'Success' : 'Failure',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (isSuccess) {
                        Get.back(result: true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSuccess ? Colors.green : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      isSuccess ? 'CONTINUE' : 'TRY AGAIN',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      child: profilePicUrl != null && profilePicUrl!.isNotEmpty
                          ? Image.network(
                              profilePicUrl!,
                              fit: BoxFit.cover,
                            )
                          : const Image(
                              image: AssetImage(
                                  'assets/images/default_profile.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
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
                    EditProfileTextField(
                      labelText: 'Education',
                      prefixIcon: Icons.school,
                      controller: educationController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Job Title',
                      prefixIcon: Icons.work,
                      controller: jobTitleController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'City',
                      prefixIcon: Icons.location_city,
                      controller: cityController,
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
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'LinkedIn',
                      prefixIcon: Icons.link,
                      controller: linkedinController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Languages (comma-separated)',
                      prefixIcon: Icons.language,
                      controller: languagesController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Years of Experience',
                      prefixIcon: Icons.timeline,
                      controller: experienceYearsController,
                    ),
                    const SizedBox(height: 30),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isDataChanged ? _updateCounsellorDetails : null,
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


// add specialization field to edit and enable save changes button to track profile pic and country
// UpdateCounsellorProfileScreen
// UpdateCounsellorProfileScreen
// UpdateCounsellorProfileScreen

// UpdateCounsellorProfileScreen

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'dart:io';
// import 'package:mental_wellness_app/util/edit_profile_textfield.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/widgets/specialization_selection.dart'; // Correct import for MultiSelect widget

// class UpdateCounsellorProfileScreen extends StatefulWidget {
//   const UpdateCounsellorProfileScreen({Key? key}) : super(key: key);

//   @override
//   _UpdateCounsellorProfileScreenState createState() =>
//       _UpdateCounsellorProfileScreenState();
// }

// class _UpdateCounsellorProfileScreenState
//     extends State<UpdateCounsellorProfileScreen> {
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController bioController = TextEditingController();
//   final TextEditingController educationController = TextEditingController();
//   final TextEditingController jobTitleController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController linkedinController = TextEditingController();
//   final TextEditingController languagesController = TextEditingController();
//   final TextEditingController experienceYearsController =
//       TextEditingController();

//   final FirestoreService _firestoreService = FirestoreService();
//   late String joinedDate = '';
//   String? selectedCountry;
//   bool isDataChanged = false;
//   String? profilePicUrl;
//   File? _image;

//   String? initialFirstName;
//   String? initialLastName;
//   String? initialBio;
//   String? initialEducation;
//   String? initialJobTitle;
//   String? initialCity;
//   String? initialCountry;
//   String? initialLinkedin;
//   String? initialLanguages;
//   int? initialExperienceYears;
//   List<String> initialSpecializations = []; // Initialize initialSpecializations

//   final ImagePicker picker = ImagePicker();

//   List<String> specializations = [
//     'Anxiety Disorders',
//     'Depression',
//     'Trauma and PTSD',
//     'Eating Disorders',
//     'Substance Abuse',
//     'Child and Adolescent Issues',
//     'Family Therapy',
//     'Couples Therapy',
//     'Grief Counseling',
//     'OCD',
//     'Bipolar Disorder'
//   ];
//   List<String> selectedSpecializations = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCounsellorData();
//   }

//   Future<void> _loadCounsellorData() async {
//     try {
//       User? currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) return;

//       DocumentSnapshot<Map<String, dynamic>> counsellorDoc =
//           await FirebaseFirestore.instance
//               .collection('counsellors')
//               .doc(currentUser.uid)
//               .get();
//       Map<String, dynamic>? counsellorData = counsellorDoc.data();

//       if (counsellorData != null) {
//         setState(() {
//           firstNameController.text = counsellorData['firstName'] ?? '';
//           lastNameController.text = counsellorData['lastName'] ?? '';
//           bioController.text = counsellorData['bio'] ?? '';
//           educationController.text = counsellorData['education'] ?? '';
//           jobTitleController.text = counsellorData['jobTitle'] ?? '';
//           cityController.text = counsellorData['city'] ?? '';
//           selectedCountry = counsellorData['country'] ?? '';
//           linkedinController.text = counsellorData['linkedin'] ?? '';
//           languagesController.text =
//               (counsellorData['languages'] as List<dynamic>?)?.join(', ') ?? '';
//           experienceYearsController.text =
//               counsellorData['experienceYears']?.toString() ?? '';
//           profilePicUrl = counsellorData['profilePic'] ?? '';
//           selectedSpecializations =
//               List<String>.from(counsellorData['specializations'] ?? []);
//           initialFirstName = firstNameController.text;
//           initialLastName = lastNameController.text;
//           initialBio = bioController.text;
//           initialEducation = educationController.text;
//           initialJobTitle = jobTitleController.text;
//           initialCity = cityController.text;
//           initialCountry = selectedCountry;
//           initialLinkedin = linkedinController.text;
//           initialLanguages = languagesController.text;
//           initialExperienceYears = int.tryParse(experienceYearsController.text);
//           initialSpecializations = List<String>.from(
//               counsellorData['specializations'] ??
//                   []); // Set initial specializations
//           Timestamp joinedAtTimestamp = counsellorData['joinedAt'];
//           DateTime joinedAtDate = joinedAtTimestamp.toDate();
//           joinedDate = DateFormat('dd MMM yyyy').format(joinedAtDate);
//           _setupFieldListeners();
//         });
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load counsellor data');
//     }
//   }

//   void _setupFieldListeners() {
//     firstNameController.addListener(_checkIfDataChanged);
//     lastNameController.addListener(_checkIfDataChanged);
//     bioController.addListener(_checkIfDataChanged);
//     educationController.addListener(_checkIfDataChanged);
//     jobTitleController.addListener(_checkIfDataChanged);
//     cityController.addListener(_checkIfDataChanged);
//     linkedinController.addListener(_checkIfDataChanged);
//     languagesController.addListener(_checkIfDataChanged);
//     experienceYearsController.addListener(_checkIfDataChanged);
//   }

//   void _checkIfDataChanged() {
//     setState(() {
//       isDataChanged = firstNameController.text != initialFirstName ||
//           lastNameController.text != initialLastName ||
//           bioController.text != initialBio ||
//           educationController.text != initialEducation ||
//           jobTitleController.text != initialJobTitle ||
//           cityController.text != initialCity ||
//           selectedCountry != initialCountry ||
//           linkedinController.text != initialLinkedin ||
//           languagesController.text != initialLanguages ||
//           experienceYearsController.text != initialExperienceYears.toString() ||
//           selectedSpecializations.toString() !=
//               initialSpecializations.toString();
//     });
//   }

//   void _showCountryPicker() {
//     showCountryPicker(
//       context: context,
//       showPhoneCode: false,
//       onSelect: (Country country) {
//         setState(() {
//           selectedCountry = country.name;
//           _checkIfDataChanged();
//         });
//       },
//     );
//   }

//   Future<void> _updateCounsellorDetails() async {
//     if (!validateNameFields(
//         firstNameController.text, lastNameController.text, context)) {
//       return;
//     }
//     try {
//       User? currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) return;

//       await FirebaseFirestore.instance
//           .collection('counsellors')
//           .doc(currentUser.uid)
//           .update({
//         'firstName': firstNameController.text.trim(),
//         'lastName': lastNameController.text.trim(),
//         'bio': bioController.text.trim(),
//         'education': educationController.text.trim(),
//         'jobTitle': jobTitleController.text.trim(),
//         'city': cityController.text.trim(),
//         'country': selectedCountry,
//         'linkedin': linkedinController.text.trim(),
//         'languages':
//             languagesController.text.split(',').map((e) => e.trim()).toList(),
//         'experienceYears': int.tryParse(experienceYearsController.text) ?? 0,
//         'specializations': selectedSpecializations,
//         'profilePic': profilePicUrl,
//       });

//       _showDialog('Success', 'Profile updated successfully', true);
//     } catch (e) {
//       _showDialog('Error', 'Failed to update profile', false);
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _uploadImage();
//       });
//     } else {
//       print('No image selected.');
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_image == null) return;

//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     String fileName = '${user.uid}_profile_pic.jpg';
//     Reference storageReference =
//         FirebaseStorage.instance.ref().child('profile_pics/$fileName');

//     UploadTask uploadTask = storageReference.putFile(_image!);
//     await uploadTask.whenComplete(() async {
//       String downloadURL = await storageReference.getDownloadURL();
//       setState(() {
//         profilePicUrl = downloadURL;
//         _firestoreService.updateMemberDetails({
//           'profilePic': downloadURL,
//         });
//       });
//     });
//   }

//   void _showDialog(String title, String message, bool isSuccess) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 isSuccess
//                     ? Icon(Icons.check_circle, size: 50, color: Colors.green)
//                     : Icon(Icons.cancel, size: 50, color: Colors.red),
//                 const SizedBox(height: 20),
//                 Text(
//                   isSuccess ? 'Success' : 'Failure',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: isSuccess ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       if (isSuccess) {
//                         Get.back(result: true);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isSuccess ? Colors.green : Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Text(
//                       isSuccess ? 'CONTINUE' : 'TRY AGAIN',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
//         title: Text('Edit Profile',
//             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   color: Colors.white,
//                 )),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             children: [
//               // -- IMAGE with ICON
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     height: 120,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: profilePicUrl != null && profilePicUrl!.isNotEmpty
//                           ? Image.network(
//                               profilePicUrl!,
//                               fit: BoxFit.cover,
//                             )
//                           : const Image(
//                               image: AssetImage(
//                                   'assets/images/default_profile.png'),
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         width: 35,
//                         height: 35,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: Colors.indigo[500]),
//                         child: const Icon(Icons.camera_alt,
//                             color: Colors.white, size: 20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),

//               // -- Form Fields
//               Form(
//                 child: Column(
//                   children: [
//                     EditProfileTextField(
//                       labelText: 'First Name',
//                       prefixIcon: Icons.person,
//                       controller: firstNameController,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'Last Name',
//                       prefixIcon: Icons.person,
//                       controller: lastNameController,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'Bio',
//                       prefixIcon: Icons.description,
//                       controller: bioController,
//                       maxLines: 5,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'Education',
//                       prefixIcon: Icons.school,
//                       controller: educationController,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'Job Title',
//                       prefixIcon: Icons.work,
//                       controller: jobTitleController,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'City',
//                       prefixIcon: Icons.location_city,
//                       controller: cityController,
//                     ),
//                     const SizedBox(height: 10),

//                     // Country Picker
//                     GestureDetector(
//                       onTap: _showCountryPicker,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 20),
//                         decoration: BoxDecoration(
//                           color: Colors.indigo[700],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.location_on, color: Colors.white),
//                             const SizedBox(width: 10),
//                             Text(
//                               selectedCountry?.isNotEmpty == true
//                                   ? selectedCountry!
//                                   : 'Select Country',
//                               style: const TextStyle(color: Colors.white70),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'LinkedIn',
//                       prefixIcon: Icons.link,
//                       controller: linkedinController,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'Languages (comma-separated)',
//                       prefixIcon: Icons.language,
//                       controller: languagesController,
//                     ),
//                     const SizedBox(height: 10),
//                     EditProfileTextField(
//                       labelText: 'Years of Experience',
//                       prefixIcon: Icons.timeline,
//                       controller: experienceYearsController,
//                     ),
//                     const SizedBox(height: 10),

//                     MultiSelect(
//                       items: specializations,
//                       initialSelectedItems: selectedSpecializations,
//                       onSaved: (value) {
//                         setState(() {
//                           selectedSpecializations = value ?? [];
//                           _checkIfDataChanged();
//                         });
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select at least one specialization';
//                         }
//                         return null;
//                       },
//                       context: context,
//                     ),
//                     const SizedBox(height: 30),

//                     // -- Form Submit Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed:
//                             isDataChanged ? _updateCounsellorDetails : null,
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 isDataChanged ? Colors.amber : Colors.grey,
//                             side: BorderSide.none,
//                             shape: const StadiumBorder()),
//                         child: const Text('Save Changes',
//                             style: TextStyle(color: Colors.indigo)),
//                       ),
//                     ),
//                     const SizedBox(height: 30),

//                     // -- Created Date
//                     Row(
//                       children: [
//                         Text.rich(
//                           TextSpan(
//                             text: 'Joined ',
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.white),
//                             children: [
//                               TextSpan(
//                                   text: joinedDate,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12))
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
