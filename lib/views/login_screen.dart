// views/login_screen.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/auth/forgot_password_screen.dart';
import 'package:mental_wellness_app/controllers/login_controller.dart';
import 'package:mental_wellness_app/widgets/my_button.dart';
import 'package:mental_wellness_app/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  final Function()? onSwitchRole;

  const LoginScreen(
      {super.key, required this.onTap, required this.onSwitchRole});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController = LoginController();
  bool _isLoading = false;

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
                    child: Stack(
                      children: [
                        Column(
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
                                    'Hi Member, you\'ve been missed!',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 25),
                                MyButton(
                                    text: "Sign In",
                                    onTap: () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      loginController.login(
                                        context,
                                        emailController,
                                        passwordController,
                                      );
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Not a member yet?',
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
                                'Switch to Counsellor Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_isLoading)
                          Container(
                            color: Colors.black54,
                            child: const Center(
                              child: CircularProgressIndicator(),
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
