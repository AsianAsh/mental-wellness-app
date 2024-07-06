// import 'package:get/get.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:mental_wellness_app/services/firestore.dart';

// class RelaxingSoundController extends GetxController {
//   var relaxingSound = <RelaxingSound>[].obs;
//   var isLoading = true.obs;

//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchRelaxingSound();
//   }

//   void fetchRelaxingSound() async {
//     try {
//       isLoading(true);
//       var sound = await _firestoreService.fetchRelaxingSounds();
//       relaxingSound.assignAll(sound);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:mental_wellness_app/models/relaxing_sound.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class RelaxingSoundController extends GetxController {
  var relaxingSounds = <RelaxingSound>[].obs;
  var isLoading = true.obs;
  var isPlayingAll = false.obs;

  final FirestoreService _firestoreService = FirestoreService();
  final List<AudioPlayer> _audioPlayers = [];

  @override
  void onInit() {
    super.onInit();
    fetchRelaxingSounds();
  }

  void fetchRelaxingSounds() async {
    try {
      isLoading(true);
      var sounds = await _firestoreService.fetchRelaxingSounds();
      relaxingSounds.assignAll(sounds);
      // Initialize audio players for each sound
      for (var sound in sounds) {
        _audioPlayers.add(AudioPlayer());
      }
    } finally {
      isLoading(false);
    }
  }

  void togglePlayAll(bool play) {
    isPlayingAll.value = play;
    if (play) {
      for (int i = 0; i < _audioPlayers.length; i++) {
        _audioPlayers[i].play(AssetSource(relaxingSounds[i].audioPath));
      }
    } else {
      for (var player in _audioPlayers) {
        player.pause();
      }
    }
  }

  void toggleIndividualPlay(int index, bool play) {
    if (play) {
      _audioPlayers[index].play(AssetSource(relaxingSounds[index].audioPath));
    } else {
      _audioPlayers[index].pause();
    }
  }

  void setVolume(int index, double volume) {
    _audioPlayers[index].setVolume(volume);
  }
}
