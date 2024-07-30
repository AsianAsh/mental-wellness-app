// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class AddFriendScreen extends StatefulWidget {
//   const AddFriendScreen({super.key});

//   @override
//   _AddFriendScreenState createState() => _AddFriendScreenState();
// }

// class _AddFriendScreenState extends State<AddFriendScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void _sendFriendRequest() async {
//     String email = _emailController.text.trim();
//     if (email.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please enter an email",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Get current user
//     User? currentUser = _auth.currentUser;
//     if (currentUser == null) {
//       Get.snackbar(
//         "Error",
//         "User not logged in",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Check if the email entered is the same as the current user's email
//     if (email == currentUser.email) {
//       Get.snackbar(
//         "Error",
//         "You cannot send a friend request to yourself",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Get receiver user document
//     QuerySnapshot userQuery = await _firestore
//         .collection('Members')
//         .where('email', isEqualTo: email)
//         .get();

//     if (userQuery.docs.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Member with email $email not found",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     DocumentSnapshot receiverDoc = userQuery.docs.first;
//     String receiverId = receiverDoc.id;

//     // Check if the entered email is already a friend
//     QuerySnapshot friendSnapshot = await _firestore
//         .collection('Members')
//         .doc(currentUser.uid)
//         .collection('friends')
//         .where('friendId', isEqualTo: receiverId)
//         .get();

//     if (friendSnapshot.docs.isNotEmpty) {
//       Get.snackbar(
//         "Error",
//         "This member is already your friend",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Check for existing pending friend request
//     QuerySnapshot requestQuery = await _firestore
//         .collection('friend_requests')
//         .where('senderId', isEqualTo: currentUser.uid)
//         .where('receiverId', isEqualTo: receiverId)
//         .where('status', isEqualTo: 'pending')
//         .get();

//     if (requestQuery.docs.isNotEmpty) {
//       Get.snackbar(
//         "Info",
//         "Friend request already sent and pending",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Check for existing pending friend request sent by the current user
//     QuerySnapshot requestQuerySent = await _firestore
//         .collection('friend_requests')
//         .where('senderId', isEqualTo: currentUser.uid)
//         .where('receiverId', isEqualTo: receiverId)
//         .where('status', isEqualTo: 'pending')
//         .get();

//     if (requestQuerySent.docs.isNotEmpty) {
//       Get.snackbar(
//         "Info",
//         "Friend request already sent and pending",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Check for existing pending friend request received by the current user
//     QuerySnapshot requestQueryReceived = await _firestore
//         .collection('friend_requests')
//         .where('senderId', isEqualTo: receiverId)
//         .where('receiverId', isEqualTo: currentUser.uid)
//         .where('status', isEqualTo: 'pending')
//         .get();

//     if (requestQueryReceived.docs.isNotEmpty) {
//       Get.snackbar(
//         "Info",
//         "You have already received a friend request from this member",
//         backgroundColor: Colors.white60,
//       );
//       return;
//     }

//     // Send friend request
//     await _firestore.collection('friend_requests').add({
//       'senderId': currentUser.uid,
//       'receiverId': receiverId,
//       'status': 'pending',
//       'sentAt': Timestamp.now(),
//     });

//     Get.snackbar(
//       "Success",
//       "Friend request sent to $email",
//       backgroundColor: Colors.white60,
//     );
//     _emailController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Friend"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.stretch, // Stretch children to full width
//             children: [
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: "Friend's Email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _sendFriendRequest,
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.indigo[700], // White text
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   textStyle: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text("Send Request"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mental_wellness_app/controllers/add_friend_controller.dart';
import 'package:provider/provider.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  late AddFriendController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AddFriendController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFriendController>(
      create: (_) => _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Friend"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _controller.emailController,
                  decoration: const InputDecoration(
                    labelText: "Friend's Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _controller.sendFriendRequest,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.indigo[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Send Request"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
