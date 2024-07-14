// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/auth/login_or_register_screen.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';
// import 'package:mental_wellness_app/views/counsellor/counsellor_home_screen.dart';
// import 'package:mental_wellness_app/views/counsellor/counsellor_register_screen.dart';

// class CounsellorLoginScreen extends StatefulWidget {
//   final Function()? onTap;
//   const CounsellorLoginScreen({super.key, required this.onTap});

//   @override
//   State<CounsellorLoginScreen> createState() => _CounsellorLoginScreenState();
// }

// class _CounsellorLoginScreenState extends State<CounsellorLoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void login() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

//     bool loginSuccess = false;

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       await FirestoreService().updateLastActive();

//       loginSuccess = true;
//     } on FirebaseAuthException catch (e) {
//       displayErrorMessage(e.code, context);
//     }

//     if (mounted) {
//       Navigator.pop(context); // Dismiss the loading circle

//       if (loginSuccess) {
//         Navigator.pop(context); // Dismiss the loading circle
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => CounsellorHomeScreen()),
//         );
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
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 35),
//                   const Icon(
//                     Icons.lock,
//                     size: 90,
//                   ),
//                   const SizedBox(height: 40),
//                   Center(
//                     child: Text(
//                       'Counsellor Login',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
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
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Forgot Password?',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   MyButton(text: "Sign In", onTap: () => login()),
//                   const SizedBox(height: 0),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[400],
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(thickness: 0.5, color: Colors.grey[400]),
//                       ),
//                     ]),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Want to Register as Counsellor?',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                         onTap: widget.onTap,
//                         child: const Text('Register now',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Back to Member Login',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginOrRegisterScreen(),
//                             ),
//                           );
//                         },
//                         child: const Text('Login here',
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/util/my_button.dart';
import 'package:mental_wellness_app/util/my_textfield.dart';
import 'package:mental_wellness_app/home_page.dart';

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
    // show loading circle
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Update last active field
      await FirestoreService().updateLastActive();

      // Update daily routine after successful login
      await FirestoreService().updateDailyRoutine();

      loginSuccess = true;
    } on FirebaseAuthException catch (e) {
      displayErrorMessage(e.code, context);
    }

    if (mounted) {
      Navigator.pop(context); // Dismiss the loading circle

      if (loginSuccess) {
        Navigator.pop(context); // Dismiss the loading circle
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage.instance),
        );
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
                              size: 90,
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: Text(
                                'Welcome Counsellor!',
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
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.5,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text('Or continue with',
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.5,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a counsellor?',
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
