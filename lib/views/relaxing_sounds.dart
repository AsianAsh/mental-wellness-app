import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RelaxingSoundsScreen extends StatefulWidget {
  const RelaxingSoundsScreen({super.key});

  @override
  _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
}

class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
  bool _controlsVisible = false;

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
            height: MediaQuery.of(context).size.height *
                0.28, // Adjust the height as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/test1.jpg'), // replace with your background image path
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
                                'Help for focus, relax or sleep. \nMix sounds together.',
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
                            height: 152, // Use original height if needed
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sliders for different sounds
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
                    children: [
                      buildSoundSlider(context, 'BEACH WAVES AND BIRDS'),
                      buildSoundSlider(context, 'FIRE'),
                      buildSoundSlider(context, 'THUNDERSTORM'),
                      buildSoundSlider(context, 'BIG CITY'),
                      buildSoundSlider(context, 'BIRD CHIRPING'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                if (!_controlsVisible) {
                  setState(() {
                    _controlsVisible = true;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.indigo[600],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.white12,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  // Change spacing alignment based on which content is shown
                  mainAxisAlignment: _controlsVisible
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: _controlsVisible
                      ? [
                          const Text(
                            'Relax Sounds',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.timer_outlined,
                                    color: Colors.white),
                                onPressed: () {
                                  // Timer action
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.play_arrow_rounded,
                                    color: Colors.white),
                                iconSize: 30,
                                onPressed: () {
                                  // Play/Pause action
                                },
                              ),
                            ],
                          ),
                        ]
                      : [
                          const Icon(Icons.play_arrow_rounded,
                              color: Colors.white),
                          const SizedBox(width: 5),
                          const Text(
                            'PLAY SOUNDS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSoundSlider(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 23, 34),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.volume_up_outlined,
                  color: Colors.indigo,
                ),
              ],
            ),
            Slider(
              value: 0.5,
              onChanged: (value) {},
              activeColor: Colors.indigo,
              inactiveColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
