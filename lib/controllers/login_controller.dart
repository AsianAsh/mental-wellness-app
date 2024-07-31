// controllers/login_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class LoginController {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> login(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        displaySnackBarMessage(
          'Please verify your email to continue.',
          context,
          backgroundColor: Colors.red,
        );
        await FirebaseAuth.instance.signOut();
        return;
      }

      // Update last active field
      await _firestoreService.updateLastActive();

      // Update daily routine after successful login
      await _firestoreService.updateDailyRoutine();

      // Navigate to home page
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      handleAuthError(context, e);
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
}
