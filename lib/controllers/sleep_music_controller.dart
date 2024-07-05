import 'package:get/get.dart';
import 'package:mental_wellness_app/models/sleep_music.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class SleepMusicController extends GetxController {
  var sleepMusic = <SleepMusic>[].obs;
  var isLoading = true.obs;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchSleepMusic();
  }

  void fetchSleepMusic() async {
    try {
      isLoading(true);
      var music = await _firestoreService.fetchSleepMusic();
      sleepMusic.assignAll(music);
    } finally {
      isLoading(false);
    }
  }
}
