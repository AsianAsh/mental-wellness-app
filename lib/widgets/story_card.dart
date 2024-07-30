import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';

class StoryCard extends StatelessWidget {
  final SleepStory sleepStory;

  StoryCard({required this.sleepStory});

  @override
  Widget build(BuildContext context) {
    final audioPlayerState =
        Provider.of<AudioPlayerState>(context, listen: false);

    return GestureDetector(
      onTap: () {
        audioPlayerState.playAudio(sleepStory.audioPath);
        audioPlayerState.setCurrentAudioTitle(sleepStory.title);
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  sleepStory.imagePath,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sleepStory.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(sleepStory.getDurationText()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
