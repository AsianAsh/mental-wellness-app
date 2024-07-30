// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/counsellor_controller.dart';
// import 'package:mental_wellness_app/models/counsellor.dart';
// import 'book_appointment_screen.dart';
// import 'member_appointment_detail_screen.dart';

// class CounsellingScreen extends StatefulWidget {
//   @override
//   _CounsellingScreenState createState() => _CounsellingScreenState();
// }

// class _CounsellingScreenState extends State<CounsellingScreen> {
//   int _selectedIndex = 0;
//   final CounsellorController _counsellorController = CounsellorController();
//   late Future<List<Counsellor>> _counsellorsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _counsellorsFuture = _counsellorController.fetchActiveCounsellors();
//   }

//   Future<List<Map<String, dynamic>>> _fetchUserAppointments(
//       {required bool upcoming}) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return [];

//     String userId = currentUser.uid;
//     String status = upcoming ? 'booked' : 'completed';

//     QuerySnapshot counsellorsSnapshot =
//         await FirebaseFirestore.instance.collection('counsellors').get();

//     List<Map<String, dynamic>> appointments = [];

//     for (var counsellorDoc in counsellorsSnapshot.docs) {
//       var counsellorData = counsellorDoc.data() as Map<String, dynamic>;
//       QuerySnapshot appointmentSnapshot = await counsellorDoc.reference
//           .collection('appointments')
//           .where('bookedBy', isEqualTo: userId)
//           .where('status', isEqualTo: status)
//           .get();

//       for (var appointmentDoc in appointmentSnapshot.docs) {
//         var appointmentData = appointmentDoc.data() as Map<String, dynamic>;
//         appointmentData['counsellorDetails'] = counsellorData;
//         appointmentData['appointmentId'] = appointmentDoc.id;
//         appointmentData['counsellorId'] = counsellorDoc.id;
//         appointments.add(appointmentData);
//       }
//     }

//     appointments.sort((a, b) {
//       DateTime dateA = (a['date'] as Timestamp).toDate();
//       DateTime dateB = (b['date'] as Timestamp).toDate();
//       return upcoming ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
//     });

//     return appointments;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Counselling'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Counsellors'),
//               Tab(text: 'Appointment'),
//               Tab(text: 'History'),
//             ],
//             labelColor: Colors.white, // Selected tab text color
//             unselectedLabelColor: Colors.grey, // Unselected tab text color
//             onTap: (index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             FutureBuilder<List<Counsellor>>(
//               future: _counsellorsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No active counsellors found'));
//                 } else {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       Counsellor counsellor = snapshot.data![index];
//                       return CounsellorCard(counsellor: counsellor);
//                     },
//                   );
//                 }
//               },
//             ),
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: _fetchUserAppointments(upcoming: true),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No upcoming appointments found'));
//                 } else {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       Map<String, dynamic> appointment = snapshot.data![index];
//                       return AppointmentCard(appointment: appointment);
//                     },
//                   );
//                 }
//               },
//             ),
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: _fetchUserAppointments(upcoming: false),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No past appointments found'));
//                 } else {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       Map<String, dynamic> appointment = snapshot.data![index];
//                       return AppointmentCard(appointment: appointment);
//                     },
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CounsellorCard extends StatelessWidget {
//   final Counsellor counsellor;

//   const CounsellorCard({Key? key, required this.counsellor}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundImage: counsellor.profilePic.isNotEmpty
//                       ? NetworkImage(counsellor.profilePic)
//                       : AssetImage('assets/images/default_profile.png')
//                           as ImageProvider,
//                 ),
//                 SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${counsellor.title} ${counsellor.firstName} ${counsellor.lastName}',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     Text(
//                       '${counsellor.jobTitle}, ${counsellor.city}, ${counsellor.country}',
//                       style: TextStyle(fontSize: 13, color: Colors.black87),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             if (counsellor.specializations.isNotEmpty) ...[
//               SizedBox(height: 6),
//               Wrap(
//                 spacing: 4.0,
//                 runSpacing: 0.0,
//                 children: counsellor.specializations
//                     .map((specialization) => Chip(
//                           label: Text(
//                             specialization,
//                             style: TextStyle(fontSize: 11),
//                           ),
//                           backgroundColor: Colors.indigo[100],
//                           labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
//                         ))
//                     .toList(),
//               ),
//             ],
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to CounsellorDetailScreen
//                 Get.to(() => CounsellorDetailScreen(
//                       counsellor: counsellor,
//                     ));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.indigo, // Button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8), // Less circular
//                 ),
//                 minimumSize: Size(double.infinity, 36), // Full width button
//               ),
//               child: Text(
//                 'Book Appointment',
//                 style: TextStyle(color: Colors.white), // White text
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AppointmentCard extends StatelessWidget {
//   final Map<String, dynamic> appointment;

//   const AppointmentCard({Key? key, required this.appointment})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var counsellorDetails = appointment['counsellorDetails'];

//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${counsellorDetails['title']} ${counsellorDetails['firstName']} ${counsellorDetails['lastName']}',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Date: ${DateFormat('dd MMM yyyy').format((appointment['date'] as Timestamp).toDate())}',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   Text(
//                     'Time: ${DateFormat('hh:mm a').format((appointment['startTime'] as Timestamp).toDate())} - ${DateFormat('hh:mm a').format((appointment['endTime'] as Timestamp).toDate())}',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon:
//                   Icon(Icons.more_vert_rounded, color: Colors.indigo, size: 30),
//               onPressed: () {
//                 Get.to(() => MemberAppointmentDetailScreen(
//                       appointment: appointment,
//                     ));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/counsellor_controller.dart';
import 'package:mental_wellness_app/models/counsellor.dart';
import 'package:mental_wellness_app/views/book_appointment_screen.dart';
import 'package:mental_wellness_app/views/member_appointment_detail_screen.dart';
import 'package:mental_wellness_app/widgets/counsellor_card.dart';
import 'package:mental_wellness_app/widgets/appointment_card.dart';

class CounsellingScreen extends StatefulWidget {
  @override
  _CounsellingScreenState createState() => _CounsellingScreenState();
}

class _CounsellingScreenState extends State<CounsellingScreen> {
  int _selectedIndex = 0;
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
              setState(() {
                _selectedIndex = index;
              });
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
