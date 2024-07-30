import 'package:get/get.dart';
import 'package:mental_wellness_app/models/relaxing_sound.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class RelaxingSoundController extends GetxController {
  var relaxingSounds = <RelaxingSound>[].obs;
  var isLoading = true.obs;

  final FirestoreService _firestoreService = FirestoreService();

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
    } finally {
      isLoading(false);
    }
  }

  List<String> get audioPaths =>
      relaxingSounds.map((sound) => sound.audioPath).toList();
}
