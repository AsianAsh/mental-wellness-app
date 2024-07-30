// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/auth/auth_screen.dart';
// import 'package:mental_wellness_app/views/counsellor/counsellor_appointment_detail_screen.dart';
// import 'package:mental_wellness_app/views/counsellor/set_appointments_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CounsellorHomeScreen extends StatefulWidget {
//   static final CounsellorHomeScreen instance = CounsellorHomeScreen();

//   @override
//   _CounsellorHomeScreenState createState() => _CounsellorHomeScreenState();
// }

// class _CounsellorHomeScreenState extends State<CounsellorHomeScreen> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     AppointmentsScreen(),
//     HistoryScreen(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _logout(BuildContext context) {
//     FirebaseAuth.instance.signOut();
//     Get.offAll(() => const AuthScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counsellor Home'),
//         leading: IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: () {
//             _logout(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.calendar_month_outlined),
//             onPressed: () {
//               Get.to(() => SetAppointmentsScreen());
//             },
//           ),
//         ],
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Appointments',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.indigo[600],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class AppointmentsScreen extends StatelessWidget {
//   Future<List<Map<String, dynamic>>> _fetchCounsellorAppointments() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return [];

//     String counsellorId = currentUser.uid;

//     QuerySnapshot appointmentSnapshot;
//     try {
//       appointmentSnapshot = await FirebaseFirestore.instance
//           .collection('counsellors')
//           .doc(counsellorId)
//           .collection('appointments')
//           .where('status', isEqualTo: 'booked')
//           .get();
//     } catch (e) {
//       print('Error fetching appointments: $e');
//       return [];
//     }

//     List<Map<String, dynamic>> appointments = [];

//     for (var appointmentDoc in appointmentSnapshot.docs) {
//       var appointmentData = appointmentDoc.data() as Map<String, dynamic>?;

//       if (appointmentData == null) {
//         print('Appointment data is null for doc ID: ${appointmentDoc.id}');
//         continue;
//       }

//       DocumentSnapshot memberDoc;
//       try {
//         memberDoc = await FirebaseFirestore.instance
//             .collection('Members')
//             .doc(appointmentData['bookedBy'])
//             .get();
//       } catch (e) {
//         print(
//             'Error fetching member data for appointment ${appointmentDoc.id}: $e');
//         continue;
//       }

//       var memberData = memberDoc.data() as Map<String, dynamic>?;

//       if (memberData == null) {
//         print('Member document not found for appointment ${appointmentDoc.id}');
//         continue;
//       }

//       appointmentData['appointmentId'] = appointmentDoc.id;
//       appointmentData['counsellorId'] = counsellorId;
//       appointmentData['memberDetails'] = memberData;
//       appointments.add(appointmentData);
//     }

//     appointments.sort((a, b) {
//       DateTime dateA = (a['date'] as Timestamp).toDate();
//       DateTime dateB = (b['date'] as Timestamp).toDate();
//       return dateA.compareTo(dateB);
//     });

//     return appointments;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _fetchCounsellorAppointments(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No booked appointments found'));
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               Map<String, dynamic> appointment = snapshot.data![index];
//               return AppointmentCard(
//                 appointment: appointment,
//                 isEditable: true,
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

// // class HistoryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text('History Screen'),
// //     );
// //   }
// // }

// class HistoryScreen extends StatelessWidget {
//   Future<List<Map<String, dynamic>>> _fetchCompletedAppointments() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return [];

//     String counsellorId = currentUser.uid;

//     QuerySnapshot appointmentSnapshot;
//     try {
//       appointmentSnapshot = await FirebaseFirestore.instance
//           .collection('counsellors')
//           .doc(counsellorId)
//           .collection('appointments')
//           .where('status', isEqualTo: 'completed')
//           .get();
//     } catch (e) {
//       print('Error fetching completed appointments: $e');
//       return [];
//     }

//     List<Map<String, dynamic>> appointments = [];

