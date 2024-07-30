// nudge.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class NudgeModal extends StatelessWidget {
  final String friendId;
  final String friendFullName;

  NudgeModal({required this.friendId, required this.friendFullName});

  final List<Map<String, dynamic>> nudgeMessages = [
    {
      'message': 'Keep up that run streak, buddy.',
      'icon': Icons.directions_run,
      'color': Colors.blue
    },
    {
      'message': 'Sending some love your way.',
      'icon': Icons.favorite,
      'color': Colors.pink
    },
    {
      'message': 'Just saying hi.',
      'icon': Icons.handshake,
      'color': Colors.green
    },
    {
      'message': 'Be kind to your mind.',
      'icon': Icons.spa,
      'color': Colors.lightBlue
    },
    {
      'message': 'You deserve some recognition today.',
      'icon': Icons.self_improvement,
      'color': Colors.orange
    },
    {
      'message': 'You\'re doing amazing!',
      'icon': Icons.thumb_up,
      'color': Colors.purple
    },
    {'message': 'Stay positive!', 'icon': Icons.sunny, 'color': Colors.yellow},
    {
      'message': 'You got this!',
      'icon': Icons.lightbulb,
      'color': Colors.amber
    },
    {
      'message': 'Keep pushing!',
      'icon': Icons.fitness_center,
      'color': Colors.red
    },
    {'message': 'Stay strong!', 'icon': Icons.lock, 'color': Colors.teal},
    {
      'message': 'You are awesome!',
      'icon': Icons.star,
      'color': Colors.deepPurple
    },
    {'message': 'Keep smiling!', 'icon': Icons.tag_faces, 'color': Colors.cyan},
    {
      'message': 'Stay motivated!',
      'icon': Icons.directions_walk,
      'color': Colors.deepOrange
    },
    {'message': 'Keep going!', 'icon': Icons.trending_up, 'color': Colors.lime},
    {
      'message': 'You can do it!',
      'icon': Icons.flash_on,
      'color': Colors.blueGrey
    },
  ];

  @override
  Widget build(BuildContext context) {
    String friendFirstName = friendFullName.split(' ')[0];
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.indigo[100], // Light shade of indigo
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Send $friendFirstName a mindful message',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: nudgeMessages.length,
                itemBuilder: (context, index) {
                  var nudge = nudgeMessages[index];
                  return Card(
                    color: nudge['color'],
                    child: ListTile(
                      leading: Icon(nudge['icon'], color: Colors.white),
                      title: Text(
                        nudge['message'],
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        FirestoreService().sendNudge(
                          friendId,
                          nudge['message'],
                          nudge['icon'].toString(),
                          context,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
