import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/home_page.dart';
import 'package:mental_wellness_app/auth/login_or_register_screen.dart';
import 'package:mental_wellness_app/views/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          // Constantly listening to auth state changes (If user logged in or not)
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if user logged in
            if (snapshot.hasData) {
              return HomePage();
            }
            // if user NOT logged in
            else {
              return LoginOrRegisterScreen();
            }
          }),
    );
  }
}
