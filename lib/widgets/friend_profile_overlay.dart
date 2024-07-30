import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/models/friend_profile.dart';

class FriendProfileOverlay extends StatelessWidget {
  final FriendProfile profile;

  const FriendProfileOverlay({Key? key, required this.profile})
      : super(key: key);

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('d MMMM y').format(dateTime);
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100, // radius * 2
                      height: 100, // radius * 2
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profile.profilePic.isNotEmpty
                            ? NetworkImage(profile.profilePic)
                            : AssetImage('assets/images/default_profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      profile.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      profile.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInfoCard('Bio', profile.bio, Icons.info_outline,
                      Colors.blueAccent),
                  _buildInfoCard('Country', profile.country, Icons.location_on,
                      Colors.green),
                  _buildInfoCard('Daily Streak', profile.dailyStreak.toString(),
                      Icons.whatshot, Colors.red),
                  _buildInfoCard('Level', profile.level.toString(), Icons.star,
                      Colors.amber),
                  _buildInfoCard(
                      'Last online',
                      _formatTimeAgo(profile.lastActive.toDate()),
                      Icons.access_time,
                      Colors.purple),
                  _buildInfoCard(
                      'Joined on',
                      _formatTimestamp(profile.createdAt),
                      Icons.calendar_today,
                      Colors.teal),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String label, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      value.isNotEmpty ? value : 'No data',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
