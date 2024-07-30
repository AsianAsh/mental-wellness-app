// widgets/counsellor_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/models/counsellor.dart';
import 'package:mental_wellness_app/views/book_appointment_screen.dart';

class CounsellorCard extends StatelessWidget {
  final Counsellor counsellor;

  const CounsellorCard({Key? key, required this.counsellor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: counsellor.profilePic.isNotEmpty
                      ? NetworkImage(counsellor.profilePic)
                      : AssetImage('assets/images/default_profile.png')
                          as ImageProvider,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${counsellor.title} ${counsellor.firstName} ${counsellor.lastName}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${counsellor.jobTitle}, ${counsellor.city}, ${counsellor.country}',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
            if (counsellor.specializations.isNotEmpty) ...[
              SizedBox(height: 6),
              Wrap(
                spacing: 4.0,
                runSpacing: 0.0,
                children: counsellor.specializations
                    .map((specialization) => Chip(
                          label: Text(
                            specialization,
                            style: TextStyle(fontSize: 11),
                          ),
                          backgroundColor: Colors.indigo[100],
                          labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        ))
                    .toList(),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                Get.to(() => CounsellorDetailScreen(counsellor: counsellor));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Less circular
                ),
                minimumSize: Size(double.infinity, 36), // Full width button
              ),
              child: Text(
                'Book Appointment',
                style: TextStyle(color: Colors.white), // White text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
