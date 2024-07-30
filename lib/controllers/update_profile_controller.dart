// // controllers/update_profile_controller.dart
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';

// class UpdateProfileController extends GetxController {
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController bioController = TextEditingController();

//   final FirestoreService _firestoreService = FirestoreService();
//   RxString joinedDate = ''.obs;
//   Rx<String?> selectedCountry = Rx<String?>(null);
//   RxBool isDataChanged = false.obs;
//   Rx<String?> profilePicUrl = Rx<String?>(null);
//   Rx<File?> _image = Rx<File?>(null);

//   String? initialFirstName;
//   String? initialLastName;
//   String? initialBio;
//   String? initialCountry;

//   final ImagePicker picker = ImagePicker();

//   @override
//   void onInit() {
//     super.onInit();
//     _loadUserData();
//     _setupFieldListeners();
//   }

//   Future<void> _loadUserData() async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> userDoc =
//           await _firestoreService.getMemberDetails();
//       Map<String, dynamic>? userData = userDoc.data();

//       if (userData != null) {
//         firstNameController.text = userData['firstName'] ?? '';
//         lastNameController.text = userData['lastName'] ?? '';
//         bioController.text = userData['bio'] ?? '';
//         selectedCountry.value = userData['country'] ?? '';
//         profilePicUrl.value = userData['profilePic'] ?? '';
//         initialFirstName = firstNameController.text;
//         initialLastName = lastNameController.text;
//         initialBio = bioController.text;
//         initialCountry = selectedCountry.value;

//         // Ensure createdAt is properly retrieved and formatted
//         if (userData.containsKey('createdAt')) {
//           Timestamp createdAtTimestamp = userData['createdAt'];
//           DateTime createdAtDate = createdAtTimestamp.toDate();
//           joinedDate.value = DateFormat('dd MMM yyyy').format(createdAtDate);
//         } else {
//           joinedDate.value = 'Unknown';
//         }

//         // Check if data has changed to set the initial state of the Save Changes button
//         _checkIfDataChanged();
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to load user data',
//         backgroundColor: Colors.white60,
//       );
//     }
//   }

//   void _setupFieldListeners() {
//     firstNameController.addListener(_checkIfDataChanged);
//     lastNameController.addListener(_checkIfDataChanged);
//     bioController.addListener(_checkIfDataChanged);
//   }

//   void _checkIfDataChanged() {
//     isDataChanged.value = firstNameController.text != initialFirstName ||
//         lastNameController.text != initialLastName ||
//         bioController.text != initialBio ||
//         selectedCountry.value != initialCountry;
//   }

//   void setSelectedCountry(String country) {
//     selectedCountry.value = country;
//     _checkIfDataChanged();
//   }

//   Future<void> updateMemberDetails(BuildContext context) async {
//     if (!validateNameFields(
//         firstNameController.text, lastNameController.text, context)) {
//       return;
//     }
//     try {
//       await _firestoreService.updateMemberDetails({
//         'firstName': firstNameController.text.trim(),
//         'lastName': lastNameController.text.trim(),
//         'bio': bioController.text.trim(),
//         'country': selectedCountry.value,
//         'profilePic': profilePicUrl.value,
//       });
//       _showDialog('Success', 'Profile updated successfully', true);
//     } catch (e) {
//       _showDialog('Error', 'Failed to update profile', false);
//     }
//   }

//   Future<void> pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _image.value = File(pickedFile.path);
//       _uploadImage();
//     } else {
//       print('No image selected.');
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_image.value == null) return;

//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;

//     String fileName = '${user.uid}_profile_pic.jpg';
//     Reference storageReference =
//         FirebaseStorage.instance.ref().child('profile_pics/$fileName');

//     UploadTask uploadTask = storageReference.putFile(_image.value!);
//     await uploadTask.whenComplete(() async {
//       String downloadURL = await storageReference.getDownloadURL();
//       profilePicUrl.value = downloadURL;
//       _firestoreService.updateMemberDetails({
//         'profilePic': downloadURL,
//       });
//     });
//   }

