import 'package:flutter/material.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_login_screen.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_register_screen.dart';
import 'package:mental_wellness_app/views/login_screen.dart';
import 'package:mental_wellness_app/views/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginScreen = true;
  bool isMember = true; // Add a flag to toggle between member and counsellor

  // toggle between login and register screen
  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  // toggle between member and counsellor
  void toggleMemberCounsellor() {
    setState(() {
      isMember = !isMember;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return isMember
          ? LoginScreen(
              onTap: toggleScreens, onSwitchRole: toggleMemberCounsellor)
          : CounsellorLoginScreen(
              onTap: toggleScreens, onSwitchRole: toggleMemberCounsellor);
    } else {
      return isMember
          ? RegisterScreen(
              onTap: toggleScreens, onSwitchRole: toggleMemberCounsellor)
          : CounsellorRegisterScreen(
              onTap: toggleScreens, onSwitchRole: toggleMemberCounsellor);
    }
  }
}
