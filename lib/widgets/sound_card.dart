import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/models/relaxing_sound.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';

class SoundCard extends StatelessWidget {
  final RelaxingSound sound;

  const SoundCard({required this.sound, super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayerState = Provider.of<AudioPlayerState>(context);
    final isPlaying = audioPlayerState.currentAudio == sound.audioPath;

    return GestureDetector(
      onTap: () {
        audioPlayerState.playAudio(sound.audioPath,
            loop: true); // Enable looping for relaxing sounds
        audioPlayerState.setCurrentAudioTitle(sound.title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isPlaying
              ? const Color.fromARGB(255, 0, 23, 34)
              : const Color.fromARGB(255, 0, 23, 34).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  sound.title,
                  style: TextStyle(
                    color: isPlaying ? Colors.white : Colors.white54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
