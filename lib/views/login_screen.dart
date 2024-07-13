// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/helper/helper_functions.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/util/login_icon_tile.dart';
// import 'package:mental_wellness_app/util/my_button.dart';
// import 'package:mental_wellness_app/util/my_textfield.dart';

// class LoginScreen extends StatefulWidget {
//   final Function()? onTap;
//   const LoginScreen({super.key, required this.onTap});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // removed const due to we have text editing controllers
//   final emailController = TextEditingController(text: 'ashchar111@gmail.com');

//   final passwordController = TextEditingController(text: 'test123');

//   // void signUserIn(BuildContext context) {
//   void login() async {
//     // loading circle
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );

//     // attempt sign in
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       // Update last active field
//       await FirestoreService().updateLastActive();

//       // Update daily routine after successful login
//       await FirestoreService().updateDailyRoutine();

//       if (mounted) Navigator.pop(context);

//       // // pop loading circle when done signing in
//       // if (mounted) {
//       //   Navigator.pop(context);
//       // }
//     } on FirebaseAuthException catch (e) {
//       // pop loading circle when done signing in
//       if (mounted) Navigator.pop(context);

//       // display errors
//       displayErrorMessage(e.code, context);
//       // if (e.code == 'user-not-found') {
//       //   wrongEmailMsg();
//       // } else if (e.code == 'wrong-password') {
//       //   wrongPasswordMsg();
//       // } else if (e.code == 'invalid-credential') {
//       //   invalidCredsMsg();
//       // } else {
//       //   print('An error occurred: ${e.message}');
//       // }
//     }
//   }

//   void wrongEmailMsg() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const AlertDialog(
//           backgroundColor: Colors.deepPurple,
//           title: Text(
//             'Incorrect Email',
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }

//   void wrongPasswordMsg() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const AlertDialog(
//           backgroundColor: Colors.deepPurple,
//           title: Text(
//             'Incorrect Password',
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }

//   void invalidCredsMsg() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const AlertDialog(
//           backgroundColor: Colors.deepPurple,
//           title: Text(
//             'Invalid Credentials',
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 35),

//                 // logo
//                 const Icon(
//                   Icons.lock,
//                   size: 90,
//                 ),

//                 const SizedBox(height: 40),

//                 //welcome back
//                 Center(
//                   child: Text(
//                     'Welcome back you\'ve been missed!',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 //email textfield
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Email',
//                   obscureText: false,
//                 ),

//                 const SizedBox(height: 10),

//                 // password textfield
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                 ),

//                 const SizedBox(height: 10),

//                 // forgot password
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 //sign in btn
//                 // MyButton(onTap: () => signUserIn(context)),
//                 MyButton(text: "Sign In", onTap: () => login()),

//                 const SizedBox(height: 30),

//                 //or continue with
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(children: [
//                     Expanded(
//                       child: Divider(
//                         thickness: 0.5,
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: Text('Or continue with',
//                           style: TextStyle(color: Colors.grey[700])),
//                     ),
//                     Expanded(
//                       child: Divider(
//                         thickness: 0.5,
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                   ]),
//                 ),

//                 // const SizedBox(height: 30),

//                 // // google + apple sign in buttons
//                 // const Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     SquareTile(imagePath: 'lib/images/google.png'),
//                 //     SizedBox(width: 25),
//                 //     SquareTile(imagePath: 'lib/images/apple.png'),
//                 //   ],
//                 // ),

//                 const SizedBox(height: 30),

//                 //not a member? register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Not a member?',
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                     const SizedBox(width: 4),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: const Text('Register now',
//                           style: TextStyle(
//                               color: Colors.blue, fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// fi laoding not ending issue + print previous user data instead of current
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/util/my_button.dart';
import 'package:mental_wellness_app/util/my_textfield.dart';
import 'package:mental_wellness_app/home_page.dart'; // Assuming you have a HomePage widget

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: 'ashchar111@gmail.com');
  final passwordController = TextEditingController(text: 'test123');

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

      print("Before calling updateRoutine");

      // Update daily routine after successful login
      await FirestoreService().updateDailyRoutine();

      print("After calling updateRoutine");

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                const Icon(
                  Icons.lock,
                  size: 90,
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'Welcome back you\'ve been missed!',
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
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Text('Or continue with',
                    //       style: TextStyle(color: Colors.grey[700])),
                    // ),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                  ]),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Register now',
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
