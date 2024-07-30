import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class AddFriendController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  void sendFriendRequest() async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter an email",
        backgroundColor: Colors.white60,
      );
      return;
    }

    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      Get.snackbar(
        "Error",
        "User not logged in",
        backgroundColor: Colors.white60,
      );
      return;
    }

    if (email == currentUser.email) {
      Get.snackbar(
        "Error",
        "You cannot send a friend request to yourself",
        backgroundColor: Colors.white60,
      );
      return;
    }

    bool userExists = await _firestoreService.checkUserExistsByEmail(email);
    if (!userExists) {
      Get.snackbar(
        "Error",
        "Member with email $email not found",
        backgroundColor: Colors.white60,
      );
      return;
    }

    bool alreadyFriends =
        await _firestoreService.checkAlreadyFriends(currentUser.uid, email);
    if (alreadyFriends) {
      Get.snackbar(
        "Error",
        "This member is already your friend",
        backgroundColor: Colors.white60,
      );
      return;
    }

    bool requestPending = await _firestoreService.checkPendingFriendRequest(
        currentUser.uid, email);
    if (requestPending) {
      Get.snackbar(
        "Info",
        "Friend request already sent and pending",
        backgroundColor: Colors.white60,
      );
      return;
    }

    bool requestReceived = await _firestoreService.checkReceivedFriendRequest(
        currentUser.uid, email);
    if (requestReceived) {
      Get.snackbar(
        "Info",
        "You have already received a friend request from this member",
        backgroundColor: Colors.white60,
      );
      return;
    }

    await _firestoreService.sendFriendRequest(currentUser.uid, email);

    Get.snackbar(
      "Success",
      "Friend request sent to $email",
      backgroundColor: Colors.white60,
    );
    emailController.clear();
  }
}
