import 'package:get/get.dart';
import 'package:mental_wellness_app/models/counselling_request.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class CounsellingRequestController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  void requestCounselling(String memberId, String reason) async {
    try {
      CounsellingRequest request =
          CounsellingRequest(memberId: memberId, reason: reason);
      await _firestoreService.addCounsellingRequest(request);
      Get.snackbar('Success', 'Your counselling request has been submitted.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit counselling request.');
    }
  }
}
