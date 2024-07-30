import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/widgets/counsellor_details_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mental_wellness_app/widgets/detail_row.dart';
import 'package:mental_wellness_app/widgets/long_detail.dart';

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
