// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';

// class CounsellorRegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   CounsellorRegisterScreen({super.key, required this.onTap});
//   @override
//   State<CounsellorRegisterScreen> createState() =>
//       _CounsellorRegisterScreenState();
// }

// class _CounsellorRegisterScreenState extends State<CounsellorRegisterScreen> {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final bioController = TextEditingController();
//   final qualificationsController = TextEditingController();
//   final locationController = TextEditingController();
//   final countryController = TextEditingController();
//   final specializationsController = TextEditingController();
//   final languagesController = TextEditingController();
//   final experienceYearsController = TextEditingController();
//   final certificationsController = TextEditingController();

//   String capitalize(String name) {
//     return name.split(' ').map((word) {
//       if (word.isNotEmpty) {
//         return word[0].toUpperCase() + word.substring(1).toLowerCase();
//       } else {
//         return '';
//       }
//     }).join(' ');
//   }

//   void registerCounsellor() async {
//     if (!validateNameFields(
//         firstNameController.text, lastNameController.text, context)) {
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );

//     if (passwordController.text != confirmPasswordController.text) {
//       Navigator.pop(context);
//       displayErrorMessage("Passwords don't match", context);
//     } else {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );

//         await FirestoreService().createCounsellorDocument(userCredential);

//         if (mounted) Navigator.pop(context);
//       } on FirebaseAuthException catch (e) {
//         if (mounted) Navigator.pop(context);

