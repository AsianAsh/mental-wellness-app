import 'package:flutter/material.dart';
import 'package:mental_wellness_app/util/emote_face.dart';
import 'package:mental_wellness_app/views/profile_screen.dart';
import './random_words.dart';
import 'package:get/get.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          // Daily Task Title + Profile Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wellness Routine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Navigate to the ProfileScreen
                  Get.to(const ProfileScreen());
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              // Icon(
              //   Icons.person,
              //   color: Colors.white,
              // ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          // Random Words Page Button
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RandomWords()),
                  );
                },
                child: const Text('Go to Random Words'),
              ),
            ),
          ]),

          // Sized Box for space between components
          const SizedBox(
            height: 20,
          ),

          // Search bar
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(12),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Search',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // How you feeling today Text
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // By default, content in Row is left-aligned unless stated otherwise such as mainAxisAlignment
            children: [
              Text('How you feeling today?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // Mood of the day Options
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // bad
              Column(
                children: [
                  EmoticonFace(
                    emoticonFace: '😒',
                  ),
                  SizedBox(height: 5),
                  Text('Bad',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),

              // fine
              Column(
                children: [
                  EmoticonFace(
                    emoticonFace: '😐',
                  ),
                  SizedBox(height: 5),
                  Text('Fine',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),

              // good
              Column(
                children: [
                  EmoticonFace(
                    emoticonFace: '😀',
                  ),
                  SizedBox(height: 5),
                  Text('Good',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),

              // excellent
              Column(
                children: [
                  EmoticonFace(
                    emoticonFace: '😎',
                  ),
                  SizedBox(height: 5),
                  Text('Fantastic',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
