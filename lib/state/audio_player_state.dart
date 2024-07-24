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
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   void playAudio(String audioPath) async {
//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     await _audioPlayer.play(AssetSource(currentAudio!));
//     notifyListeners();
//   }

//   void pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   void resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     notifyListeners();
//   }
// }

// Version 4
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   // Add this new state to handle relaxing sounds
//   bool isPlayingAllRelaxingSounds = false;
//   List<AudioPlayer> _relaxingSoundPlayers = [];

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   void playAudio(String audioPath) async {
//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     await _audioPlayer.play(AssetSource(currentAudio!));
//     notifyListeners();
//   }

//   void pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   void resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     notifyListeners();
//   }

//   // Add these methods to handle playing all relaxing sounds
//   void playAllRelaxingSounds(List<String> audioPaths) async {
//     _relaxingSoundPlayers = audioPaths.map((path) => AudioPlayer()).toList();
//     for (int i = 0; i < audioPaths.length; i++) {
//       await _relaxingSoundPlayers[i].play(AssetSource(audioPaths[i]));
//     }
//     isPlayingAllRelaxingSounds = true;
//     notifyListeners();
//   }

//   void pauseAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       await player.pause();
//     }
//     isPlayingAllRelaxingSounds = false;
//     notifyListeners();
//   }

//   void toggleAllRelaxingSounds(List<String> audioPaths) {
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     } else {
//       playAllRelaxingSounds(audioPaths);
//     }
//   }
// }

// version 5: remove indiviDual play/pause, display relaxing sounds in audio player UI correctly
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerState with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? currentAudioTitle;
  String? currentAudio;
  bool isVisible = false;
  bool isPlaying = false;
  bool isLooping = false;
  Duration _currentPosition = Duration.zero;

  void setCurrentAudioTitle(String title) {
    currentAudioTitle = title;
    notifyListeners();
  }

  void playAudio(String audioPath, {bool loop = false}) async {
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
    isLooping = loop;

    await _audioPlayer.play(AssetSource(currentAudio!));
    _audioPlayer.onPlayerComplete.listen((event) {
      if (isLooping) {
        _audioPlayer.play(AssetSource(currentAudio!));
      } else {
        isPlaying = false;
        notifyListeners();
      }
    });
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


//version 5b
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   // Add this new state to handle relaxing sounds
//   bool isPlayingAllRelaxingSounds = false;
//   List<AudioPlayer> _relaxingSoundPlayers = [];

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   Future<void> playAudio(String audioPath) async {
//     // If relaxing sounds are playing, stop them first
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     }

//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     try {
//       await _audioPlayer.play(AssetSource(currentAudio!));
//     } catch (e) {
//       print('Error playing audio: $e');
//       currentAudio = null;
//       isPlaying = false;
//       notifyListeners();
//     }
//   }

//   Future<void> pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   Future<void> resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     notifyListeners();
//   }

//   // Add these methods to handle playing all relaxing sounds
//   Future<void> playAllRelaxingSounds(List<String> audioPaths) async {
//     if (currentAudio != null) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//       currentAudio = null;
//     }

//     _relaxingSoundPlayers = audioPaths.map((path) => AudioPlayer()).toList();
//     for (int i = 0; i < audioPaths.length; i++) {
//       try {
//         await _relaxingSoundPlayers[i]
//             .setReleaseMode(ReleaseMode.loop); // loop audio
//         await _relaxingSoundPlayers[i].play(AssetSource(audioPaths[i]));
//         print('Playing relaxing sound: ${audioPaths[i]}');
//       } catch (e) {
//         print('Error playing relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     currentAudioTitle = 'Relax Sounds';
//     isVisible = true;
//     notifyListeners();
//   }

//   Future<void> pauseAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       await player.pause();
//     }
//     isPlayingAllRelaxingSounds = false;
//     notifyListeners();
//   }

//   void toggleAllRelaxingSounds(List<String> audioPaths) {
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     } else {
//       playAllRelaxingSounds(audioPaths);
//     }
//   }
// }

//version 6: bottom audioplayer UI can control relaixng sounds also
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   // Add this new state to handle relaxing sounds
//   bool isPlayingAllRelaxingSounds = false;
//   List<AudioPlayer> _relaxingSoundPlayers = [];

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   Future<void> playAudio(String audioPath) async {
//     // If relaxing sounds are playing, stop them first
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     }

//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     try {
//       await _audioPlayer.play(AssetSource(currentAudio!));
//     } catch (e) {
//       print('Error playing audio: $e');
//       currentAudio = null;
//       isPlaying = false;
//       notifyListeners();
//     }
//   }

//   Future<void> pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   Future<void> resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     pauseAllRelaxingSounds();
//     notifyListeners();
//   }

//   // Add these methods to handle playing all relaxing sounds
//   Future<void> playAllRelaxingSounds(List<String> audioPaths) async {
//     if (currentAudio != null) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//       currentAudio = null;
//     }

//     _relaxingSoundPlayers = audioPaths.map((path) => AudioPlayer()).toList();
//     for (int i = 0; i < audioPaths.length; i++) {
//       try {
//         await _relaxingSoundPlayers[i].setReleaseMode(ReleaseMode.loop);
//         await _relaxingSoundPlayers[i].play(AssetSource(audioPaths[i]));
//         print('Playing relaxing sound: ${audioPaths[i]}');
//       } catch (e) {
//         print('Error playing relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     currentAudioTitle = 'Relax Sounds';
//     isVisible = true;
//     notifyListeners();
//   }

//   Future<void> pauseAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       await player.pause();
//     }
//     isPlayingAllRelaxingSounds = false;
//     notifyListeners();
//   }

//   Future<void> resumeAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       await player.resume();
//     }
//     isPlayingAllRelaxingSounds = true;
//     notifyListeners();
//   }

//   void toggleAllRelaxingSounds(List<String> audioPaths) {
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     } else {
//       playAllRelaxingSounds(audioPaths);
//     }
//   }

//   void toggleAudio() {
//     if (isPlaying || isPlayingAllRelaxingSounds) {
//       if (isPlaying) {
//         pauseAudio();
//       } else {
//         pauseAllRelaxingSounds();
//       }
//     } else {
//       if (currentAudio != null) {
//         resumeAudio();
//       } else {
//         resumeAllRelaxingSounds();
//       }
//     }
//   }
// }

// version 6b (only this file): attempt to fix audio not playing after a while
// result: works
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   // Add this new state to handle relaxing sounds
//   bool isPlayingAllRelaxingSounds = false;
//   List<AudioPlayer> _relaxingSoundPlayers = [];
//   final int maxConcurrentPlayers = 3;

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   Future<void> playAudio(String audioPath) async {
//     // If relaxing sounds are playing, stop them first
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     }

//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     try {
//       await _audioPlayer.play(AssetSource(currentAudio!));
//     } catch (e) {
//       print('Error playing audio: $e');
//       currentAudio = null;
//       isPlaying = false;
//       notifyListeners();
//     }
//   }

//   Future<void> pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   Future<void> resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     pauseAllRelaxingSounds();
//     notifyListeners();
//   }

//   // Add these methods to handle playing all relaxing sounds
//   Future<void> playAllRelaxingSounds(List<String> audioPaths) async {
//     if (currentAudio != null) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//       currentAudio = null;
//     }

//     // Use a pool of AudioPlayer instances
//     _relaxingSoundPlayers = List.generate(
//       maxConcurrentPlayers,
//       (index) => AudioPlayer(),
//     );

//     for (int i = 0; i < audioPaths.length; i++) {
//       try {
//         final player = _relaxingSoundPlayers[i % maxConcurrentPlayers];
//         await player.setReleaseMode(ReleaseMode.loop);
//         await player.play(AssetSource(audioPaths[i]));
//         print('Playing relaxing sound: ${audioPaths[i]}');
//       } catch (e) {
//         print('Error playing relaxing sound: ${audioPaths[i]} - $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     currentAudioTitle = 'Relax Sounds';
//     isVisible = true;
//     notifyListeners();
//   }

//   Future<void> pauseAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       try {
//         await player.pause();
//       } catch (e) {
//         print('Error pausing relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = false;
//     notifyListeners();
//   }

//   Future<void> resumeAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       try {
//         await player.resume();
//       } catch (e) {
//         print('Error resuming relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     notifyListeners();
//   }

//   void toggleAllRelaxingSounds(List<String> audioPaths) {
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     } else {
//       playAllRelaxingSounds(audioPaths);
//     }
//   }

//   void toggleAudio() {
//     if (isPlaying || isPlayingAllRelaxingSounds) {
//       if (isPlaying) {
//         pauseAudio();
//       } else {
//         pauseAllRelaxingSounds();
//       }
//     } else {
//       if (currentAudio != null) {
//         resumeAudio();
//       } else {
//         resumeAllRelaxingSounds();
//       }
//     }
//   }
// }

// version 7: this file and realxing sounds view file - add individual enable and disable relaixng sounds in the widget
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   // Add this new state to handle relaxing sounds
//   bool isPlayingAllRelaxingSounds = false;
//   List<AudioPlayer> _relaxingSoundPlayers = [];
//   final Map<String, bool> soundEnabledMap = {};
//   final int maxConcurrentPlayers =
//       3; // Define the maximum number of concurrent players

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   Future<void> playAudio(String audioPath) async {
//     // If relaxing sounds are playing, stop them first
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     }

//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     try {
//       await _audioPlayer.play(AssetSource(currentAudio!));
//     } catch (e) {
//       print('Error playing audio: $e');
//       currentAudio = null;
//       isPlaying = false;
//       notifyListeners();
//     }
//   }

//   Future<void> pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   Future<void> resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     pauseAllRelaxingSounds();
//     notifyListeners();
//   }

//   // Add these methods to handle playing all relaxing sounds
//   Future<void> playAllRelaxingSounds(List<String> audioPaths) async {
//     if (currentAudio != null) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//       currentAudio = null;
//     }

//     // Use a pool of AudioPlayer instances
//     _relaxingSoundPlayers = List.generate(
//       maxConcurrentPlayers,
//       (index) => AudioPlayer(),
//     );

//     for (int i = 0; i < audioPaths.length; i++) {
//       if (soundEnabledMap[audioPaths[i]] ?? true) {
//         try {
//           final player = _relaxingSoundPlayers[i % maxConcurrentPlayers];
//           await player.setReleaseMode(ReleaseMode.loop);
//           await player.play(AssetSource(audioPaths[i]));
//           print('Playing relaxing sound: ${audioPaths[i]}');
//         } catch (e) {
//           print('Error playing relaxing sound: ${audioPaths[i]} - $e');
//         }
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     currentAudioTitle = 'Relax Sounds';
//     isVisible = true;
//     notifyListeners();
//   }

//   Future<void> pauseAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       try {
//         await player.pause();
//       } catch (e) {
//         print('Error pausing relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = false;
//     notifyListeners();
//   }

//   Future<void> resumeAllRelaxingSounds() async {
//     for (var player in _relaxingSoundPlayers) {
//       try {
//         await player.resume();
//       } catch (e) {
//         print('Error resuming relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     notifyListeners();
//   }

//   void toggleAllRelaxingSounds(List<String> audioPaths) {
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     } else {
//       playAllRelaxingSounds(audioPaths);
//     }
//   }

//   void toggleAudio() {
//     if (isPlaying || isPlayingAllRelaxingSounds) {
//       if (isPlaying) {
//         pauseAudio();
//       } else {
//         pauseAllRelaxingSounds();
//       }
//     } else {
//       if (currentAudio != null) {
//         resumeAudio();
//       } else {
//         resumeAllRelaxingSounds();
//       }
//     }
//   }

//   void toggleSoundEnabled(String audioPath) {
//     soundEnabledMap[audioPath] = !(soundEnabledMap[audioPath] ?? true);
//     notifyListeners();
//   }
// }

// version 8 (this and relax view file): revamp relaixng sound player (each sound has their own audio player + correct play/ enable/disable logic)
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerState with ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   String? currentAudioTitle;
//   String? currentAudio;
//   bool isVisible = false;
//   bool isPlaying = false;
//   Duration _currentPosition = Duration.zero;

//   // New state to handle relaxing sounds
//   bool isPlayingAllRelaxingSounds = false;
//   final Map<String, bool> soundEnabledMap = {};
//   final Map<String, AudioPlayer> soundPlayers = {};

//   void setCurrentAudioTitle(String title) async {
//     currentAudioTitle = title;
//     notifyListeners();
//   }

//   Future<void> playAudio(String audioPath) async {
//     // If relaxing sounds are playing, stop them first
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     }

//     if (currentAudio == audioPath && isPlaying) {
//       // If the same audio is already playing, do nothing
//       return;
//     }

//     if (currentAudio != null && currentAudio != audioPath) {
//       // Stop any currently playing audio
//       await _audioPlayer.stop();
//     }

//     currentAudio = audioPath;
//     isVisible = true;
//     isPlaying = true;

//     try {
//       await _audioPlayer.play(AssetSource(currentAudio!));
//     } catch (e) {
//       print('Error playing audio: $e');
//       currentAudio = null;
//       isPlaying = false;
//       notifyListeners();
//     }
//   }

//   Future<void> pauseAudio() async {
//     await _audioPlayer.pause();
//     _currentPosition = await _audioPlayer.getCurrentPosition() ?? Duration.zero;
//     isPlaying = false;
//     notifyListeners();
//   }

//   Future<void> resumeAudio() async {
//     await _audioPlayer.seek(_currentPosition);
//     await _audioPlayer.resume();
//     isPlaying = true;
//     notifyListeners();
//   }

//   void hidePlayer() {
//     isVisible = false;
//     pauseAudio();
//     pauseAllRelaxingSounds();
//     notifyListeners();
//   }

//   Future<void> playAllRelaxingSounds() async {
//     for (String audioPath in soundPlayers.keys) {
//       if (soundEnabledMap[audioPath] ?? true) {
//         try {
//           final player = soundPlayers[audioPath]!;
//           await player.setReleaseMode(ReleaseMode.loop);
//           await player.play(AssetSource(audioPath));
//           print('Playing relaxing sound: $audioPath');
//         } catch (e) {
//           print('Error playing relaxing sound: $audioPath - $e');
//         }
//       }
//     }
//     isPlayingAllRelaxingSounds = true;
//     currentAudioTitle = 'Relax Sounds';
//     isVisible = true;
//     notifyListeners();
//   }

//   Future<void> pauseAllRelaxingSounds() async {
//     for (var player in soundPlayers.values) {
//       try {
//         await player.pause();
//       } catch (e) {
//         print('Error pausing relaxing sound: $e');
//       }
//     }
//     isPlayingAllRelaxingSounds = false;
//     notifyListeners();
//   }

//   void toggleAllRelaxingSounds() {
//     if (isPlayingAllRelaxingSounds) {
//       pauseAllRelaxingSounds();
//     } else {
//       playAllRelaxingSounds();
//     }
//   }

//   void toggleAudio() {
//     if (isPlaying || isPlayingAllRelaxingSounds) {
//       if (isPlaying) {
//         pauseAudio();
//       } else {
//         pauseAllRelaxingSounds();
//       }
//     } else {
//       if (currentAudio != null) {
//         resumeAudio();
//       } else {
//         playAllRelaxingSounds();
//       }
//     }
//   }

//   void toggleSoundEnabled(String audioPath) {
//     soundEnabledMap[audioPath] = !(soundEnabledMap[audioPath] ?? true);
//     if (isPlayingAllRelaxingSounds && !soundEnabledMap[audioPath]!) {
//       soundPlayers[audioPath]?.pause();
//     } else if (isPlayingAllRelaxingSounds && soundEnabledMap[audioPath]!) {
//       soundPlayers[audioPath]?.play(AssetSource(audioPath));
//     }
//     notifyListeners();
//   }

//   void registerSound(String audioPath, AudioPlayer player) {
//     soundPlayers[audioPath] = player;
//   }
// }
