// import 'package:get/get.dart';
// import 'package:mental_wellness_app/models/received_nudge.dart';
// import 'package:mental_wellness_app/services/firestore.dart';

// class NudgeController extends GetxController {
//   var nudges = <Nudge>[].obs;
//   var isLoading = true.obs;

//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchNudges();
//   }

//   void fetchNudges() {
//     _firestoreService.getNudges().listen((nudgeList) {
//       nudges.value = nudgeList;
//       isLoading.value = false;
//     });
//   }

//   void markNudgesAsRead() {
//     _firestoreService.markNudgesAsRead();
//   }
// }

// del;ete nduge
// nudge_controller.dart
import 'package:get/get.dart';
import 'package:mental_wellness_app/models/received_nudge.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class NudgeController extends GetxController {
  var nudges = <Nudge>[].obs;
  var isLoading = true.obs;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    fetchNudges();
  }

  void fetchNudges() {
    _firestoreService.getNudges().listen((nudgeList) {
      nudges.value = nudgeList;
      isLoading.value = false;
    });
  }

  void markNudgesAsRead() {
    _firestoreService.markNudgesAsRead();
  }

  void deleteNudge(String nudgeId) async {
    await _firestoreService.deleteNudge(nudgeId);
    nudges.removeWhere((nudge) => nudge.id == nudgeId);
  }
}
