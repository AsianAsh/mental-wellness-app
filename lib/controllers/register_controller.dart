// controllers/register_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/views/login_screen.dart';

class RegisterController {
  final FirestoreService _firestoreService = FirestoreService();

  void registerUser(
    BuildContext context,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    Function() onSwitchRole,
  ) async {
    if (!validateNameFields(
        firstNameController.text, lastNameController.text, context)) {
      return;
    }

    if (!validateMemberFields(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      context: context,
    )) {
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Show a dialog informing the user to verify their email
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Verify your email'),
          content: Text(
              'A verification link will be sent to your email. Please verify your email before logging in.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // User? user = userCredential.user;
                // await user?.sendEmailVerification();

                await _firestoreService.createMemberDocument(
                    userCredential,
                    firstNameController.text.trim(),
                    lastNameController.text.trim());

                await _firestoreService.updateDailyRoutine();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      onTap: () => onSwitchRole(),
                      onSwitchRole: onSwitchRole,
                    ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displaySnackBarMessage("The password provided is too weak.", context);
      } else if (e.code == 'email-already-in-use') {
        displaySnackBarMessage(
            "The account already exists for that email.", context);
      } else {
        displaySnackBarMessage("An error occurred: ${e.message}", context);
      }
    } catch (e) {
      displaySnackBarMessage("An error occurred. Please try again.", context);
    }
  }
}