//     for (var appointmentDoc in appointmentSnapshot.docs) {
//       var appointmentData = appointmentDoc.data() as Map<String, dynamic>?;

//       if (appointmentData == null) {
//         print('Appointment data is null for doc ID: ${appointmentDoc.id}');
//         continue;
//       }

//       DocumentSnapshot memberDoc;
//       try {
//         memberDoc = await FirebaseFirestore.instance
//             .collection('Members')
//             .doc(appointmentData['bookedBy'])
//             .get();
//       } catch (e) {
//         print(
//             'Error fetching member data for appointment ${appointmentDoc.id}: $e');
//         continue;
//       }

//       var memberData = memberDoc.data() as Map<String, dynamic>?;

//       if (memberData == null) {
//         print('Member document not found for appointment ${appointmentDoc.id}');
//         continue;
//       }

//       appointmentData['appointmentId'] = appointmentDoc.id;
//       appointmentData['counsellorId'] = counsellorId;
//       appointmentData['memberDetails'] = memberData;
//       appointments.add(appointmentData);
//     }

//     appointments.sort((a, b) {
//       DateTime startTimeA = (a['startTime'] as Timestamp).toDate();
//       DateTime startTimeB = (b['startTime'] as Timestamp).toDate();
//       return startTimeB.compareTo(startTimeA);
//     });

//     return appointments;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _fetchCompletedAppointments(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No completed appointments found'));
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               Map<String, dynamic> appointment = snapshot.data![index];
//               return AppointmentCard(
//                 appointment: appointment,
//                 isEditable: false,
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   Future<Map<String, dynamic>?> fetchCounsellorData() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return null;

//     DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
//         .collection('counsellors')
//         .doc(currentUser.uid)
//         .get();

