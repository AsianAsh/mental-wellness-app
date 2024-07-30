// achievements_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class AchievementsController extends GetxController {
  final FirestoreService firestoreService = FirestoreService();

  Future<List<Map<String, String>>> getEarnedAchievements() {
    return firestoreService.getEarnedAchievements();
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How Achievements Work'),
          content: Text(
              'Achievements are earned by completing various tasks and milestones within the app. Each achievement has specific criteria that must be met to unlock it.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
