// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MemberAppointmentDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> appointment;

//   MemberAppointmentDetailScreen({required this.appointment});

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
//                         ? 'Join Meeting'
//                         : 'Coming Soon',
//                     onTap: appointment['meetingLink'].isNotEmpty
//                         ? () async {
//                             final Uri meetingUrl = Uri.parse(
//                                 _addHttpIfNeeded(appointment['meetingLink']));
//                             try {
//                               await launchUrl(meetingUrl);
//                             } catch (e) {
//                               throw 'Could not launch ${appointment['meetingLink']}';
//                             }
//                           }
//                         : null,
//                     isLink: appointment['meetingLink'].isNotEmpty),
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
//                       backgroundImage:
//                           profilePic != 'assets/images/default_profile.png'
//                               ? NetworkImage(profilePic)
//                               : AssetImage(profilePic) as ImageProvider,
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
//                     'View LinkedIn Profile',
//                     onTap: () async {
//                       final Uri linkedinUrl =
//                           Uri.parse(_addHttpIfNeeded(linkedin));
//                       try {
//                         await launchUrl(linkedinUrl);
//                       } catch (e) {
//                         throw 'Could not launch $linkedin';
//                       }
//                     },
//                     isLink: true,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _addHttpIfNeeded(String url) {
//     if (!url.startsWith('http://') && !url.startsWith('https://')) {
//       return 'https://$url';
//     }
//     return url;
//   }

//   Widget _buildDetailRow(String title, String value,
//       {Color? valueColor, VoidCallback? onTap, bool isLink = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
//           ),
//           Flexible(
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: onTap != null
//                   ? TextButton(
//                       onPressed: onTap,
//                       child: Text(
//                         value,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.normal,
//                           color: valueColor ?? Colors.blue,
//                           decoration: isLink ? TextDecoration.underline : null,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     )
//                   : Text(
//                       value,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.normal,
//                         color: valueColor ?? Colors.black,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       textAlign: TextAlign.right,
//                     ),
//             ),
//           ),
//         ],
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

// organized
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/helper/helper_functions.dart';
import 'package:mental_wellness_app/widgets/counsellor_details_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mental_wellness_app/widgets/detail_row.dart';
import 'package:mental_wellness_app/widgets/long_detail.dart';
// import 'package:mental_wellness_app/utils/url_utils.dart';

class MemberAppointmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;

  MemberAppointmentDetailScreen({required this.appointment});

  @override
  Widget build(BuildContext context) {
    String counsellorName =
        '${appointment['counsellorDetails']['title']} ${appointment['counsellorDetails']['firstName']} ${appointment['counsellorDetails']['lastName']}';
    DateTime date = (appointment['date'] as Timestamp).toDate();
    DateTime startTime = (appointment['startTime'] as Timestamp).toDate();
    DateTime endTime = (appointment['endTime'] as Timestamp).toDate();
    String status = appointment['status'];
    String formattedStatus = _getFormattedStatus(status);
    Color statusColor = _getStatusColor(status);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EEE, d MMM yy').format(date),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(startTime) +
                            ' - ' +
                            DateFormat('hh:mm a').format(endTime),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 2),
                DetailRow(title: 'Counsellor:', value: counsellorName),
                DetailRow(
                    title: 'Meeting Link:',
                    value: appointment['meetingLink'].isNotEmpty
                        ? 'Join Meeting'
                        : 'Coming Soon',
                    onTap: appointment['meetingLink'].isNotEmpty
                        ? () async {
                            final Uri meetingUrl = Uri.parse(
                                _addHttpIfNeeded(appointment['meetingLink']));
                            try {
                              await launchUrl(meetingUrl);
                            } catch (e) {
                              throw 'Could not launch ${appointment['meetingLink']}';
                            }
                          }
                        : null,
                    isLink: appointment['meetingLink'].isNotEmpty),
                DetailRow(
                    title: 'Status:',
                    value: formattedStatus,
                    valueColor: statusColor),
                SizedBox(height: 10),
                LongDetail(title: 'Reason:', value: appointment['reason']),
                LongDetail(
                    title: 'Summary:',
                    value: appointment['summary'].isNotEmpty
                        ? appointment['summary']
                        : 'No summary provided'),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showCounsellorDetails(
                          context, appointment['counsellorDetails']);
                    },
                    child: Text('View Counsellor Details'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _addHttpIfNeeded(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  String _getFormattedStatus(String status) {
    switch (status) {
      case 'booked':
        return 'Ongoing';
      case 'completed':
        return 'Completed';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'booked':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  void _showCounsellorDetails(
      BuildContext context, Map<String, dynamic> counsellorDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CounsellorDetailsDialog(counsellorDetails: counsellorDetails);
      },
    );
  }
}
