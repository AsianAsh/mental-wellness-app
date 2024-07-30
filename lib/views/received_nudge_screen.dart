import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/nudge_controller.dart';
import 'package:intl/intl.dart';

class ReceivedNudgesScreen extends StatefulWidget {
  @override
  _ReceivedNudgesScreenState createState() => _ReceivedNudgesScreenState();
}

class _ReceivedNudgesScreenState extends State<ReceivedNudgesScreen> {
  final NudgeController _nudgeController = Get.put(NudgeController());

  @override
  void initState() {
    super.initState();
    _nudgeController.markNudgesAsRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Received Nudges'),
      ),
      body: Obx(() {
        if (_nudgeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_nudgeController.nudges.isEmpty) {
          return Center(child: Text('No nudges received.'));
        }

        return ListView(
          // padding: const EdgeInsets.all(8.0),
          children: _nudgeController.nudges.map((nudge) {
            return Dismissible(
              key: Key(nudge.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _nudgeController.deleteNudge(nudge.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Nudge deleted')),
                );
              },
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.message, color: Colors.indigo),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              nudge.message,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'From: ${nudge.senderName}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        _formatTimestamp(nudge.timestamp),
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else {
      return DateFormat('d MMM').format(dateTime);
    }
  }
}
