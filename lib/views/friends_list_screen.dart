// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/models/nudge.dart';
// import 'package:mental_wellness_app/views/add_friend_screen.dart';

// class FriendsListScreen extends StatefulWidget {
//   const FriendsListScreen({Key? key}) : super(key: key);

//   @override
//   _FriendsListScreenState createState() => _FriendsListScreenState();
// }

// class _FriendsListScreenState extends State<FriendsListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Friends List',
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineSmall
//                 ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.indigo, // Distinct app bar color
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.person_add),
//               onPressed: () {
//                 _showAddFriendModal(context); // Open the Add Friend modal
//               },
//             ),
//           ],
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.grey[400],
//             tabs: const [
//               Tab(text: 'Friends'),
//               Tab(text: 'Requests'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             FriendsTab(),
//             RequestsTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddFriendModal(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddFriendScreen()),
//     );
//   }
// }

// class FriendsTab extends StatefulWidget {
//   const FriendsTab({Key? key}) : super(key: key);

//   @override
//   _FriendsTabState createState() => _FriendsTabState();
// }

// class _FriendsTabState extends State<FriendsTab> {
//   List<Map<String, dynamic>> _friends = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchFriends();
//   }

//   Future<void> _fetchFriends() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
//         .collection('Members')
//         .doc(currentUser.uid)
//         .collection('friends')
//         .get();

//     List<Map<String, dynamic>> friends = [];
//     for (var doc in friendsSnapshot.docs) {
//       var data = doc.data() as Map<String, dynamic>;
//       DocumentSnapshot friendDoc = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(data['friendId'])
//           .get();
//       var friendData = friendDoc.data() as Map<String, dynamic>;
//       friends.add({
//         'friendId': data['friendId'],
//         'friendName':
//             "${friendData['firstName'] ?? 'No data'} ${friendData['lastName'] ?? 'No data'}",
//         'friendEmail': friendData['email'] ?? 'No data',
//         'profileImage': friendData['profilePic'] ?? '',
//         'bio': friendData['bio'] ?? 'No bio',
//         'level': friendData['level'] ?? 1,
//         'dailyStreak': friendData['dailyStreak'] ?? 0,
//         'country': friendData['country'] ?? 'No country',
//         'createdAt': friendData['createdAt'] ?? Timestamp.now(),
//         'lastActive': friendData['lastActive'] ?? Timestamp.now(),
//         'friendData': friendData,
//       });
//     }
//     setState(() {
//       _friends = friends;
//     });
//   }

//   void _removeFriend(String friendId) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     try {
//       WriteBatch batch = FirebaseFirestore.instance.batch();

//       // Remove friend from current user's friends subcollection
//       DocumentReference currentUserFriendRef = FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('friends')
//           .doc(friendId);
//       batch.delete(currentUserFriendRef);

//       // Remove friend from friend's friends subcollection
//       DocumentReference friendRef = FirebaseFirestore.instance
//           .collection('Members')
//           .doc(friendId)
//           .collection('friends')
//           .doc(currentUser.uid);
//       batch.delete(friendRef);

//       // Decrement the current user's friendsAdded field by 1
//       DocumentReference currentUserRef =
//           FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
//       batch.update(currentUserRef, {
//         'friendsAdded': FieldValue.increment(-1),
//       });

//       // Decrement the friend's friendsAdded field by 1
//       DocumentReference friendUserRef =
//           FirebaseFirestore.instance.collection('Members').doc(friendId);
//       batch.update(friendUserRef, {
//         'friendsAdded': FieldValue.increment(-1),
//       });

//       // Commit the batch
//       await batch.commit();

//       setState(() {
//         _friends.removeWhere((friend) => friend['friendId'] == friendId);
//       });