//     return docSnapshot.data() as Map<String, dynamic>?;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>?>(
//       future: fetchCounsellorData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data == null) {
//           return Center(child: Text('No data available'));
//         } else {
//           Map<String, dynamic> data = snapshot.data!;
//           String profilePic = data['profilePic'].isNotEmpty
//               ? data['profilePic']
//               : 'assets/images/default_profile.png';
//           String title = data['title'] ?? '';
//           String firstName = data['firstName'];
//           String lastName = data['lastName'];
//           String jobTitle = data['jobTitle'];
//           String city = data['city'];
//           String country = data['country'];
//           String bio = data['bio'];
//           String email = data['email'];
//           String education = data['education'];
//           List<String> languages = List<String>.from(data['languages']);
//           int experienceYears = data['experienceYears'];
//           String linkedin = data['linkedin'];
//           Timestamp joinedAtTimestamp = data['joinedAt'];
//           String joinedAt =
//               DateFormat.yMMMd().format(joinedAtTimestamp.toDate());

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Center(
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: CircleAvatar(
//                               radius: 50,
//                               backgroundImage: AssetImage(profilePic),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Center(
//                             child: Text(
//                               '$title. $firstName $lastName',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Text(
//                               jobTitle,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Text(
//                               '$city, $country',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Text(
//                             'Biography',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(bio),
//                           SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Icon(Icons.email, color: Colors.grey[700]),
//                               SizedBox(width: 10),
//                               Flexible(
//                                 child: Text(
//                                   'Email: $email',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Icon(Icons.school, color: Colors.grey[700]),
//                               SizedBox(width: 10),
//                               Flexible(
//                                 child: Text(
//                                   'Education: $education',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Icon(Icons.language, color: Colors.grey[700]),
//                               SizedBox(width: 10),
//                               Flexible(
//                                 child: Text(
//                                   'Languages: ${languages.join(', ')}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Icon(Icons.work, color: Colors.grey[700]),
//                               SizedBox(width: 10),
//                               Flexible(
//                                 child: Text(
//                                   'Years of Experience: $experienceYears',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Icon(Icons.link, color: Colors.grey[700]),
//                               SizedBox(width: 10),
//                               Flexible(
//                                 child: InkWell(
//                                   onTap: () async {
//                                     if (await canLaunch(linkedin)) {
//                                       await launch(linkedin);
//                                     } else {
//                                       throw 'Could not launch $linkedin';
//                                     }
//                                   },
//                                   child: Text(
//                                     'LinkedIn: $linkedin',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.blue,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Joined At: $joinedAt',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// // class AppointmentCard extends StatelessWidget {
// //   final Map<String, dynamic> appointment;

// //   const AppointmentCard({Key? key, required this.appointment})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     var memberDetails = appointment['memberDetails'] as Map<String, dynamic>?;

// //     if (memberDetails == null) {
// //       return Card(
// //         margin: EdgeInsets.all(8.0),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
// //           child: Text('Member details are missing.'),
// //         ),
// //       );
// //     }

// //     return Card(
// //       margin: EdgeInsets.all(8.0),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     '${memberDetails['firstName']} ${memberDetails['lastName']}',
// //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                   ),
// //                   Text(
// //                     'Date: ${DateFormat('dd MMM yyyy').format((appointment['date'] as Timestamp).toDate())}',
// //                     style: TextStyle(fontSize: 14),
// //                   ),
// //                   Text(
// //                     'Time: ${DateFormat('hh:mm a').format((appointment['startTime'] as Timestamp).toDate())} - ${DateFormat('hh:mm a').format((appointment['endTime'] as Timestamp).toDate())}',
// //                     style: TextStyle(fontSize: 14),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             IconButton(
// //               icon:
// //                   Icon(Icons.more_vert_rounded, color: Colors.indigo, size: 30),
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => CounsellorAppointmentDetailScreen(
// //                       appointment: appointment,
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class AppointmentCard extends StatelessWidget {
//   final Map<String, dynamic> appointment;
//   final bool isEditable;

//   const AppointmentCard({
//     Key? key,
//     required this.appointment,
//     required this.isEditable,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var memberDetails = appointment['memberDetails'] as Map<String, dynamic>?;

//     if (memberDetails == null) {
//       return Card(
//         margin: EdgeInsets.all(8.0),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//           child: Text('Member details are missing.'),
//         ),
//       );
//     }

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
//                     '${memberDetails['firstName']} ${memberDetails['lastName']}',
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
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CounsellorAppointmentDetailScreen(
//                       appointment: appointment,
//                       isEditable: isEditable,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// with button to go to edit counsellor profile screen
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/auth/auth_screen.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_appointment_detail_screen.dart';
import 'package:mental_wellness_app/views/counsellor/counsellor_update_profile_screen.dart';
import 'package:mental_wellness_app/views/counsellor/set_appointments_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CounsellorHomeScreen extends StatefulWidget {
  static final CounsellorHomeScreen instance = CounsellorHomeScreen();

  @override
  _CounsellorHomeScreenState createState() => _CounsellorHomeScreenState();
}

class _CounsellorHomeScreenState extends State<CounsellorHomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AppointmentsScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counsellor Home'),
        leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: "",
                titleStyle: const TextStyle(fontSize: 20),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout,
                        size: 80, color: Colors.indigo[800]), // Larger icon
                    SizedBox(height: 20), // More space below the icon
                    Text(
                      "Are you sure you want to logout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 220, // Make buttons the same width
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _logout(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[800],
                          side: BorderSide.none,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15), // Make button wider
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Less circular border
                          ),
                        ),
                        child: Text(
                          "Yes, Log Me Out",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Space between buttons
                    SizedBox(
                      width: 220, // Make buttons the same width
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.indigo),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15), // Make button wider
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Less circular border
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.indigo[800]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month_outlined),
            onPressed: () {
              Get.to(() => SetAppointmentsScreen());
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo[600],
        onTap: _onItemTapped,
      ),
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  Future<List<Map<String, dynamic>>> _fetchCounsellorAppointments() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    String counsellorId = currentUser.uid;

    QuerySnapshot appointmentSnapshot;
    try {
      appointmentSnapshot = await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(counsellorId)
          .collection('appointments')
          .where('status', isEqualTo: 'booked')
          .get();
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }

    List<Map<String, dynamic>> appointments = [];

    for (var appointmentDoc in appointmentSnapshot.docs) {
      var appointmentData = appointmentDoc.data() as Map<String, dynamic>?;

      if (appointmentData == null) {
        print('Appointment data is null for doc ID: ${appointmentDoc.id}');
        continue;
      }

      DocumentSnapshot memberDoc;
      try {
        memberDoc = await FirebaseFirestore.instance
            .collection('Members')
            .doc(appointmentData['bookedBy'])
            .get();
      } catch (e) {
        print(
            'Error fetching member data for appointment ${appointmentDoc.id}: $e');
        continue;
      }

      var memberData = memberDoc.data() as Map<String, dynamic>?;

      if (memberData == null) {
        print('Member document not found for appointment ${appointmentDoc.id}');
        continue;
      }

      appointmentData['appointmentId'] = appointmentDoc.id;
      appointmentData['counsellorId'] = counsellorId;
      appointmentData['memberDetails'] = memberData;
      appointments.add(appointmentData);
    }

    appointments.sort((a, b) {
      DateTime dateA = (a['date'] as Timestamp).toDate();
      DateTime dateB = (b['date'] as Timestamp).toDate();
      return dateA.compareTo(dateB);
    });

    return appointments;
  }

  Future<void> _refreshAppointments() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchCounsellorAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No booked appointments found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> appointment = snapshot.data![index];
              return AppointmentCard(
                appointment: appointment,
                isEditable: true,
                onUpdate: _refreshAppointments, // Pass the refresh function
              );
            },
          );
        }
      },
    );
  }
}

