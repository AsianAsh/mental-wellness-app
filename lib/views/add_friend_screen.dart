import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendFriendRequest() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter an email");
      return;
    }

    // Get current user
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    // Check if the email entered is the same as the current user's email
    if (email == currentUser.email) {
      Get.snackbar("Error", "You cannot send a friend request to yourself");
      return;
    }

    // Get receiver user document
    QuerySnapshot userQuery = await _firestore
        .collection('Members')
        .where('email', isEqualTo: email)
        .get();

    if (userQuery.docs.isEmpty) {
      Get.snackbar("Error", "Member with email $email not found");
      return;
    }

    DocumentSnapshot receiverDoc = userQuery.docs.first;
    String receiverId = receiverDoc.id;

    // Check if the entered email is already a friend
    QuerySnapshot friendSnapshot = await _firestore
        .collection('Members')
        .doc(currentUser.uid)
        .collection('friends')
        .where('friendId', isEqualTo: receiverId)
        .get();

    if (friendSnapshot.docs.isNotEmpty) {
      Get.snackbar("Error", "This member is already your friend");
      return;
    }

    // Check for existing pending friend request
    QuerySnapshot requestQuery = await _firestore
        .collection('friend_requests')
        .where('senderId', isEqualTo: currentUser.uid)
        .where('receiverId', isEqualTo: receiverId)
        .where('status', isEqualTo: 'pending')
        .get();

    if (requestQuery.docs.isNotEmpty) {
      Get.snackbar("Info", "Friend request already sent and pending");
      return;
    }

    // Check for existing pending friend request sent by the current user
    QuerySnapshot requestQuerySent = await _firestore
        .collection('friend_requests')
        .where('senderId', isEqualTo: currentUser.uid)
        .where('receiverId', isEqualTo: receiverId)
        .where('status', isEqualTo: 'pending')
        .get();

    if (requestQuerySent.docs.isNotEmpty) {
      Get.snackbar("Info", "Friend request already sent and pending");
      return;
    }

    // Check for existing pending friend request received by the current user
    QuerySnapshot requestQueryReceived = await _firestore
        .collection('friend_requests')
        .where('senderId', isEqualTo: receiverId)
        .where('receiverId', isEqualTo: currentUser.uid)
        .where('status', isEqualTo: 'pending')
        .get();

    if (requestQueryReceived.docs.isNotEmpty) {
      Get.snackbar("Info",
          "You have already received a friend request from this member");
      return;
    }

    // Send friend request
    await _firestore.collection('friend_requests').add({
      'senderId': currentUser.uid,
      'receiverId': receiverId,
      'status': 'pending',
      'sentAt': Timestamp.now(),
    });

    Get.snackbar("Success", "Friend request sent to $email");
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Friend"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Friend's Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendFriendRequest,
              child: Text("Send Request"),
            ),
          ],
        ),
      ),
    );
  }
}
