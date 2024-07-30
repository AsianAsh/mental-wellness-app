// views/register_screen.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/controllers/register_controller.dart';
import 'package:mental_wellness_app/widgets/my_button.dart';
import 'package:mental_wellness_app/widgets/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  final Function()? onSwitchRole;

  RegisterScreen({super.key, required this.onTap, required this.onSwitchRole});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RegisterController registerController = RegisterController();
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
                                  size: 60,
                                ),
                                const SizedBox(height: 5),
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
                                MyTextField(
                                  controller: firstNameController,
                                  hintText: 'First Name',
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                MyTextField(
                                  controller: lastNameController,
                                  hintText: 'Last Name',
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
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
                                MyTextField(
                                  controller: confirmPasswordController,
                                  hintText: 'Confirm Password',
                                  obscureText: true,
                                ),
                                const SizedBox(height: 25),
                                MyButton(
                                    text: "Sign Up",
                                    onTap: () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      registerController.registerUser(
                                        context,
                                        firstNameController,
                                        lastNameController,
                                        emailController,
                                        passwordController,
                                        confirmPasswordController,
                                        widget.onSwitchRole!,
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
                                      'Already a member?',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: widget.onTap,
                                      child: const Text(
                                        'Login now',
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
