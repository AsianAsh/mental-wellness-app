import 'package:get/get.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class MeditationExerciseController extends GetxController {
  var meditationExercises = <MeditationExercise>[].obs;
  var isLoading = true.obs;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchMeditationExercises();
  }

  void fetchMeditationExercises() async {
    try {
      isLoading(true);
      var exercises = await _firestoreService.fetchMeditationExercises();
      print('Fetched ${exercises.length} meditation exercises');
      meditationExercises.assignAll(exercises);
    } catch (e) {
      print('Error fetching meditation exercises: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<MeditationExercise?> getMeditationExerciseById(String id) async {
    try {
      return await _firestoreService.getMeditationExerciseById(id);
    } catch (e) {
      print('Error fetching meditation exercise: $e');
      return null;
    }
  }
}

// Simpler solution
// class BreathingExerciseController {
//   final FirestoreService _firestoreService = FirestoreService();

//   Future<List<BreathingExercise>> getBreathingExercises() {
//     return _firestoreService.getBreathingExercises();
//   }
// }
