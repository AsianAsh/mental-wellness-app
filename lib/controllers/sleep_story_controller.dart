// controllers/sleep_story_controller.dart
import 'package:get/get.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class SleepStoryController extends GetxController {
  var sleepStories = <SleepStory>[].obs;
  var isLoading = true.obs;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchSleepStories();
  }

  void fetchSleepStories() async {
    try {
      isLoading(true);
      var stories = await _firestoreService.fetchSleepStories();
      sleepStories.assignAll(stories);
    } finally {
      isLoading(false);
    }
  }

  Future<SleepStory?> getSleepStoryById(String id) async {
    try {
      return await _firestoreService.getSleepStoryById(id);
    } catch (e) {
      print('Error fetching sleep story: $e');
      return null;
    }
  }
}