//   void _showDialog(String title, String message, bool isSuccess) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               isSuccess
//                   ? Icon(Icons.check_circle, size: 50, color: Colors.green)
//                   : Icon(Icons.cancel, size: 50, color: Colors.red),
//               const SizedBox(height: 20),
//               Text(
//                 isSuccess ? 'Success' : 'Failure',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: isSuccess ? Colors.green : Colors.red,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.back();
//                     if (isSuccess) {
//                       Get.back(result: true);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: isSuccess ? Colors.green : Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     isSuccess ? 'CONTINUE' : 'TRY AGAIN',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // display latest data
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';

class UpdateProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();
  RxString joinedDate = ''.obs;
  Rx<String?> selectedCountry = Rx<String?>(null);
  RxBool isDataChanged = false.obs;
  Rx<String?> profilePicUrl = Rx<String?>(null);
  Rx<File?> _image = Rx<File?>(null);

  String? initialFirstName;
  String? initialLastName;
  String? initialBio;
  String? initialCountry;

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _setupFieldListeners();
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestoreService.getMemberDetails();
      Map<String, dynamic>? userData = userDoc.data();

      if (userData != null) {
        firstNameController.text = userData['firstName'] ?? '';
        lastNameController.text = userData['lastName'] ?? '';
        bioController.text = userData['bio'] ?? '';
        selectedCountry.value = userData['country'] ?? '';
        profilePicUrl.value = userData['profilePic'] ?? '';
        initialFirstName = firstNameController.text;
        initialLastName = lastNameController.text;
        initialBio = bioController.text;
        initialCountry = selectedCountry.value;

        // Ensure createdAt is properly retrieved and formatted
        if (userData.containsKey('createdAt')) {
          Timestamp createdAtTimestamp = userData['createdAt'];
          DateTime createdAtDate = createdAtTimestamp.toDate();
          joinedDate.value = DateFormat('dd MMM yyyy').format(createdAtDate);
        } else {
          joinedDate.value = 'Unknown';
        }

        // Check if data has changed to set the initial state of the Save Changes button
        _checkIfDataChanged();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data',
        backgroundColor: Colors.white60,
      );
    }
  }

  void _setupFieldListeners() {
    firstNameController.addListener(_checkIfDataChanged);
    lastNameController.addListener(_checkIfDataChanged);
    bioController.addListener(_checkIfDataChanged);
  }

  void _checkIfDataChanged() {
    isDataChanged.value = firstNameController.text != initialFirstName ||
        lastNameController.text != initialLastName ||
        bioController.text != initialBio ||
        selectedCountry.value != initialCountry;
  }

  void setSelectedCountry(String country) {
    selectedCountry.value = country;
    _checkIfDataChanged();
  }

  Future<void> updateMemberDetails(BuildContext context) async {
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return;
    }
    try {
      await _firestoreService.updateMemberDetails({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'bio': bioController.text.trim(),
        'country': selectedCountry.value,
        'profilePic': profilePicUrl.value,
      });
      _showDialog('Success', 'Profile updated successfully', true);
    } catch (e) {
      _showDialog('Error', 'Failed to update profile', false);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
      _uploadImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage() async {
    if (_image.value == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    String fileName = '${user.uid}_profile_pic.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_pics/$fileName');

    UploadTask uploadTask = storageReference.putFile(_image.value!);
    await uploadTask.whenComplete(() async {
      String downloadURL = await storageReference.getDownloadURL();
      profilePicUrl.value = downloadURL;
      _firestoreService.updateMemberDetails({
        'profilePic': downloadURL,
      });
    });
  }

  void _showDialog(String title, String message, bool isSuccess) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    Get.back();
                    if (isSuccess) {
                      Get.back(result: true); // Return true on success
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
      ),
    );
  }
}
