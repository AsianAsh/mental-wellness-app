import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_wellness_app/controllers/counsellor_controller.dart';
import 'package:mental_wellness_app/models/counsellor.dart';
import 'package:mental_wellness_app/widgets/counsellor_card.dart';
import 'package:mental_wellness_app/widgets/appointment_card.dart';

class CounsellingScreen extends StatefulWidget {
  @override
  _CounsellingScreenState createState() => _CounsellingScreenState();
}

class _CounsellingScreenState extends State<CounsellingScreen> {
  final CounsellorController _counsellorController = CounsellorController();
  late Future<List<Counsellor>> _counsellorsFuture;

  @override
  void initState() {
    super.initState();
    _counsellorsFuture = _counsellorController.fetchActiveCounsellors();
  }

  Future<List<Map<String, dynamic>>> _fetchUserAppointments(
      {required bool upcoming}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    String userId = currentUser.uid;
    String status = upcoming ? 'booked' : 'completed';

    QuerySnapshot counsellorsSnapshot =
        await FirebaseFirestore.instance.collection('counsellors').get();

    List<Map<String, dynamic>> appointments = [];

    for (var counsellorDoc in counsellorsSnapshot.docs) {
      var counsellorData = counsellorDoc.data() as Map<String, dynamic>;
      QuerySnapshot appointmentSnapshot = await counsellorDoc.reference
          .collection('appointments')
          .where('bookedBy', isEqualTo: userId)
          .where('status', isEqualTo: status)
          .get();

      for (var appointmentDoc in appointmentSnapshot.docs) {
        var appointmentData = appointmentDoc.data() as Map<String, dynamic>;
        appointmentData['counsellorDetails'] = counsellorData;
        appointmentData['appointmentId'] = appointmentDoc.id;
        appointmentData['counsellorId'] = counsellorDoc.id;
        appointments.add(appointmentData);
      }
    }

    appointments.sort((a, b) {
      DateTime dateA = (a['date'] as Timestamp).toDate();
      DateTime dateB = (b['date'] as Timestamp).toDate();
      return upcoming ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Counselling'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Counsellors'),
              Tab(text: 'Appointment'),
              Tab(text: 'History'),
            ],
            labelColor: Colors.white, // Selected tab text color
            unselectedLabelColor: Colors.grey, // Unselected tab text color
            onTap: (index) {
              setState(() {});
            },
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Counsellor>>(
              future: _counsellorsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No active counsellors found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Counsellor counsellor = snapshot.data![index];
                      return CounsellorCard(counsellor: counsellor);
                    },
                  );
                }
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchUserAppointments(upcoming: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No upcoming appointments found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> appointment = snapshot.data![index];
                      return AppointmentCard(appointment: appointment);
                    },
                  );
                }
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchUserAppointments(upcoming: false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No past appointments found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> appointment = snapshot.data![index];
                      return AppointmentCard(appointment: appointment);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
