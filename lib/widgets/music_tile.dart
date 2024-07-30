import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/models/sleep_music.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';

class MusicTile extends StatelessWidget {
  final SleepMusic sleepMusic;

  MusicTile({required this.sleepMusic});

  @override
  Widget build(BuildContext context) {
    final audioPlayerState =
        Provider.of<AudioPlayerState>(context, listen: false);

    return GestureDetector(
      onTap: () {
        audioPlayerState.playAudio(sleepMusic.audioPath);
        audioPlayerState.setCurrentAudioTitle(sleepMusic.title);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white24, width: 1),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.play_circle_filled, color: Colors.white),
          title: Text(
            sleepMusic.title,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Text(
            sleepMusic.getMinSecDurationText(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
