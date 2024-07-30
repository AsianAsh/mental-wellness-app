import 'package:flutter/material.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/views/breathing_play_screen.dart';

class BreathingExerciseCard extends StatelessWidget {
  final BreathingExercise exercise;
  final VoidCallback onComplete;

  const BreathingExerciseCard({
    required this.exercise,
    required this.onComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BreathingPlayScreen(
              exercise: exercise,
              onComplete: onComplete,
            ),
          ),
        );
      },
      child: Container(
        width: 110, // Adjust the width as needed
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.indigo[600],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exercise.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              exercise.getDurationText(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            ClipOval(
              child: Image.asset(
                exercise.imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