//       Get.snackbar(
//         "Success",
//         "Friend removed successfully",
//         backgroundColor: Colors.white60,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to remove friend",
//         backgroundColor: Colors.white60,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_friends.isEmpty) {
//       return Center(child: Text("No friends found"));
//     }

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
//       child: ListView(
//         children: _friends.map((friend) {
//           return FriendCard(
//             name: friend['friendName'],
//             profileImage: friend['profileImage'],
//             routineStatus: '', // Assuming this can be an empty string
//             friendId: friend['friendId'],
//             onViewProfile: () {
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 builder: (context) => FriendProfileOverlay(
//                   profile: FriendProfile(
//                     name: friend['friendName'],
//                     email: friend['friendEmail'],
//                     bio: friend['bio'],
//                     level: friend['level'],
//                     dailyStreak: friend['dailyStreak'],
//                     country: friend['country'],
//                     createdAt: friend['createdAt'],
//                     lastActive: friend['lastActive'],
//                     profilePic: friend['profileImage'],
//                   ),
//                 ),
//               );
//             },
//             onInteract: () {
//               // Interact functionality
//             },
//             onRemove: _removeFriend,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class RequestsTab extends StatelessWidget {
//   const RequestsTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
//       child: FriendRequestsList(),
//     );
//   }
// }

// class FriendRequestsList extends StatefulWidget {
//   const FriendRequestsList({Key? key}) : super(key: key);

//   @override
//   _FriendRequestsListState createState() => _FriendRequestsListState();
// }

// class _FriendRequestsListState extends State<FriendRequestsList> {
//   List<Map<String, dynamic>> _friendRequests = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchFriendRequests();
//   }

//   Future<void> _fetchFriendRequests() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     QuerySnapshot requestSnapshot = await FirebaseFirestore.instance
//         .collection('friend_requests')
//         .where('receiverId', isEqualTo: currentUser.uid)
//         .where('status', isEqualTo: 'pending')
//         .get();

//     List<Map<String, dynamic>> requests = [];
//     for (var doc in requestSnapshot.docs) {
//       var data = doc.data() as Map<String, dynamic>;
//       DocumentSnapshot senderDoc = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(data['senderId'])
//           .get();
//       var senderData = senderDoc.data() as Map<String, dynamic>;
//       requests.add({
//         'requestId': doc.id,
//         'senderId': data['senderId'],
//         'senderName': "${senderData['firstName']} ${senderData['lastName']}",
//         'senderEmail': senderData['email'],
//         'sentAt': data['sentAt'] as Timestamp,
//         'profileImage':
//             senderData['profilePic'] ?? 'assets/images/default_profile.png',
//         'senderData': senderData,
//       });
//     }
//     setState(() {
//       _friendRequests = requests;
//     });
//   }

//   void _handleAcceptRequest(
//       BuildContext context, Map<String, dynamic> request) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     String requestId = request['requestId'];
//     String senderId = request['senderId'];
//     DocumentSnapshot senderDoc = await FirebaseFirestore.instance
//         .collection('Members')
//         .doc(senderId)
//         .get();
//     var senderData = senderDoc.data() as Map<String, dynamic>;

//     try {
//       // Start a Firestore batch write
//       WriteBatch batch = FirebaseFirestore.instance.batch();

//       // 1. Create a friend document in the current user's friends subcollection.
//       DocumentReference currentUserFriendRef = FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('friends')
//           .doc(senderId);
//       batch.set(currentUserFriendRef, {
//         'friendId': senderId,
//         'dateAdded': Timestamp.now(),
//       });

//       // 2. Create a friend document in the sender's friends subcollection.
//       DocumentReference senderFriendRef = FirebaseFirestore.instance
//           .collection('Members')
//           .doc(senderId)
//           .collection('friends')
//           .doc(currentUser.uid);
//       batch.set(senderFriendRef, {
//         'friendId': currentUser.uid,
//         'dateAdded': Timestamp.now(),
//       });

//       // 3. Update the friend request document's status field to 'accepted'.
//       DocumentReference requestRef = FirebaseFirestore.instance
//           .collection('friend_requests')
//           .doc(requestId);
//       batch.update(requestRef, {'status': 'accepted'});

//       // 4. Increment the current user's friendsAdded field by 1.
//       DocumentReference currentUserRef =
//           FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
//       batch.update(currentUserRef, {
//         'friendsAdded': FieldValue.increment(1),
//       });

//       // 5. Increment the sender's friendsAdded field by 1.
//       DocumentReference senderRef =
//           FirebaseFirestore.instance.collection('Members').doc(senderId);
//       batch.update(senderRef, {
//         'friendsAdded': FieldValue.increment(1),
//       });

//       // Commit the batch
//       await batch.commit();

//       // 6. Remove the accepted FriendRequestCard and add a FriendCard widget.
//       setState(() {
//         _friendRequests
//             .removeWhere((element) => element['requestId'] == requestId);
//       });

//       Get.snackbar(
//         "Success",
//         "Friend request accepted",
//         backgroundColor: Colors.white60,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to accept friend request",
//         backgroundColor: Colors.white60,
//       );
//     }
//   }

//   void _handleIgnoreRequest(String requestId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('friend_requests')
//           .doc(requestId)
//           .update({'status': 'ignored'});
//       setState(() {
//         _friendRequests
//             .removeWhere((element) => element['requestId'] == requestId);
//       });
//       Get.snackbar(
//         "Success",
//         "Friend request ignored",
//         backgroundColor: Colors.white60,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to ignore friend request",
//         backgroundColor: Colors.white60,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_friendRequests.isEmpty) {
//       return Center(child: Text("No friend requests"));
//     }

//     return ListView(
//       children: _friendRequests.map((request) {
//         return FriendRequestCard(
//           request: request,
//           onAccept: () => _handleAcceptRequest(context, request),
//           onIgnore: () => _handleIgnoreRequest(request['requestId']),
//         );
//       }).toList(),
//     );
//   }
// }

// class FriendRequestCard extends StatelessWidget {
//   final Map<String, dynamic> request;
//   final VoidCallback onAccept;
//   final VoidCallback onIgnore;

//   const FriendRequestCard({
//     Key? key,
//     required this.request,
//     required this.onAccept,
//     required this.onIgnore,
//   }) : super(key: key);

//   String _formatTimeAgo(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes} min ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
//     } else if (difference.inDays < 365) {
//       return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
//     } else {
//       final years = (difference.inDays / 365).floor();
//       return '$years year${years == 1 ? '' : 's'} ago';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundImage: request['profileImage'].startsWith('http')
//                       ? NetworkImage(request['profileImage'])
//                       : AssetImage(request['profileImage']) as ImageProvider,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             request['senderName'],
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             _formatTimeAgo(request['sentAt'].toDate()),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         request['senderEmail'],
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: onAccept,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               foregroundColor: Colors.white, // Background color
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               minimumSize: Size(
//                                   110, 30), // Minimum size to control height
//                             ),
//                             child: const Text('Accept'),
//                           ),
//                           const SizedBox(width: 10),
//                           OutlinedButton(
//                             onPressed: onIgnore,
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.red,
//                               side: const BorderSide(
//                                   color: Colors.red), // Border color
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               minimumSize: Size(
//                                   110, 30), // Minimum size to control height
//                             ),
//                             child: const Text('Decline'),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FriendCard extends StatelessWidget {
//   final String name;
//   final String profileImage;
//   final String routineStatus;
//   final String friendId;
//   final VoidCallback onViewProfile;
//   final VoidCallback onInteract;
//   final Function(String friendId) onRemove;

//   const FriendCard({
//     Key? key,
//     required this.name,
//     required this.profileImage,
//     required this.routineStatus,
//     required this.friendId,
//     required this.onViewProfile,
//     required this.onInteract,
//     required this.onRemove,
//   }) : super(key: key);

//   void _showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Friend'),
//         content: Text('Are you sure you want to remove this friend?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               onRemove(friendId);
//               Navigator.of(context).pop();
//             },
//             child: Text('Remove'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: onViewProfile, // Handle tap event here
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: profileImage.isNotEmpty
//                           ? (profileImage.startsWith('http')
//                                   ? NetworkImage(profileImage)
//                                   : AssetImage(profileImage))
//                               as ImageProvider<Object>
//                           : const AssetImage(
//                               'assets/images/default_profile.png'),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             routineStatus,
//                             style: const TextStyle(
//                               color: Colors.red,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.chat),
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (context) =>
//                           NudgeModal(friendId: friendId, friendFullName: name),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () => _showDeleteConfirmationDialog(context),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FriendProfile {
//   final String name;
//   final String email;
//   final String bio;
//   final int level;
//   final int dailyStreak;
//   final String country;
//   final Timestamp createdAt;
//   final Timestamp lastActive;
//   final String profilePic;

//   FriendProfile({
//     required this.name,
//     required this.email,
//     required this.bio,
//     required this.level,
//     required this.dailyStreak,
//     required this.country,
//     required this.createdAt,
//     required this.lastActive,
//     required this.profilePic,
//   });
// }

// class FriendProfileOverlay extends StatelessWidget {
//   final FriendProfile profile;

//   const FriendProfileOverlay({Key? key, required this.profile})
//       : super(key: key);

//   String _formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat('d MMMM y').format(dateTime);
//   }

//   String _formatTimeAgo(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes} min ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
//     } else if (difference.inDays < 365) {
//       return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
//     } else {
//       final years = (difference.inDays / 365).floor();
//       return '$years year${years == 1 ? '' : 's'} ago';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 100, // radius * 2
//                       height: 100, // radius * 2
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.black,
//                           width: 1.0,
//                         ),
//                       ),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: profile.profilePic.isNotEmpty
//                             ? NetworkImage(profile.profilePic)
//                             : AssetImage('assets/images/default_profile.png')
//                                 as ImageProvider,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Center(
//                     child: Text(
//                       profile.name,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.indigo,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Center(
//                     child: Text(
//                       profile.email,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildInfoCard('Bio', profile.bio, Icons.info_outline,
//                       Colors.blueAccent),
//                   _buildInfoCard('Country', profile.country, Icons.location_on,
//                       Colors.green),
//                   _buildInfoCard('Daily Streak', profile.dailyStreak.toString(),
//                       Icons.whatshot, Colors.red),
//                   _buildInfoCard('Level', profile.level.toString(), Icons.star,
//                       Colors.amber),
//                   _buildInfoCard(
//                       'Last online',
//                       _formatTimeAgo(profile.lastActive.toDate()),
//                       Icons.access_time,
//                       Colors.purple),
//                   _buildInfoCard(
//                       'Joined on',
//                       _formatTimestamp(profile.createdAt),
//                       Icons.calendar_today,
//                       Colors.teal),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 0,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: Colors.black),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(
//       String label, String value, IconData icon, Color iconColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: [
//               Icon(icon, color: iconColor),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       label,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.indigo,
//                       ),
//                     ),
//                     // const SizedBox(height: 5),
//                     Text(
//                       value.isNotEmpty ? value : 'No data',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mental_wellness_app/controllers/friends_list_controller.dart';
import 'package:mental_wellness_app/models/friend_profile.dart';
import 'package:mental_wellness_app/widgets/friend_card.dart';
import 'package:mental_wellness_app/widgets/friend_profile_overlay.dart';
import 'package:mental_wellness_app/widgets/friend_request_card.dart';
import 'package:provider/provider.dart';

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({Key? key}) : super(key: key);

  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  late FriendsListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FriendsListController();
    _controller.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FriendsListController>(
      create: (_) => _controller,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Friends List',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.indigo,
            actions: [
              IconButton(
                icon: const Icon(Icons.person_add),
                onPressed: () {
                  _controller.showAddFriendModal(context);
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              tabs: const [
                Tab(text: 'Friends'),
                Tab(text: 'Requests'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FriendsTab(),
              RequestsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class FriendsTab extends StatelessWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FriendsListController>(
      builder: (context, controller, child) {
        if (controller.friends.isEmpty) {
          return Center(child: Text("No friends found"));
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
          child: ListView(
            children: controller.friends.map((friend) {
              return FriendCard(
                name: friend['friendName'],
                profileImage: friend['profileImage'],
                routineStatus: '',
                friendId: friend['friendId'],
                onViewProfile: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => FriendProfileOverlay(
                      profile: FriendProfile(
                        name: friend['friendName'],
                        email: friend['friendEmail'],
                        bio: friend['bio'],
                        level: friend['level'],
                        dailyStreak: friend['dailyStreak'],
                        country: friend['country'],
                        createdAt: friend['createdAt'],
                        lastActive: friend['lastActive'],
                        profilePic: friend['profileImage'],
                      ),
                    ),
                  );
                },
                onInteract: () {
                  // Interact functionality
                },
                onRemove: (friendId) => controller.removeFriend(friendId),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class RequestsTab extends StatelessWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      child: FriendRequestsList(),
    );
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FriendsListController>(
      builder: (context, controller, child) {
        if (controller.friendRequests.isEmpty) {
          return Center(child: Text("No friend requests"));
        }

        return ListView(
          children: controller.friendRequests.map((request) {
            return FriendRequestCard(
              request: request,
              onAccept: () => controller.handleAcceptRequest(context, request),
              onIgnore: () =>
                  controller.handleIgnoreRequest(request['requestId']),
            );
          }).toList(),
        );
      },
    );
  }
}
