import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/util/login_icon_tile.dart';
import 'package:mental_wellness_app/util/my_button.dart';
import 'package:mental_wellness_app/util/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  RegisterScreen({super.key, required this.onTap});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // removed const due to we have text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
    // // Validate first and last name inputs
    // if (!validateNameInputs()) {
    //   return;
    // }
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return;
    }

    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error message to user
      displayErrorMessage("Passwords don't match", context);
    } else {
      try {
        // create the user in Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // if (context.mounted) Navigator.pop(context);

        // create user document which acts as user account and add to firestore
        await createUserDocument(userCredential);

        // Update routine after successful registration
        print("Updating routine after registration...");
        await FirestoreService().updateDailyRoutine();
        print("Routine updated successfully!");

        // pop loading circle
        if (mounted) Navigator.pop(context);

        // Further actions after successful registration (e.g., navigate to a new page)
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

  // create user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Members")
          .doc(userCredential.user!.uid)
          .set({
        // Identification and basic info
        'memberId':
            userCredential.user!.uid, // Unique identifier for the member
        'email': userCredential.user!.email,

        // Profile details
        'firstName': capitalize(firstNameController.text.trim()),
        'lastName': capitalize(lastNameController.text.trim()),
        'profilePic': '',
        'bio': '',
        'country': '',

        // Progress and statistics
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

        // Timestamp
        'createdAt': Timestamp.now(),
        'lastActive': Timestamp.now(),
      });
    }
  }

  void wrongEmailMsg() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Incorrect Email',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void wrongPasswordMsg() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Incorrect Password',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void invalidCredsMsg() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Invalid Credentials',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),

                // logo
                const Icon(
                  Icons.lock,
                  size: 60,
                ),

                const SizedBox(height: 5),

                //welcome back
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

                //first name textfield
                MyTextField(
                  controller: firstNameController,
                  hintText: ' First Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //last name textfield
                MyTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //sign in btn
                // MyButton(onTap: () => signUserIn(context)),
                MyButton(text: "Sign Up", onTap: () => registerUser()),

                const SizedBox(height: 20),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Or continue with',
                          style: TextStyle(color: Colors.grey[700])),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ]),
                ),

                // const SizedBox(height: 20),

                // // google + apple sign in buttons
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SquareTile(imagePath: 'lib/images/google.png'),
                //     SizedBox(width: 25),
                //     SquareTile(imagePath: 'lib/images/apple.png'),
                //   ],
                // ),

                const SizedBox(height: 20),

                //not a member? register now
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
                      child: const Text('Login now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