// class HistoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('History Screen'),
//     );
//   }
// }

class HistoryScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _fetchCompletedAppointments() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    String counsellorId = currentUser.uid;

    QuerySnapshot appointmentSnapshot;
    try {
      appointmentSnapshot = await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(counsellorId)
          .collection('appointments')
          .where('status', isEqualTo: 'completed')
          .get();
    } catch (e) {
      print('Error fetching completed appointments: $e');
      return [];
    }

    List<Map<String, dynamic>> appointments = [];

    for (var appointmentDoc in appointmentSnapshot.docs) {
      var appointmentData = appointmentDoc.data() as Map<String, dynamic>?;

      if (appointmentData == null) {
        print('Appointment data is null for doc ID: ${appointmentDoc.id}');
        continue;
      }

      DocumentSnapshot memberDoc;
      try {
        memberDoc = await FirebaseFirestore.instance
            .collection('Members')
            .doc(appointmentData['bookedBy'])
            .get();
      } catch (e) {
        print(
            'Error fetching member data for appointment ${appointmentDoc.id}: $e');
        continue;
      }

      var memberData = memberDoc.data() as Map<String, dynamic>?;

      if (memberData == null) {
        print('Member document not found for appointment ${appointmentDoc.id}');
        continue;
      }

      appointmentData['appointmentId'] = appointmentDoc.id;
      appointmentData['counsellorId'] = counsellorId;
      appointmentData['memberDetails'] = memberData;
      appointments.add(appointmentData);
    }

    appointments.sort((a, b) {
      DateTime startTimeA = (a['startTime'] as Timestamp).toDate();
      DateTime startTimeB = (b['startTime'] as Timestamp).toDate();
      return startTimeB.compareTo(startTimeA);
    });

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchCompletedAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No completed appointments found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> appointment = snapshot.data![index];
              return AppointmentCard(
                appointment: appointment,
                isEditable: false,
              );
            },
          );
        }
      },
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Map<String, dynamic>?> fetchCounsellorData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('counsellors')
        .doc(currentUser.uid)
        .get();

    return docSnapshot.data() as Map<String, dynamic>?;
  }

  String _addHttpIfNeeded(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  Future<void> _navigateAndRefresh(BuildContext context) async {
    bool? result = await Get.to(() => UpdateCounsellorProfileScreen());
    if (result == true) {
      setState(() {
        // Trigger rebuild to refresh data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchCounsellorData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data available'));
        } else {
          Map<String, dynamic> data = snapshot.data!;
          String profilePic = data['profilePic'].isNotEmpty
              ? data['profilePic']
              : 'assets/images/default_profile.png';
          String title = data['title'] ?? '';
          String firstName = data['firstName'];
          String lastName = data['lastName'];
          String jobTitle = data['jobTitle'];
          String city = data['city'];
          String country = data['country'];
          String bio = data['bio'];
          String email = data['email'];
          String education = data['education'];
          List<String> languages = List<String>.from(data['languages']);
          int experienceYears = data['experienceYears'];
          String linkedin = data['linkedin'];
          Timestamp joinedAtTimestamp = data['joinedAt'];
          String joinedAt =
              DateFormat.yMMMd().format(joinedAtTimestamp.toDate());

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profilePic.startsWith('http')
                                      ? NetworkImage(profilePic)
                                      : AssetImage(profilePic) as ImageProvider,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  '$title. $firstName $lastName',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  jobTitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$city, $country',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Biography',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(bio),
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.email, color: Colors.grey[700]),
                                  SizedBox(width: 10),
                                  Text(
                                    'Email:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      email,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.school, color: Colors.grey[700]),
                                  SizedBox(width: 10),
                                  Text(
                                    'Education:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      education,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.language, color: Colors.grey[700]),
                                  SizedBox(width: 10),
                                  Text(
                                    'Languages:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      languages.join(', '),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.work, color: Colors.grey[700]),
                                  SizedBox(width: 10),
                                  Text(
                                    'Years of Experience:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '$experienceYears',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.link, color: Colors.grey[700]),
                                  SizedBox(width: 10),
                                  Text(
                                    'LinkedIn:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        final Uri linkedinUrl = Uri.parse(
                                            _addHttpIfNeeded(linkedin));
                                        try {
                                          await launchUrl(linkedinUrl);
                                        } catch (e) {
                                          throw 'Could not launch $linkedin';
                                        }
                                      },
                                      child: Text(
                                        'View LinkedIn Profile',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.indigo[50],
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.indigo),
                                onPressed: () {
                                  _navigateAndRefresh(
                                      context); // Navigate and refresh on return
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Joined At: $joinedAt',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final bool isEditable;
  final Future<void> Function()? onUpdate;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.isEditable,
    this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var memberDetails = appointment['memberDetails'] as Map<String, dynamic>?;

    if (memberDetails == null) {
      return Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Text('Member details are missing.'),
        ),
      );
    }

    String profilePic = memberDetails['profilePic'].isNotEmpty
        ? memberDetails['profilePic']
        : 'assets/images/default_profile.png';

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: profilePic.startsWith('http')
                      ? NetworkImage(profilePic)
                      : AssetImage(profilePic) as ImageProvider,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${memberDetails['firstName']} ${memberDetails['lastName']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Date: ${DateFormat('dd MMM yyyy').format((appointment['date'] as Timestamp).toDate())}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Time: ${DateFormat('hh:mm a').format((appointment['startTime'] as Timestamp).toDate())} - ${DateFormat('hh:mm a').format((appointment['endTime'] as Timestamp).toDate())}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon:
                  Icon(Icons.more_vert_rounded, color: Colors.indigo, size: 30),
              onPressed: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CounsellorAppointmentDetailScreen(
                      appointment: appointment,
                      isEditable: isEditable,
                    ),
                  ),
                );
                if (result == true) {
                  // Refresh the appointments if the appointment was updated
                  if (onUpdate != null) await onUpdate!();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
