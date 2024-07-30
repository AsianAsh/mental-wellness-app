import 'package:cloud_firestore/cloud_firestore.dart';

class FriendProfile {
  final String name;
  final String email;
  final String bio;
  final int level;
  final int dailyStreak;
  final String country;
  final Timestamp createdAt;
  final Timestamp lastActive;
  final String profilePic;

  FriendProfile({
    required this.name,
    required this.email,
    required this.bio,
    required this.level,
    required this.dailyStreak,
    required this.country,
    required this.createdAt,
    required this.lastActive,
    required this.profilePic,
  });
}
