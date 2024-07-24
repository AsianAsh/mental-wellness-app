// models/appointment.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String bookedBy;
  final String meetingLink;
  final String reason;
  final String summary;

  Appointment({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.bookedBy,
    required this.meetingLink,
    required this.reason,
    required this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'bookedBy': bookedBy,
      'meetingLink': meetingLink,
      'reason': reason,
      'summary': summary,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      date: (map['date'] as Timestamp).toDate(),
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
      status: map['status'],
      bookedBy: map['bookedBy'],
      meetingLink: map['meetingLink'],
      reason: map['reason'],
      summary: map['summary'],
    );
  }
}
