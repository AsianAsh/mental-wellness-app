// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/home_page.dart';
// import 'package:mental_wellness_app/auth/login_or_register_screen.dart';
// import 'package:mental_wellness_app/views/login_screen.dart';

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           // Constantly listening to auth state changes (If user logged in or not)
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             // if user logged in
//             if (snapshot.hasData) {
//               return HomePage.instance;
//             }
//             // if user NOT logged in
//             else {
//               return LoginOrRegisterScreen();
//             }
//           }),
//     );
//   }
// }

// for counsellor navigation to homepage.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/home_page.dart';

import 'package:mental_wellness_app/auth/login_or_register_screen.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<String> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot memberDoc = await FirebaseFirestore.instance
          .collection('Members')
          .doc(user.uid)
          .get();
      if (memberDoc.exists) {
        return 'member';
      }

      DocumentSnapshot counsellorDoc = await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(user.uid)
          .get();
      if (counsellorDoc.exists) {
        return 'counsellor';
      }
    }
    return 'unknown'; // Default role if not found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<String>(
              future: getUserRole(),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (roleSnapshot.hasError) {
                  return Center(child: Text('Error: ${roleSnapshot.error}'));
                } else {
                  String role = roleSnapshot.data ?? 'unknown';
                  if (role == 'counsellor') {
                    return CounsellorHomeScreen.instance;
                  } else if (role == 'member') {
                    return HomePage.instance;
                  } else {
                    return LoginOrRegisterScreen();
                  }
                }
              },
            );
          } else {
            return LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
