import 'package:flutter/material.dart';

class CounsellorHomeScreen extends StatelessWidget {
  static final CounsellorHomeScreen instance = CounsellorHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counsellor Home'),
      ),
      body: Center(
        child: Text('Welcome, Counsellor!'),
      ),
    );
  }
}
