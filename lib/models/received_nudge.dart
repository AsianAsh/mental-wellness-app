import 'package:cloud_firestore/cloud_firestore.dart';

class Nudge {
  final String id;
  final String message;
  final String senderName;
  final Timestamp timestamp;
  final bool read;

  Nudge({
    required this.id,
    required this.message,
    required this.senderName,
    required this.timestamp,
    required this.read,
  });

  factory Nudge.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Nudge(
      id: doc.id, // Get the document ID from the snapshot
      message: data['message'],
      senderName: data['senderName'],
      timestamp: data['timestamp'],
      read: data['read'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderName': senderName,
      'timestamp': timestamp,
      'read': read,
    };
  }
}