//         if (e.code == 'weak-password') {
//           displayErrorMessage("The password provided is too weak.", context);
//         } else if (e.code == 'email-already-in-use') {
//           displayErrorMessage(
//               "The account already exists for that email.", context);
//         } else {
//           displayErrorMessage("An error occurred: ${e.message}", context);
//         }
//       } catch (e) {
//         if (mounted) Navigator.pop(context);
//         displayErrorMessage("An error occurred. Please try again.", context);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 35),
//                 const Icon(
//                   Icons.lock,
//                   size: 60,
//                 ),
//                 const SizedBox(height: 5),
//                 Center(
//                   child: Text(
//                     'Create your account',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 MyTextField(
//                   controller: firstNameController,
//                   hintText: 'First Name',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: lastNameController,
//                   hintText: 'Last Name',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Email',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: confirmPasswordController,
//                   hintText: 'Confirm Password',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: bioController,
//                   hintText: 'Bio',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: qualificationsController,
//                   hintText: 'Qualifications',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: locationController,
//                   hintText: 'Location',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: countryController,
//                   hintText: 'Country',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: specializationsController,
//                   hintText: 'Specializations (comma-separated)',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: languagesController,
//                   hintText: 'Languages (comma-separated)',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: experienceYearsController,
//                   hintText: 'Years of Experience',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: certificationsController,
//                   hintText: 'Certifications (comma-separated)',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 25),
//                 MyButton(text: "Sign Up", onTap: () => registerCounsellor()),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Already a member?',
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                     const SizedBox(width: 4),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: const Text('Login now',
//                           style: TextStyle(
//                               color: Colors.blue, fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CounsellorRegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   final Function()? onSwitchRole;

//   CounsellorRegisterScreen(
//       {super.key, required this.onTap, required this.onSwitchRole});

//   @override
//   State<CounsellorRegisterScreen> createState() =>
//       _CounsellorRegisterScreenState();
// }

// class _CounsellorRegisterScreenState extends State<CounsellorRegisterScreen> {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   String capitalize(String name) {
//     return name.split(' ').map((word) {
//       if (word.isNotEmpty) {
//         return word[0].toUpperCase() + word.substring(1).toLowerCase();
//       } else {
//         return '';
//       }
//     }).join(' ');
//   }

//   void registerUser() async {
//     if (!validateNameFields(
//         firstNameController.text, lastNameController.text, context)) {
//       return;
//     }

//     // show loading circle
//     showDialog(
//       context: context,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );

//     if (passwordController.text != confirmPasswordController.text) {
//       Navigator.pop(context);
//       displayErrorMessage("Passwords don't match", context);
//     } else {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );

//         await createUserDocument(userCredential);

//         await FirestoreService().updateDailyRoutine();

//         if (mounted) Navigator.pop(context);
//       } on FirebaseAuthException catch (e) {
//         if (mounted) Navigator.pop(context);

//         if (e.code == 'weak-password') {
//           displayErrorMessage("The password provided is too weak.", context);
//         } else if (e.code == 'email-already-in-use') {
//           displayErrorMessage(
//               "The account already exists for that email.", context);
//         } else {
//           displayErrorMessage("An error occurred: ${e.message}", context);
//         }
//       } catch (e) {
//         if (mounted) Navigator.pop(context);
//         displayErrorMessage("An error occurred. Please try again.", context);
//       }
//     }
//   }

//   Future<void> createUserDocument(UserCredential? userCredential) async {
//     if (userCredential != null && userCredential.user != null) {
//       await FirebaseFirestore.instance
//           .collection("Members")
//           .doc(userCredential.user!.uid)
//           .set({
//         'memberId': userCredential.user!.uid,
//         'email': userCredential.user!.email,
//         'firstName': capitalize(firstNameController.text.trim()),
//         'lastName': capitalize(lastNameController.text.trim()),
//         'profilePic': '',
//         'bio': '',
//         'country': '',
//         'level': 1,
//         'points': 0,
//         'dailyStreak': 0,
//         'meditationsCompleted': 0,
//         'breathingsCompleted': 0,
//         'soundsCompleted': 0,
//         'friendsAdded': 0,
//         'encouragingMessagesSent': 0,
//         'totalDailyNotes': 0,
//         'totalMoodEntries': 0,
//         'createdAt': Timestamp.now(),
//         'lastActive': Timestamp.now(),
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: constraints.maxHeight,
//                 ),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             const SizedBox(height: 35),
//                             const Icon(
//                               Icons.lock,
//                               size: 60,
//                             ),
//                             const SizedBox(height: 5),
//                             Center(
//                               child: Text(
//                                 'Create your account',
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             MyTextField(
//                               controller: firstNameController,
//                               hintText: 'First Name',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: lastNameController,
//                               hintText: 'Last Name',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: emailController,
//                               hintText: 'Email',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: passwordController,
//                               hintText: 'Password',
//                               obscureText: true,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: confirmPasswordController,
//                               hintText: 'Confirm Password',
//                               obscureText: true,
//                             ),
//                             const SizedBox(height: 25),
//                             MyButton(
//                                 text: "Sign Up", onTap: () => registerUser()),
//                             const SizedBox(height: 20),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 25.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Divider(
//                                       thickness: 0.5,
//                                       color: Colors.grey[400],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 10.0),
//                                     child: Text('Or continue with',
//                                         style:
//                                             TextStyle(color: Colors.grey[700])),
//                                   ),
//                                   Expanded(
//                                     child: Divider(
//                                       thickness: 0.5,
//                                       color: Colors.grey[400],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Already a member?',
//                                   style: TextStyle(color: Colors.grey[700]),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 GestureDetector(
//                                   onTap: widget.onTap,
//                                   child: const Text(
//                                     'Login now',
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: widget.onSwitchRole,
//                           child: const Text(
//                             'Switch to Member Register',
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';
// import 'package:mental_wellness_app/views/counsellor/counsellor_home_screen.dart';
// import 'package:mental_wellness_app/widgets/specialization_selection.dart';

// class CounsellorRegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   final Function()? onSwitchRole;

//   CounsellorRegisterScreen(
//       {super.key, required this.onTap, required this.onSwitchRole});

//   @override
//   State<CounsellorRegisterScreen> createState() =>
//       _CounsellorRegisterScreenState();
// }

// class _CounsellorRegisterScreenState extends State<CounsellorRegisterScreen> {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final bioController = TextEditingController();
//   final qualificationsController = TextEditingController();
//   final locationController = TextEditingController();
//   final countryController = TextEditingController();
//   final languagesController = TextEditingController();
//   final experienceYearsController = TextEditingController();
//   final certificationsController = TextEditingController();

//   // Dropdown list for specializations
//   final List<String> specializations = [
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

//   String capitalize(String name) {
//     return name.split(' ').map((word) {
//       if (word.isNotEmpty) {
//         return word[0].toUpperCase() + word.substring(1).toLowerCase();
//       } else {
//         return '';
//       }
//     }).join(' ');
//   }

//   void registerCounsellor() async {
//     if (!validateNameFields(
//         firstNameController.text, lastNameController.text, context)) {
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );

//     if (passwordController.text != confirmPasswordController.text) {
//       Navigator.pop(context);
//       displayErrorMessage("Passwords don't match", context);
//     } else {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );

//         await FirestoreService().createCounsellorDocument(userCredential);

//         if (mounted) {
//           Navigator.pop(context);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CounsellorHomeScreen.instance),
//           );
//         }
//       } on FirebaseAuthException catch (e) {
//         if (mounted) Navigator.pop(context);

//         if (e.code == 'weak-password') {
//           displayErrorMessage("The password provided is too weak.", context);
//         } else if (e.code == 'email-already-in-use') {
//           displayErrorMessage(
//               "The account already exists for that email.", context);
//         } else {
//           displayErrorMessage("An error occurred: ${e.message}", context);
//         }
//       } catch (e) {
//         if (mounted) Navigator.pop(context);
//         displayErrorMessage("An error occurred. Please try again.", context);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: constraints.maxHeight,
//                 ),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             const SizedBox(height: 35),
//                             const Icon(
//                               Icons.lock,
//                               size: 60,
//                             ),
//                             const SizedBox(height: 5),
//                             Center(
//                               child: Text(
//                                 'Create your account',
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             MyTextField(
//                               controller: firstNameController,
//                               hintText: 'First Name',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: lastNameController,
//                               hintText: 'Last Name',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: emailController,
//                               hintText: 'Email',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: passwordController,
//                               hintText: 'Password',
//                               obscureText: true,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: confirmPasswordController,
//                               hintText: 'Confirm Password',
//                               obscureText: true,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: bioController,
//                               hintText: 'Bio',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: qualificationsController,
//                               hintText: 'Qualifications',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: locationController,
//                               hintText: 'Location',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: countryController,
//                               hintText: 'Country',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MultiSelect(
//                               items: specializations,
//                               initialSelectedItems: selectedSpecializations,
//                               onSaved: (value) {
//                                 selectedSpecializations = value ?? [];
//                               },
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select at least one specialization';
//                                 }
//                                 return null;
//                               },
//                               context: context,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: languagesController,
//                               hintText: 'Languages (comma-separated)',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: experienceYearsController,
//                               hintText: 'Years of Experience',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 10),
//                             MyTextField(
//                               controller: certificationsController,
//                               hintText: 'Certifications (comma-separated)',
//                               obscureText: false,
//                             ),
//                             const SizedBox(height: 25),
//                             MyButton(
//                                 text: "Sign Up",
//                                 onTap: () => registerCounsellor()),
//                             const SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Already a member?',
//                                   style: TextStyle(color: Colors.grey[700]),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 GestureDetector(
//                                   onTap: widget.onTap,
//                                   child: const Text('Login now',
//                                       style: TextStyle(
//                                           color: Colors.blue,
//                                           fontWeight: FontWeight.bold)),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: widget.onSwitchRole,
//                           child: const Text(
//                             'Switch to Member Register',
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// register counsellor actually takes all input and creates doc with those values
// counsellor_register_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/util/my_button.dart';
import 'package:mental_wellness_app/util/my_textfield.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_home_screen.dart';
import 'package:mental_wellness_app/widgets/specialization_selection.dart';

class CounsellorRegisterScreen extends StatefulWidget {
  final Function()? onTap;
  final Function()? onSwitchRole;

  CounsellorRegisterScreen(
      {super.key, required this.onTap, required this.onSwitchRole});

  @override
  State<CounsellorRegisterScreen> createState() =>
      _CounsellorRegisterScreenState();
}

class _CounsellorRegisterScreenState extends State<CounsellorRegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  final educationController =
      TextEditingController(); // Previously qualifications
  final cityController = TextEditingController(); // Previously location
  final countryController = TextEditingController();
  final languagesController = TextEditingController();
  final experienceYearsController = TextEditingController();
  final linkedinController = TextEditingController(); // LinkedIn field
  final jobTitleController = TextEditingController(); // Job title field

  // Dropdown list for specializations
  final List<String> specializations = [
    'Anxiety Disorders',
    'Depression',
    'Trauma and PTSD',
    'Eating Disorders',
    'Substance Abuse',
    'Child and Adolescent Issues',
    'Family Therapy',
    'Couples Therapy',
    'Grief Counseling',
    'OCD',
    'Bipolar Disorder'
  ];
  List<String> selectedSpecializations = [];

  // Dropdown list for titles
  final List<String> titles = [
    'Dr',
    'Prof',
    'Mr',
    'Ms',
    'Mrs',
  ];
  String? selectedTitle;

  String capitalize(String name) {
    return name.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return '';
      }
    }).join(' ');
  }

  void registerCounsellor() async {
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return;
    }

    if (!validateCounsellorFields(
      bio: bioController.text,
      education: educationController.text,
      city: cityController.text,
      country: countryController.text,
      languages: languagesController.text,
      experienceYears: experienceYearsController.text,
      context: context,
    )) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayErrorMessage("Passwords don't match", context);
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        await FirestoreService().createCounsellorDocument(
          userCredential,
          selectedTitle,
          firstNameController.text,
          lastNameController.text,
          bioController.text,
          educationController.text,
          cityController.text,
          countryController.text,
          languagesController.text.split(',').map((e) => e.trim()).toList(),
          int.parse(experienceYearsController.text),
          linkedinController.text,
          selectedSpecializations,
          jobTitleController.text,
        );

        if (mounted) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CounsellorHomeScreen.instance),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) Navigator.pop(context);

        if (e.code == 'weak-password') {
          displayErrorMessage("The password provided is too weak.", context);
        } else if (e.code == 'email-already-in-use') {
          displayErrorMessage(
              "The account already exists for that email.", context);
        } else {
          displayErrorMessage("An error occurred: ${e.message}", context);
        }
      } catch (e) {
        if (mounted) Navigator.pop(context);
        displayErrorMessage("An error occurred. Please try again.", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 35),
                            const Icon(
                              Icons.lock,
                              size: 60,
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                'Create your account',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: DropdownButtonFormField<String>(
                                value: selectedTitle,
                                items: titles.map((String title) {
                                  return DropdownMenuItem<String>(
                                    value: title,
                                    child: Text(title),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedTitle = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: 'Title',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 20.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: firstNameController,
                              hintText: 'First Name',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: lastNameController,
                              hintText: 'Last Name',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm Password',
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: bioController,
                              hintText: 'Bio',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: educationController,
                              hintText: 'Education',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: cityController,
                              hintText: 'City',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: countryController,
                              hintText: 'Country',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: jobTitleController,
                              hintText: 'Job Title',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MultiSelect(
                              items: specializations,
                              initialSelectedItems: selectedSpecializations,
                              onSaved: (value) {
                                selectedSpecializations = value ?? [];
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select at least one specialization';
                                }
                                return null;
                              },
                              context: context,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: languagesController,
                              hintText: 'Languages (comma-separated)',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: experienceYearsController,
                              hintText: 'Years of Experience',
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: linkedinController,
                              hintText: 'LinkedIn Profile',
                              obscureText: false,
                            ),
                            const SizedBox(height: 25),
                            MyButton(
                                text: "Sign Up",
                                onTap: () => registerCounsellor()),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already a counsellor?',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text('Login now',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: widget.onSwitchRole,
                        //   child: const Text(
                        //     'Switch to Member Register',
                        //     style: TextStyle(
                        //       color: Colors.blue,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
