// Replaced by member_appointment_detail.screen.dart

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AppointmentDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> appointment;

//   AppointmentDetailScreen({required this.appointment});

//   @override
//   Widget build(BuildContext context) {
//     String counsellorName =
//         '${appointment['counsellorDetails']['title']} ${appointment['counsellorDetails']['firstName']} ${appointment['counsellorDetails']['lastName']}';
//     DateTime date = (appointment['date'] as Timestamp).toDate();
//     DateTime startTime = (appointment['startTime'] as Timestamp).toDate();
//     DateTime endTime = (appointment['endTime'] as Timestamp).toDate();
//     String status = appointment['status'];
//     String formattedStatus = status == 'booked'
//         ? 'Ongoing'
//         : status == 'completed'
//             ? 'Completed'
//             : status;
//     Color statusColor = status == 'booked'
//         ? Colors.green
//         : status == 'completed'
//             ? Colors.blue
//             : Colors.black;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointment Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         DateFormat('EEE, d MMM yy').format(date),
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         DateFormat('hh:mm a').format(startTime) +
//                             ' - ' +
//                             DateFormat('hh:mm a').format(endTime),
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Divider(),
//                 SizedBox(height: 2),
//                 _buildDetailRow('Counsellor:', counsellorName),
//                 _buildDetailRow(
//                     'Meeting Link:',
//                     appointment['meetingLink'].isNotEmpty
//                         ? appointment['meetingLink']
//                         : 'Coming Soon'),
//                 _buildDetailRow('Status:', formattedStatus,
//                     valueColor: statusColor),
//                 SizedBox(height: 10),
//                 _buildLongDetail('Reason:', appointment['reason']),
//                 _buildLongDetail(
//                     'Summary:',
//                     appointment['summary'].isNotEmpty
//                         ? appointment['summary']
//                         : 'No summary provided'),
//                 SizedBox(height: 10),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showCounsellorDetails(
//                           context, appointment['counsellorDetails']);
//                     },
//                     child: Text('View Counsellor Details'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCounsellorDetails(
//       BuildContext context, Map<String, dynamic> counsellorDetails) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String profilePic = counsellorDetails['profilePic'].isNotEmpty
//             ? counsellorDetails['profilePic']
//             : 'assets/images/default_profile.png';
//         String title = counsellorDetails['title'];
//         String firstName = counsellorDetails['firstName'];
//         String lastName = counsellorDetails['lastName'];
//         String jobTitle = counsellorDetails['jobTitle'];
//         String city = counsellorDetails['city'];
//         String country = counsellorDetails['country'];
//         String bio = counsellorDetails['bio'];
//         String email = counsellorDetails['email'];
//         String education = counsellorDetails['education'];
//         List<String> languages =
//             List<String>.from(counsellorDetails['languages']);
//         int experienceYears = counsellorDetails['experienceYears'];
//         String linkedin = counsellorDetails['linkedin'];

//         return Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: Container(
//             width: double.maxFinite,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage(profilePic),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Center(
//                     child: Text(
//                       '$title. $firstName $lastName',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       jobTitle,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       '$city, $country',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Biography',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(bio),
//                   SizedBox(height: 10),
//                   Text(
//                     'Additional Information',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   _buildDetailRow('Email:', email),
//                   _buildDetailRow('Education:', education),
//                   _buildDetailRow('Languages:', languages.join(', ')),
//                   _buildDetailRow('Years of Experience:', '$experienceYears'),
//                   _buildDetailRow(
//                     'LinkedIn:',
//                     linkedin,
//                     onTap: () async {
//                       final Uri linkedinUrl = Uri.parse(linkedin);
//                       if (await canLaunchUrl(linkedinUrl)) {
//                         await launchUrl(linkedinUrl);
//                       } else {
//                         throw 'Could not launch $linkedin';
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(String title, String value,
//       {Color? valueColor, VoidCallback? onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
//               ),
//             ),
//             Flexible(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     color: valueColor ?? Colors.black,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLongDetail(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 5),
//           Container(
//             padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
