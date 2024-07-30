// // profile_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/auth/auth_screen.dart';

class ProfileController extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  Rxn<Map<String, dynamic>> userDetails = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    isLoading.value = true;
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestoreService.getMemberDetails();
      userDetails.value = userDoc.data();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load user data",
        backgroundColor: Colors.white60,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(() => const AuthScreen());
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Get.snackbar(
        "Error",
        "User not logged in",
        backgroundColor: Colors.white60,
      );
      return;
    }

    String memberId = currentUser.uid;

    await firestoreService.deleteAccount(memberId, context);

    // Delete Firebase Authentication user
    await currentUser.delete();

    // Navigate to login screen
    Get.offAll(() => const AuthScreen());
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text(
              "Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Get.back(); // Close the dialog
                await deleteAccount(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Daily Streak Info"),
          content: const Text(
              "To increase your daily streak, complete all tasks in your daily routine. If you do not complete your routine before the next day, the streak will be reset to 0. The longer the streak, the higher the multiplier when earning points."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  int calculateRequiredPoints(int level) {
    return firestoreService.calculateRequiredPoints(level);
  }
}
