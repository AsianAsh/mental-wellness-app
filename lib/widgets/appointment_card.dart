// widgets/appointment_card.dart (accesses member_appointment_detail_screen.dart)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_wellness_app/views/member_appointment_detail_screen.dart';

class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentCard({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counsellorDetails = appointment['counsellorDetails'];

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${counsellorDetails['title']} ${counsellorDetails['firstName']} ${counsellorDetails['lastName']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            ),
            IconButton(
              icon:
                  Icon(Icons.more_vert_rounded, color: Colors.indigo, size: 30),
              onPressed: () {
                Get.to(() =>
                    MemberAppointmentDetailScreen(appointment: appointment));
              },
            ),
          ],
        ),
      ),
    );
  }
}
