import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/auth/auth_screen.dart';
import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
import 'package:mental_wellness_app/widgets/sound_card.dart';

class RelaxingSoundsScreen extends StatefulWidget {
  const RelaxingSoundsScreen({super.key});

  @override
  _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
}

class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
  final RelaxingSoundController _controller =
      Get.put(RelaxingSoundController());

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    // Make the status bar transparent
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Stack(
        children: [
          // Background image with fixed height
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/relaxing_sounds_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top section with title, description, and image
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Sounds',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Relax Sounds',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Help for focus, relax or sleep.\nImmerse yourself in calming \nnatural sounds.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Increased space between text and image
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/relaxing/relaxing_sounds_4.png',
                            height: 164, // Use original height if needed
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sound cards
                Expanded(
                  child: Obx(() {
                    if (_controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio:
                              3 / 1.5, // Adjusted the aspect ratio
                        ),
                        itemCount: _controller.relaxingSounds.length,
                        itemBuilder: (context, index) {
                          return SoundCard(
                            sound: _controller.relaxingSounds[index],
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
