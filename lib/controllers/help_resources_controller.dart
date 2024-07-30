// help_resources_controller.dart
import 'package:get/get.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/models/helpline.dart';

class HelpResourcesController extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  Rx<Map<String, CountryHelpline>?> helplines =
      Rx<Map<String, CountryHelpline>?>(null);
  Rx<CountryHelpline?> selectedHelpline = Rx<CountryHelpline?>(null);
  Rx<String?> selectedCountry = Rx<String?>(null);
  RxBool showHelplines = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHelplines();
  }

  void loadHelplines() async {
    helplines.value = await firestoreService.loadHelplines();
  }

  void setSelectedCountry(String? country) {
    selectedCountry.value = country;
    selectedHelpline.value = helplines.value?[country];
    showHelplines.value = true;
  }
}
