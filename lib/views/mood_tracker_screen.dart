import 'package:flutter/material.dart';
import 'package:mental_wellness_app/util/emote_face.dart';

class MoodTrackerScreen extends StatelessWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
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

          const SizedBox(height: 20),

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
                  Text(
                    'Fantastic',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
