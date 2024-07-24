// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   RegisterScreen({super.key, required this.onTap});
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
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
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 35),
//                   const Icon(
//                     Icons.lock,
//                     size: 60,
//                   ),
//                   const SizedBox(height: 5),
//                   Center(
//                     child: Text(
//                       'Create your account',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   MyTextField(
//                     controller: firstNameController,
//                     hintText: ' First Name',
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: lastNameController,
//                     hintText: 'Last Name',
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: emailController,
//                     hintText: 'Email',
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: passwordController,
//                     hintText: 'Password',
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: confirmPasswordController,
//                     hintText: 'Confirm Password',
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 25),
//                   MyButton(text: "Sign Up", onTap: () => registerUser()),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text('Or continue with',
//                             style: TextStyle(color: Colors.grey[700])),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ]),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Already a member?',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                         onTap: widget.onTap,
//                         child: const Text('Login now',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// counsellor option
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   final Function()? onSwitchRole;

//   RegisterScreen({super.key, required this.onTap, required this.onSwitchRole});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
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
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 35),
//                   const Icon(
//                     Icons.lock,
//                     size: 60,
//                   ),
//                   const SizedBox(height: 5),
//                   Center(
//                     child: Text(
//                       'Create your account',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   MyTextField(
//                     controller: firstNameController,
//                     hintText: ' First Name',
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: lastNameController,
//                     hintText: 'Last Name',
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: emailController,
//                     hintText: 'Email',
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: passwordController,
//                     hintText: 'Password',
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 10),
//                   MyTextField(
//                     controller: confirmPasswordController,
//                     hintText: 'Confirm Password',
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 25),
//                   MyButton(text: "Sign Up", onTap: () => registerUser()),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text('Or continue with',
//                             style: TextStyle(color: Colors.grey[700])),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                     ]),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Already a member?',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                         onTap: widget.onTap,
//                         child: const Text('Login now',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: widget.onSwitchRole,
//                     child: const Text(
//                       'Switch to Counsellor Register',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
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

// class RegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   final Function()? onSwitchRole;

//   RegisterScreen({super.key, required this.onTap, required this.onSwitchRole});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
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
//                             'Switch to Counsellor Register',
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

// with code to create routine field
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';
// import 'package:mental_wellness_app/home_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RegisterScreen extends StatefulWidget {
//   final Function()? onTap;
//   final Function()? onSwitchRole;

//   RegisterScreen({super.key, required this.onTap, required this.onSwitchRole});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final FirestoreService firestoreService = FirestoreService();

//   String capitalize(String name) {
//     return name.split(' ').map((word) {
//       if (word.isNotEmpty) {
//         return word[0].toUpperCase() + word.substring(1).toLowerCase();
//       } else {
//         return '';
//       }
//     }).join(' ');
//   }

//   // void registerUser() async {
//   //   if (!validateNameFields(
//   //       firstNameController.text, lastNameController.text, context)) {
//   //     return;
//   //   }

