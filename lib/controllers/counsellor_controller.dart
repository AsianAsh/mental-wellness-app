import 'package:mental_wellness_app/models/counsellor.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class CounsellorController {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Counsellor>> fetchActiveCounsellors() async {
    List<Map<String, dynamic>> counsellorData =
        await _firestoreService.getActiveCounsellors();
    return counsellorData.map((data) => Counsellor.fromMap(data)).toList();
  }
}
