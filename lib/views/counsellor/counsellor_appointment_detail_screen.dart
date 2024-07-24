// // For counsellors to see detailed view of their appointments (including viewing member details who booked the appointment)
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CounsellorAppointmentDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> appointment;

//   CounsellorAppointmentDetailScreen({required this.appointment});

//   @override
//   _CounsellorAppointmentDetailScreenState createState() =>
//       _CounsellorAppointmentDetailScreenState();
// }

// class _CounsellorAppointmentDetailScreenState
//     extends State<CounsellorAppointmentDetailScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _meetingLinkController = TextEditingController();
//   final TextEditingController _summaryController = TextEditingController();
//   String _status = 'booked';

//   @override
//   void initState() {
//     super.initState();
//     _meetingLinkController.text = widget.appointment['meetingLink'];
//     _summaryController.text = widget.appointment['summary'];
//     _status = widget.appointment['status'];
//   }

//   void _updateAppointment() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       FirebaseFirestore.instance
//           .collection('counsellors')
//           .doc(widget.appointment['counsellorId'])
//           .collection('appointments')
//           .doc(widget.appointment['appointmentId'])
//           .update({
//         'meetingLink': _meetingLinkController.text,
//         'summary': _summaryController.text,
//         'status': _status,
//       });
//       Navigator.pop(context);
//     }
//   }

//   void _showClientDetails(
//       BuildContext context, Map<String, dynamic> memberDetails) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String profilePic = memberDetails['profilePic'].isNotEmpty
//             ? memberDetails['profilePic']
//             : 'assets/images/default_profile.png';
//         String firstName = memberDetails['firstName'];
//         String lastName = memberDetails['lastName'];
//         String level = memberDetails['level'].toString();
//         int dailyStreak = memberDetails['dailyStreak'];
//         String country = memberDetails['country'].isNotEmpty
//             ? memberDetails['country']
//             : 'Country not specified';
//         String bio = memberDetails['bio'];
//         String email = memberDetails['email'];

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
//                       '$firstName $lastName',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       country,
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
//                   _buildDetailRow('Lvl:', level),
//                   _buildDetailRow('Daily Streak:', dailyStreak.toString()),
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

//   Widget _buildLongDetail(String title, TextEditingController controller) {
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
//             child: TextFormField(
//               controller: controller,
//               maxLines: null,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String memberName =
//         '${widget.appointment['memberDetails']['firstName']} ${widget.appointment['memberDetails']['lastName']}';
//     DateTime date = (widget.appointment['date'] as Timestamp).toDate();
//     DateTime startTime =
//         (widget.appointment['startTime'] as Timestamp).toDate();
//     DateTime endTime = (widget.appointment['endTime'] as Timestamp).toDate();
//     String status = widget.appointment['status'];
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
//           child: Form(
//             key: _formKey,
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           DateFormat('EEE, d MMM yy').format(date),
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           DateFormat('hh:mm a').format(startTime) +
//                               ' - ' +
//                               DateFormat('hh:mm a').format(endTime),
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Divider(),
//                   SizedBox(height: 2),
//                   _buildDetailRow('Member:', memberName),
//                   _buildDetailRow('Status:', formattedStatus,
//                       valueColor: statusColor),
//                   SizedBox(height: 10),
//                   _buildLongDetail(
//                       'Reason:',
//                       TextEditingController(
//                           text: widget.appointment['reason'])),
//                   _buildLongDetail('Summary:', _summaryController),
//                   SizedBox(height: 10),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _showClientDetails(
//                             context, widget.appointment['memberDetails']);
//                       },
//                       child: Text('View Client Details'),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _meetingLinkController,
//                     decoration: InputDecoration(
//                       labelText: 'Meeting Link',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a meeting link';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   DropdownButtonFormField<String>(
//                     value: _status,
//                     items: [
//                       DropdownMenuItem(
//                         child: Text('Ongoing'),
//                         value: 'booked',
//                       ),
//                       DropdownMenuItem(
//                         child: Text('Completed'),
//                         value: 'completed',
//                       ),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         _status = value!;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Status',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: _updateAppointment,
//                       child: Text('Update Appointment'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CounsellorAppointmentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> appointment;
  final bool isEditable;

  CounsellorAppointmentDetailScreen({
    required this.appointment,
    required this.isEditable,
  });

  @override
  _CounsellorAppointmentDetailScreenState createState() =>
      _CounsellorAppointmentDetailScreenState();
}

