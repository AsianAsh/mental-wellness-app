import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/models/appointment.dart';

class AppointmentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveAppointments(
      Map<DateTime, Map<String, String>> selectedSlots) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    String counsellorId = currentUser.uid;

    // Fetch all existing appointments
    QuerySnapshot existingAppointmentsSnapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .get();

    // Delete appointments that are no longer selected and are not booked
    for (var doc in existingAppointmentsSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Appointment appointment = Appointment.fromMap(data);

      DateTime strippedDate = _stripTime(appointment.date);
      String slot = DateFormat('hh:mm a').format(appointment.startTime);

      if ((selectedSlots[strippedDate] == null ||
              !selectedSlots[strippedDate]!.containsKey(slot)) &&
          appointment.status != 'booked') {
        await doc.reference.delete();
      }
    }

    // Save new or updated appointments
    for (DateTime date in selectedSlots.keys) {
      for (String slot in selectedSlots[date]!.keys) {
        DateTime startTime = _parseTime(date, slot);
        DateTime endTime = startTime.add(Duration(minutes: 30));

        // Check if an appointment already exists for this date and start time
        bool appointmentExists =
            await _appointmentExists(counsellorId, date, startTime);
        if (!appointmentExists) {
          Appointment appointment = Appointment(
            date: date,
            startTime: startTime,
            endTime: endTime,
            status: selectedSlots[date]![slot] ?? 'open',
            bookedBy: '',
            meetingLink: '',
            reason: '',
            summary: '',
          );

          await _firestore
              .collection('counsellors')
              .doc(counsellorId)
              .collection('appointments')
              .add(appointment.toMap());
        }
      }
    }
  }

  DateTime _parseTime(DateTime date, String time) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime parsedTime = format.parse(time);

    return DateTime(
      date.year,
      date.month,
      date.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  Future<Map<DateTime, Map<String, String>>> fetchAppointments() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return {};
    }

    String counsellorId = currentUser.uid;
    Map<DateTime, Map<String, String>> selectedSlots = {};

    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Appointment appointment = Appointment.fromMap(data);
      DateTime strippedDate = _stripTime(appointment.date);
      String slot = DateFormat('hh:mm a').format(appointment.startTime);

      if (selectedSlots[strippedDate] == null) {
        selectedSlots[strippedDate] = {};
      }

      if (!selectedSlots[strippedDate]!.containsKey(slot)) {
        selectedSlots[strippedDate]![slot] = appointment.status;
      }
    }

    return selectedSlots;
  }

  Future<bool> _appointmentExists(
      String counsellorId, DateTime date, DateTime startTime) async {
    print('Checking for existing appointment:');
    print('Counsellor ID: $counsellorId');
    print('Date: ${date.toIso8601String()}');
    print('Start Time: ${startTime.toIso8601String()}');

    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .where('date', isEqualTo: date)
        .where('startTime', isEqualTo: startTime)
        .get();

    print('Query results: ${snapshot.docs.length} documents found.');

    return snapshot.docs.isNotEmpty;
  }

  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Members can book an open appointment by updating appointments doc of a counsellor
  Future<bool> bookAppointment(
      String counsellorId, String date, String slot, String reason) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return false;
    }

    DateTime selectedDate = DateFormat('dd MMMM yyyy').parse(date);
    DateTime startTime = DateFormat('hh:mm a').parse(slot);
    startTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);
    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .where('date', isEqualTo: selectedDate)
        .where('startTime', isEqualTo: startTime)
        .where('status', isEqualTo: 'open')
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      await doc.reference.update({
        'status': 'booked',
        'bookedBy': currentUser.uid,
        'reason': reason,
      });
      return true;
    } else {
      return false;
    }
  }

  // Get all documents in appointments sub collection for a specific counsellor doc
  Future<List<QueryDocumentSnapshot>> fetchCounsellorAppointments(
      String counsellorId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .get();
    return snapshot.docs;
  }
}
