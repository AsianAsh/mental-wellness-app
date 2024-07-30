import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';

class MeditationCard extends StatelessWidget {
  final MeditationExercise meditation;
  final VoidCallback onComplete;

  const MeditationCard({
    required this.meditation,
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
            builder: (context) => MeditationDetailScreen(
                meditation: meditation, onComplete: onComplete),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              meditation.imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 8), // Add spacing between image and text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        meditation.title,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        meditation.getDurationText(),
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
