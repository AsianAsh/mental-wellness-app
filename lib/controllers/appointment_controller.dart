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
    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .where('date', isEqualTo: date)
        .where('startTime', isEqualTo: startTime)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Method to book an appointment with a specific counsellor
  Future<bool> bookAppointment(
      String counsellorId, String date, String slot, String reason) async {
    // Get the currently logged-in user
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return false; // Return false if no user is logged in
    }

    // Parse the selected date and time slot
    DateTime selectedDate = DateFormat('dd MMMM yyyy').parse(date);
    DateTime startTime = DateFormat('hh:mm a').parse(slot);
    startTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);

    // Query the counsellor's appointments for the specified date and time
    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .where('date', isEqualTo: selectedDate)
        .where('startTime', isEqualTo: startTime)
        .where('status', isEqualTo: 'open')
        .limit(1)
        .get();

    // Check if an open appointment slot is available
    if (snapshot.docs.isNotEmpty) {
      // If available, book the appointment by updating the document
      var doc = snapshot.docs.first;
      await doc.reference.update({
        'status': 'booked',
        'bookedBy': currentUser.uid,
        'reason': reason,
      });
      return true; // Return true if the booking is successful
    } else {
      return false; // Return false if no open slots are available
    }
  }

  Future<List<QueryDocumentSnapshot>> fetchCounsellorAppointments(
      String counsellorId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('counsellors')
        .doc(counsellorId)
        .collection('appointments')
        .get();
    return snapshot.docs;
  }

  Future<List<Appointment>> fetchMemberAppointments(
      String userId, bool upcoming) async {
    String status = upcoming ? 'booked' : 'completed';

    QuerySnapshot counsellorsSnapshot =
        await _firestore.collection('counsellors').get();

    List<Appointment> appointments = [];

    for (var counsellorDoc in counsellorsSnapshot.docs) {
      QuerySnapshot appointmentSnapshot = await counsellorDoc.reference
          .collection('appointments')
          .where('bookedBy', isEqualTo: userId)
          .where('status', isEqualTo: status)
          .get();

      for (var appointmentDoc in appointmentSnapshot.docs) {
        var appointmentData = appointmentDoc.data() as Map<String, dynamic>;
        appointments.add(Appointment.fromMap(appointmentData));
      }
    }

    appointments.sort((a, b) {
      DateTime dateA = a.date;
      DateTime dateB = b.date;
      return upcoming ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return appointments;
  }
}
