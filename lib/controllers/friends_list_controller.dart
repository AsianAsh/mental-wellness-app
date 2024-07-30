import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/views/add_friend_screen.dart';

class FriendsListController extends ChangeNotifier {
  List<Map<String, dynamic>> friends = [];
  List<Map<String, dynamic>> friendRequests = [];

  void initState() {
    _fetchFriends();
    _fetchFriendRequests();
  }

  Future<void> _fetchFriends() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
        .collection('Members')
        .doc(currentUser.uid)
        .collection('friends')
        .get();

    List<Map<String, dynamic>> fetchedFriends = [];
    for (var doc in friendsSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DocumentSnapshot friendDoc = await FirebaseFirestore.instance
          .collection('Members')
          .doc(data['friendId'])
          .get();
      var friendData = friendDoc.data() as Map<String, dynamic>;
      fetchedFriends.add({
        'friendId': data['friendId'],
        'friendName':
            "${friendData['firstName'] ?? 'No data'} ${friendData['lastName'] ?? 'No data'}",
        'friendEmail': friendData['email'] ?? 'No data',
        'profileImage': friendData['profilePic'] ?? '',
        'bio': friendData['bio'] ?? 'No bio',
        'level': friendData['level'] ?? 1,
        'dailyStreak': friendData['dailyStreak'] ?? 0,
        'country': friendData['country'] ?? 'No country',
        'createdAt': friendData['createdAt'] ?? Timestamp.now(),
        'lastActive': friendData['lastActive'] ?? Timestamp.now(),
        'friendData': friendData,
      });
    }
    friends = fetchedFriends;
    notifyListeners();
  }

  void removeFriend(String friendId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      DocumentReference currentUserFriendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('friends')
          .doc(friendId);
      batch.delete(currentUserFriendRef);

      DocumentReference friendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(friendId)
          .collection('friends')
          .doc(currentUser.uid);
      batch.delete(friendRef);

      DocumentReference currentUserRef =
          FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
      batch.update(currentUserRef, {
        'friendsAdded': FieldValue.increment(-1),
      });

      DocumentReference friendUserRef =
          FirebaseFirestore.instance.collection('Members').doc(friendId);
      batch.update(friendUserRef, {
        'friendsAdded': FieldValue.increment(-1),
      });

      await batch.commit();

      friends.removeWhere((friend) => friend['friendId'] == friendId);
      notifyListeners();

      Get.snackbar(
        "Success",
        "Friend removed successfully",
        backgroundColor: Colors.white60,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to remove friend",
        backgroundColor: Colors.white60,
      );
    }
  }

  Future<void> _fetchFriendRequests() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    QuerySnapshot requestSnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('receiverId', isEqualTo: currentUser.uid)
        .where('status', isEqualTo: 'pending')
        .get();

    List<Map<String, dynamic>> fetchedRequests = [];
    for (var doc in requestSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DocumentSnapshot senderDoc = await FirebaseFirestore.instance
          .collection('Members')
          .doc(data['senderId'])
          .get();
      var senderData = senderDoc.data() as Map<String, dynamic>;
      fetchedRequests.add({
        'requestId': doc.id,
        'senderId': data['senderId'],
        'senderName': "${senderData['firstName']} ${senderData['lastName']}",
        'senderEmail': senderData['email'],
        'sentAt': data['sentAt'] as Timestamp,
        'profileImage': senderData['profilePic'] ?? '',
        'senderData': senderData,
      });
    }
    friendRequests = fetchedRequests;
    notifyListeners();
  }

  void handleAcceptRequest(
      BuildContext context, Map<String, dynamic> request) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    String requestId = request['requestId'];
    String senderId = request['senderId'];

    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      DocumentReference currentUserFriendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('friends')
          .doc(senderId);
      batch.set(currentUserFriendRef, {
        'friendId': senderId,
        'dateAdded': Timestamp.now(),
      });

      DocumentReference senderFriendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(senderId)
          .collection('friends')
          .doc(currentUser.uid);
      batch.set(senderFriendRef, {
        'friendId': currentUser.uid,
        'dateAdded': Timestamp.now(),
      });

      DocumentReference requestRef = FirebaseFirestore.instance
          .collection('friend_requests')
          .doc(requestId);
      batch.update(requestRef, {'status': 'accepted'});

      DocumentReference currentUserRef =
          FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
      batch.update(currentUserRef, {
        'friendsAdded': FieldValue.increment(1),
      });

      DocumentReference senderRef =
          FirebaseFirestore.instance.collection('Members').doc(senderId);
      batch.update(senderRef, {
        'friendsAdded': FieldValue.increment(1),
      });

      await batch.commit();

      friendRequests
          .removeWhere((element) => element['requestId'] == requestId);
      notifyListeners();

      Get.snackbar(
        "Success",
        "Friend request accepted",
        backgroundColor: Colors.white60,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to accept friend request",
        backgroundColor: Colors.white60,
      );
    }
  }

  void handleIgnoreRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('friend_requests')
          .doc(requestId)
          .update({'status': 'ignored'});
      friendRequests
          .removeWhere((element) => element['requestId'] == requestId);
      notifyListeners();

      Get.snackbar(
        "Success",
        "Friend request ignored",
        backgroundColor: Colors.white60,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to ignore friend request",
        backgroundColor: Colors.white60,
      );
    }
  }

  void showAddFriendModal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFriendScreen()),
    );
  }
}
