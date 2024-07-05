// import 'package:flutter/material.dart';

// // Audio player for sleep stories, sleep music from SleepScreen and relaxing background sounds from RelaxingSoundsScreen
// // Breathing and Meditation have their own sepearte audioplayer

// // global state class that holds the current audio track, playback state, and visibility state of the audio player.
// class AudioPlayerState with ChangeNotifier {
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = true;
//   bool isPlaying = false;

//   void setCurrentAudioTitle(String title) {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   void playAudio(String audioPath) {
//     currentAudio = audioPath;
//     isPlaying = true;
//     isVisible = true;
//     notifyListeners();
//   }

//   void pauseAudio() {
//     isPlaying = false;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     notifyListeners();
//   }
// }

// try to fix audio issue when switching tabs
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AudioPlayerState with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? currentAudioTitle;
  String? currentAudio;
  bool isVisible = false;
  bool isPlaying = false;
  Duration _currentPosition = Duration.zero;

  void setCurrentAudioTitle(String title) async {
    currentAudioTitle = title;
    notifyListeners();
  }

  void playAudio(String audioPath) async {
    if (currentAudio == audioPath && isPlaying) {
      // If the same audio is already playing, do nothing
      return;
    }

    if (currentAudio != null && currentAudio != audioPath) {
      // Stop any currently playing audio
      await _audioPlayer.stop();
    }

    currentAudio = audioPath;
    isVisible = true;
    isPlaying = true;

    await _audioPlayer.play(AssetSource(currentAudio!));
    notifyListeners();
  }

  void pauseAudio() async {
    await _audioPlayer.pause();
    _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
    isPlaying = false;
    notifyListeners();
  }

  void resumeAudio() async {
    await _audioPlayer.seek(_currentPosition);
    await _audioPlayer.resume();
    isPlaying = true;
    notifyListeners();
  }

  void hidePlayer() {
    isVisible = false;
    pauseAudio();
    notifyListeners();
  }
}
