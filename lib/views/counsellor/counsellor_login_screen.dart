import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/widgets/my_button.dart';
import 'package:mental_wellness_app/widgets/my_textfield.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_home_screen.dart';

class CounsellorLoginScreen extends StatefulWidget {
  final Function()? onTap;
  final Function()? onSwitchRole;

  const CounsellorLoginScreen(
      {super.key, required this.onTap, required this.onSwitchRole});

  @override
  State<CounsellorLoginScreen> createState() => _CounsellorLoginScreenState();
}

class _CounsellorLoginScreenState extends State<CounsellorLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    bool loginSuccess = false;

    try {
      print("Test 1");
      printCurrentUserDetails();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("Test 2");
      printCurrentUserDetails();
      await FirestoreService().updateLastActive();
      print("Test 3");
      printCurrentUserDetails();

      loginSuccess = true;
    } on FirebaseAuthException catch (e) {
      handleAuthError(context, e);
    }

    if (mounted) {
      Navigator.pop(context); // Dismiss the loading circle

      if (loginSuccess) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentSnapshot counsellorDoc = await FirebaseFirestore.instance
              .collection('counsellors')
              .doc(user.uid)
              .get();
          if (counsellorDoc.exists) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CounsellorHomeScreen.instance),
            );
          } else {
            displaySnackBarMessage("Not a registered counsellor", context);
          }
        }
      }
    }
  }

  void handleAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage;
    print(e.code);
    switch (e.code) {
      case 'channel-error':
        errorMessage = 'Please fill in all fields.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'invalid-credential':
        errorMessage = 'Login credentials are not valid.';
        break;
      case 'user-disabled':
        errorMessage = 'This user has been disabled.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Try again later.';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Email and password sign-in is not enabled.';
        break;
      default:
        errorMessage = 'An unexpected error occurred. Please try again.';
    }

    displaySnackBarMessage(errorMessage, context, backgroundColor: Colors.red);
  }

  void printCurrentUserDetails() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('User ID: ${user.uid}');
      print('Email: ${user.email}');
      print('Display Name: ${user.displayName}');
      print('Photo URL: ${user.photoURL}');
      print('Email Verified: ${user.emailVerified}');
    } else {
      print('No user is currently logged in.');
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
                              size: 90,
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: Text(
                                'Counsellor Login',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            MyButton(text: "Sign In", onTap: () => login()),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Want to Register as Counsellor?',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    'Register now',
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
                        GestureDetector(
                          onTap: widget.onSwitchRole,
                          child: const Text(
                            'Switch to Member Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
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
