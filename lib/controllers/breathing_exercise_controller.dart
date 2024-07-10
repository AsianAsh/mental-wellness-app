// Simpler solution
// class BreathingExerciseController {
//   final FirestoreService _firestoreService = FirestoreService();

//   Future<List<BreathingExercise>> getBreathingExercises() {
//     return _firestoreService.getBreathingExercises();
//   }
// }

// import 'package:get/get.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/services/firestore.dart';

// class BreathingExerciseController extends GetxController {
//   var breathingExercises = <BreathingExercise>[].obs;
//   var isLoading = true.obs;

//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchBreathingExercises();
//   }

//   void fetchBreathingExercises() async {
//     try {
//       isLoading(true);
//       var exercises = await _firestoreService.fetchBreathingExercises();
//       breathingExercises.assignAll(exercises);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// routine page to navigate to breathplayscreen also
import 'package:get/get.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class BreathingExerciseController extends GetxController {
  var breathingExercises = <BreathingExercise>[].obs;
  var isLoading = true.obs;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchBreathingExercises();
  }

  void fetchBreathingExercises() async {
    try {
      isLoading(true);
      var exercises = await _firestoreService.fetchBreathingExercises();
      breathingExercises.assignAll(exercises);
    } finally {
      isLoading(false);
    }
  }

  Future<BreathingExercise?> getBreathingExerciseById(String id) async {
    try {
      return await _firestoreService.getBreathingExerciseById(id);
    } catch (e) {
      print('Error fetching breathing exercise: $e');
      return null;
    }
  }
}