class _CounsellorAppointmentDetailScreenState
    extends State<CounsellorAppointmentDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _meetingLinkController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  String _status = 'booked';

  @override
  void initState() {
    super.initState();
    _meetingLinkController.text = widget.appointment['meetingLink'];
    _summaryController.text = widget.appointment['summary'];
    _status = widget.appointment['status'];
  }

  void _updateAppointment() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_status == 'completed') {
        _meetingLinkController.text = '-';
      }
      await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(widget.appointment['counsellorId'])
          .collection('appointments')
          .doc(widget.appointment['appointmentId'])
          .update({
        'meetingLink': _meetingLinkController.text,
        'summary': _summaryController.text,
        'status': _status,
      });
      Navigator.pop(context);
    }
  }

  void _showClientDetails(
      BuildContext context, Map<String, dynamic> memberDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String profilePic = memberDetails['profilePic'].isNotEmpty
            ? memberDetails['profilePic']
            : 'assets/images/default_profile.png';
        String firstName = memberDetails['firstName'];
        String lastName = memberDetails['lastName'];
        String level = memberDetails['level'].toString();
        int dailyStreak = memberDetails['dailyStreak'];
        String country = memberDetails['country'].isNotEmpty
            ? memberDetails['country']
            : 'Country not specified';
        String bio = memberDetails['bio'];
        String email = memberDetails['email'];

        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                      '$firstName $lastName',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      country,
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
                  SizedBox(height: 5),
                  Text(bio),
                  SizedBox(height: 10),
                  Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildDetailRow('Email:', email),
                  _buildDetailRow('Lvl:', level),
                  _buildDetailRow('Daily Streak:', dailyStreak.toString()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value,
      {Color? valueColor, VoidCallback? onTap, bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: onTap != null && isLink
                  ? TextButton(
                      onPressed: onTap,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: valueColor ?? Colors.blue,
                          decoration: isLink ? TextDecoration.underline : null,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: valueColor ?? Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.right,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLongDetail(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: controller,
              maxLines: null,
              enabled: widget.isEditable,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _addHttpIfNeeded(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    String memberName =
        '${widget.appointment['memberDetails']['firstName']} ${widget.appointment['memberDetails']['lastName']}';
    DateTime date = (widget.appointment['date'] as Timestamp).toDate();
    DateTime startTime =
        (widget.appointment['startTime'] as Timestamp).toDate();
    DateTime endTime = (widget.appointment['endTime'] as Timestamp).toDate();
    String status = widget.appointment['status'];
    String formattedStatus = status == 'booked'
        ? 'Ongoing'
        : status == 'completed'
            ? 'Completed'
            : status;
    Color statusColor = status == 'booked'
        ? Colors.green
        : status == 'completed'
            ? Colors.blue
            : Colors.black;

    String meetingLinkText = '';
    VoidCallback? meetingLinkCallback;
    bool isLink = false;

    if (status == 'booked' || status == 'ongoing') {
      if (widget.appointment['meetingLink'].isNotEmpty &&
          widget.appointment['meetingLink'] != '-') {
        meetingLinkText = 'Join Meeting';
        meetingLinkCallback = () async {
          final Uri meetingUrl =
              Uri.parse(_addHttpIfNeeded(widget.appointment['meetingLink']));
          try {
            await launchUrl(meetingUrl);
          } catch (e) {
            throw 'Could not launch ${widget.appointment['meetingLink']}';
          }
        };
        isLink = true;
      } else {
        meetingLinkText = 'Coming Soon';
      }
    } else if (status == 'completed') {
      meetingLinkText = '-';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                  _buildDetailRow('Member:', memberName),
                  _buildDetailRow('Meeting Link:', meetingLinkText,
                      onTap: meetingLinkCallback, isLink: isLink),
                  _buildDetailRow('Status:', formattedStatus,
                      valueColor: statusColor),
                  SizedBox(height: 10),
                  _buildLongDetail(
                      'Reason:',
                      TextEditingController(
                          text: widget.appointment['reason'])),
                  _buildLongDetail('Summary:', _summaryController),
                  SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showClientDetails(
                              context, widget.appointment['memberDetails']);
                        },
                        child: Text('View Client Details'),
                      ),
                    ),
                  ),
                  if (widget.isEditable) ...[
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _meetingLinkController,
                      decoration: InputDecoration(
                        labelText: 'Meeting Link',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a meeting link';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _status,
                      items: [
                        DropdownMenuItem(
                          child: Text('Ongoing'),
                          value: 'booked',
                        ),
                        DropdownMenuItem(
                          child: Text('Completed'),
                          value: 'completed',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _status = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _updateAppointment,
                          child: Text('Update Appointment'),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