//   //   // show loading circle
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => const Center(
//   //       child: CircularProgressIndicator(),
//   //     ),
//   //   );

//   //   if (passwordController.text != confirmPasswordController.text) {
//   //     Navigator.pop(context);
//   //     displayErrorMessage("Passwords don't match", context);
//   //   } else {
//   //     try {
//   //       UserCredential userCredential =
//   //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//   //         email: emailController.text,
//   //         password: passwordController.text,
//   //       );

//   //       await createUserDocument(userCredential);

//   //       await firestoreService.updateDailyRoutine();

//   //       if (mounted) {
//   //         Navigator.pop(context);
//   //         Navigator.pushReplacement(
//   //           context,
//   //           MaterialPageRoute(builder: (context) => HomePage.instance),
//   //         );
//   //       }
//   //     } on FirebaseAuthException catch (e) {
//   //       if (mounted) Navigator.pop(context);

//   //       if (e.code == 'weak-password') {
//   //         displayErrorMessage("The password provided is too weak.", context);
//   //       } else if (e.code == 'email-already-in-use') {
//   //         displayErrorMessage(
//   //             "The account already exists for that email.", context);
//   //       } else {
//   //         displayErrorMessage("An error occurred: ${e.message}", context);
//   //       }
//   //     } catch (e) {
//   //       if (mounted) Navigator.pop(context);
//   //       displayErrorMessage("An error occurred. Please try again.", context);
//   //     }
//   //   }
//   // }

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

//         // Send email verification
//         User? user = userCredential.user;
//         await user?.sendEmailVerification();

//         await createUserDocument(userCredential);

//         await firestoreService.updateDailyRoutine();

//         if (mounted) {
//           Navigator.pop(context);
//           // Show a dialog or navigate to a screen that informs the user to verify their email
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Verify your email'),
//               content: Text(
//                   'A verification link has been sent to your email. Please verify your email before logging in.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context); // Dismiss the dialog
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => HomePage.instance),
//                     );
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
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
//         // No need to add routine here as it will be added by updateDailyRoutine
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
//                             // const SizedBox(height: 20),
//                             // Padding(
//                             //   padding:
//                             //       const EdgeInsets.symmetric(horizontal: 25.0),
//                             //   child: Row(
//                             //     children: [
//                             //       Expanded(
//                             //         child: Divider(
//                             //           thickness: 0.5,
//                             //           color: Colors.grey[400],
//                             //         ),
//                             //       ),
//                             //       Padding(
//                             //         padding: const EdgeInsets.symmetric(
//                             //             horizontal: 10.0),
//                             //         child: Text('Or continue with',
//                             //             style:
//                             //                 TextStyle(color: Colors.grey[700])),
//                             //       ),
//                             //       Expanded(
//                             //         child: Divider(
//                             //             thickness: 0.5,
//                             //             color: Colors.grey[400]),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
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
//                         // GestureDetector(
//                         //   onTap: widget.onSwitchRole,
//                         //   child: const Text(
//                         //     'Switch to Counsellor Register',
//                         //     style: TextStyle(
//                         //       color: Colors.blue,
//                         //       fontWeight: FontWeight.bold,
//                         //     ),
//                         //   ),
//                         // ),
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

// with fix to loading circle by replacing it and implement verify email
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/util/my_button.dart';
import 'package:mental_wellness_app/util/my_textfield.dart';
import 'package:mental_wellness_app/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_wellness_app/views/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  final Function()? onSwitchRole;

  RegisterScreen({super.key, required this.onTap, required this.onSwitchRole});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
  bool _isLoading = false;

  String capitalize(String name) {
    return name.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return '';
      }
    }).join(' ');
  }

  void registerUser() async {
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      displayErrorMessage("Passwords don't match", context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Show a dialog informing the user to verify their email
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevents the dialog from being dismissed without user interaction
        builder: (context) => AlertDialog(
          title: Text('Verify your email'),
          content: Text(
              'A verification link will be sent to your email. Please verify your email before logging in.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Dismiss the dialog

                // Send email verification
                User? user = userCredential.user;
                await user?.sendEmailVerification();

                await createUserDocument(userCredential);

                await firestoreService.updateDailyRoutine();

                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        onTap: widget.onTap,
                        onSwitchRole: widget.onSwitchRole,
                      ),
                    ),
                  );
                }
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      if (e.code == 'weak-password') {
        displayErrorMessage("The password provided is too weak.", context);
      } else if (e.code == 'email-already-in-use') {
        displayErrorMessage(
            "The account already exists for that email.", context);
      } else {
        displayErrorMessage("An error occurred: ${e.message}", context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      displayErrorMessage("An error occurred. Please try again.", context);
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Members")
          .doc(userCredential.user!.uid)
          .set({
        'memberId': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'firstName': capitalize(firstNameController.text.trim()),
        'lastName': capitalize(lastNameController.text.trim()),
        'profilePic': '',
        'bio': '',
        'country': '',
        'level': 1,
        'points': 0,
        'dailyStreak': 0,
        'meditationsCompleted': 0,
        'breathingsCompleted': 0,
        'soundsCompleted': 0,
        'friendsAdded': 0,
        'encouragingMessagesSent': 0,
        'totalDailyNotes': 0,
        'totalMoodEntries': 0,
        'createdAt': Timestamp.now(),
        'lastActive': Timestamp.now(),
        // No need to add routine here as it will be added by updateDailyRoutine
      });
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
                    child: Stack(
                      children: [
                        Column(
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
                                const SizedBox(height: 25),
                                MyButton(
                                    text: "Sign Up",
                                    onTap: () => registerUser()),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already a member?',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: widget.onTap,
                                      child: const Text(
                                        'Login now',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (_isLoading)
                          Container(
                            color: Colors.black54,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
