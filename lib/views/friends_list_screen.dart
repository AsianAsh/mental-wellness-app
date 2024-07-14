// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/views/achievements_screen.dart';
// import 'package:mental_wellness_app/views/add_friend_screen.dart';
// import 'package:mental_wellness_app/views/friends_list_screen.dart';
// import 'package:mental_wellness_app/views/login_screen.dart';
// import 'package:mental_wellness_app/views/rewards_screen.dart';
// import 'package:mental_wellness_app/views/update_profile_screen.dart';

// class FriendsListScreen extends StatelessWidget {
//   const FriendsListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Friends List',
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall
//                   ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
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

//   // void _showAddFriendModal(BuildContext context) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     backgroundColor: Colors.transparent,
//   //     builder: (BuildContext context) {
//   //       return DraggableScrollableSheet(
//   //         expand: false,
//   //         builder: (BuildContext context, ScrollController scrollController) {
//   //           return Container(
//   //             decoration: BoxDecoration(
//   //               color: Colors.white,
//   //               borderRadius: BorderRadius.vertical(
//   //                 top: Radius.circular(20),
//   //               ),
//   //             ),
//   //             padding: const EdgeInsets.all(16.0),
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 Text(
//   //                   'Add Friend',
//   //                   style: TextStyle(
//   //                     fontSize: 18,
//   //                     fontWeight: FontWeight.bold,
//   //                   ),
//   //                 ),
//   //                 const SizedBox(height: 10),
//   //                 TextField(
//   //                   decoration: InputDecoration(
//   //                     labelText: 'Friend\'s Email',
//   //                     border: OutlineInputBorder(),
//   //                   ),
//   //                 ),
//   //                 const SizedBox(height: 10),
//   //                 ElevatedButton(
//   //                   onPressed: () {
//   //                     // Handle send friend request
//   //                     Navigator.pop(context);
//   //                   },
//   //                   child: Text('Send Request'),
//   //                 ),
//   //               ],
//   //             ),
//   //           );
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   void _showAddFriendModal(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddFriendScreen()),
//     );
//   }
// }

// class FriendsTab extends StatelessWidget {
//   const FriendsTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final friendProfile = FriendProfile(
//       name: 'Emily Elliott',
//       email: 'emily@example.com',
//       bio: 'Bio of Emily Elliott',
//       description: 'Description of Emily Elliott',
//       level: 13,
//       dailyStreak: 20,
//       countryFlag: '🇺🇸',
//       countryName: 'United States',
//       achievements: [Icons.star, Icons.spa, Icons.emoji_events],
//     );

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
//       child: ListView(
//         children: [
//           FriendCard(
//             name: 'Emily Elliott',
//             profileImage: 'assets/images/gong_yoo.jpg',
//             routineStatus: 'Could use a nudge',
//             onViewProfile: () {
//               // View profile functionality
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 builder: (context) =>
//                     FriendProfileOverlay(profile: friendProfile),
//               );
//             },
//             onInteract: () {
//               // Interact functionality
//               showMindfulMessageModal(context, 'Emily Elliott');
//             },
//             onRemove: () {
//               // Remove friend functionality
//             },
//           ),
//           FriendCard(
//             name: 'Piers Merchant',
//             profileImage: 'assets/images/gong_yoo.jpg',
//             routineStatus: '',
//             onViewProfile: () {
//               // View profile functionality
//             },
//             onInteract: () {
//               // Interact functionality
//               showMindfulMessageModal(context, 'Piers Merchant');
//             },
//             onRemove: () {
//               // Remove friend functionality
//             },
//           ),
//           FriendCard(
//             name: 'Olivia Burns',
//             profileImage: 'assets/images/gong_yoo.jpg',
//             routineStatus: 'Could use a nudge',
//             onViewProfile: () {
//               // View profile functionality
//             },
//             onInteract: () {
//               // Interact functionality
//               showMindfulMessageModal(context, 'Olivia Burns');
//             },
//             onRemove: () {
//               // Remove friend functionality
//             },
//           ),
//           // Add more FriendCard widgets here
//         ],
//       ),
//     );
//   }

//   // Modal to select and send mindful message to friend
//   void showMindfulMessageModal(BuildContext context, String friendName) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return DraggableScrollableSheet(
//           initialChildSize:
//               0.8, // Set the initial size to 80% of the screen height
//           minChildSize: 0.5, // Minimum size is 50% of the screen height
//           maxChildSize: 0.88, // Maximum size is 90% of the screen height
//           expand: false,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // X cancel button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.close),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 6),
//                   Center(
//                     child: Text(
//                       'Send $friendName a mindful message',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: ListView(
//                       controller: scrollController,
//                       children: [
//                         MindfulMessageCard(
//                           icon: Icons.sentiment_satisfied,
//                           message: 'Keep up that run streak, buddy.',
//                           backgroundColor: Colors.blue[200]!,
//                         ),
//                         MindfulMessageCard(
//                           icon: Icons.favorite,
//                           message: 'Sending some love your way.',
//                           backgroundColor: Colors.pink[200]!,
//                         ),
//                         MindfulMessageCard(
//                           icon: Icons.waving_hand,
//                           message: 'Just saying hi.',
//                           backgroundColor: Colors.green[200]!,
//                         ),
//                         MindfulMessageCard(
//                           icon: Icons.cloud,
//                           message: 'Be kind to your mind.',
//                           backgroundColor: Colors.blue[100]!,
//                         ),
//                         MindfulMessageCard(
//                           icon: Icons.bubble_chart,
//                           message: 'You deserve some Headspace today.',
//                           backgroundColor: Colors.orange[200]!,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class MindfulMessageCard extends StatelessWidget {
//   final IconData icon;
//   final String message;
//   final Color backgroundColor;

//   const MindfulMessageCard({
//     Key? key,
//     required this.icon,
//     required this.message,
//     required this.backgroundColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: backgroundColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: ListTile(
//           leading:
//               Icon(icon, size: 50, color: Colors.white), // Increased icon size
//           title: Text(
//             message,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
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

// class FriendRequestsList extends StatelessWidget {
//   const FriendRequestsList({Key? key}) : super(key: key);

//   Future<List<Map<String, dynamic>>> _fetchFriendRequests() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return [];

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
//         'senderName': "${senderData['firstName']} ${senderData['lastName']}",
//         'senderEmail': senderData['email'],
//         'sentAt': data['sentAt'] as Timestamp,
//         'profileImage': 'assets/images/gong_yoo.jpg',
//       });
//     }
//     return requests;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _fetchFriendRequests(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text("Error fetching friend requests"));
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text("No friend requests"));
//         }

//         return ListView(
//           children: snapshot.data!.map((request) {
//             return FriendRequestCard(
//               name: request['senderName'],
//               profileImage: request['profileImage'],
//               email: request['senderEmail'],
//               sentAt: request['sentAt'].toDate(),
//               onAccept: () {
//                 // Handle accept request
//               },
//               onIgnore: () {
//                 // Handle ignore request
//               },
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// class FriendCard extends StatelessWidget {
//   final String name;
//   final String profileImage;
//   final String routineStatus;
//   final VoidCallback onViewProfile;
//   final VoidCallback onInteract;
//   final VoidCallback onRemove;

//   const FriendCard({
//     Key? key,
//     required this.name,
//     required this.profileImage,
//     required this.routineStatus,
//     required this.onViewProfile,
//     required this.onInteract,
//     required this.onRemove,
//   }) : super(key: key);

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
//                       backgroundImage: AssetImage(profileImage),
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
//                   onPressed: onInteract,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: onRemove,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FriendRequestCard extends StatelessWidget {
//   final String name;
//   final String profileImage;
//   final String email;
//   final DateTime sentAt;
//   final VoidCallback onAccept;
//   final VoidCallback onIgnore;

//   const FriendRequestCard({
//     Key? key,
//     required this.name,
//     required this.profileImage,
//     required this.email,
//     required this.sentAt,
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
//     } else {
//       return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
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
//                   backgroundImage: AssetImage(profileImage),
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
//                             name,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             _formatTimeAgo(sentAt),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         email,
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

// class FriendProfile {
//   final String name;
//   final String email;
//   final String bio;
//   final String description;
//   final int level;
//   final int dailyStreak;
//   final String countryFlag;
//   final String countryName;
//   final List<IconData> achievements;

//   FriendProfile({
//     required this.name,
//     required this.email,
//     required this.bio,
//     required this.description,
//     required this.level,
//     required this.dailyStreak,
//     required this.countryFlag,
//     required this.countryName,
//     required this.achievements,
//   });
// }

// class FriendProfileOverlay extends StatelessWidget {
//   final FriendProfile profile;

//   const FriendProfileOverlay({Key? key, required this.profile})
//       : super(key: key);

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
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage('assets/images/gong_yoo.jpg'),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Center(
//                 child: Text(
//                   profile.name,
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Center(
//                 child: Text(
//                   profile.email,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Bio',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(profile.bio),
//               const SizedBox(height: 20),
//               Text(
//                 'Description',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(profile.description),
//               const SizedBox(height: 20),
//               Text(
//                 'Level: ${profile.level}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'Daily Streak: ${profile.dailyStreak}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text(
//                     profile.countryFlag,
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     profile.countryName,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Achievements',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: profile.achievements
//                     .map((icon) => Icon(icon, size: 30))
//                     .toList(),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/models/nudge.dart';
import 'package:mental_wellness_app/views/add_friend_screen.dart';

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({Key? key}) : super(key: key);

  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Friends List',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.indigo, // Distinct app bar color
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                _showAddFriendModal(context); // Open the Add Friend modal
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
    );
  }

  void _showAddFriendModal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFriendScreen()),
    );
  }
}

class FriendsTab extends StatefulWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  List<Map<String, dynamic>> _friends = [];

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }

  Future<void> _fetchFriends() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
        .collection('Members')
        .doc(currentUser.uid)
        .collection('friends')
        .get();

    List<Map<String, dynamic>> friends = [];
    for (var doc in friendsSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DocumentSnapshot friendDoc = await FirebaseFirestore.instance
          .collection('Members')
          .doc(data['friendId'])
          .get();
      var friendData = friendDoc.data() as Map<String, dynamic>;
      friends.add({
        'friendId': data['friendId'],
        'friendName':
            "${friendData['firstName'] ?? 'No data'} ${friendData['lastName'] ?? 'No data'}",
        'friendEmail': friendData['email'] ?? 'No data',
        'profileImage': 'assets/images/gong_yoo.jpg',
        'bio': friendData['bio'] ?? 'No bio',
        'level': friendData['level'] ?? 1,
        'dailyStreak': friendData['dailyStreak'] ?? 0,
        'country': friendData['country'] ?? 'No country',
        'createdAt': friendData['createdAt'] ?? Timestamp.now(),
        'lastActive': friendData['lastActive'] ?? Timestamp.now(),
        'friendData': friendData,
      });
    }
    setState(() {
      _friends = friends;
    });
  }

  void _removeFriend(String friendId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Remove friend from current user's friends subcollection
      DocumentReference currentUserFriendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('friends')
          .doc(friendId);
      batch.delete(currentUserFriendRef);

      // Remove friend from friend's friends subcollection
      DocumentReference friendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(friendId)
          .collection('friends')
          .doc(currentUser.uid);
      batch.delete(friendRef);

      // Decrement the current user's friendsAdded field by 1
      DocumentReference currentUserRef =
          FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
      batch.update(currentUserRef, {
        'friendsAdded': FieldValue.increment(-1),
      });

      // Decrement the friend's friendsAdded field by 1
      DocumentReference friendUserRef =
          FirebaseFirestore.instance.collection('Members').doc(friendId);
      batch.update(friendUserRef, {
        'friendsAdded': FieldValue.increment(-1),
      });

      // Commit the batch
      await batch.commit();

      setState(() {
        _friends.removeWhere((friend) => friend['friendId'] == friendId);
      });

      Get.snackbar("Success", "Friend removed successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to remove friend");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_friends.isEmpty) {
      return Center(child: Text("No friends found"));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      child: ListView(
        children: _friends.map((friend) {
          return FriendCard(
            name: friend['friendName'],
            profileImage: friend['profileImage'],
            routineStatus: '', // Assuming this can be an empty string
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
                  ),
                ),
              );
            },
            onInteract: () {
              // Interact functionality
            },
            onRemove: _removeFriend,
          );
        }).toList(),
      ),
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

class FriendRequestsList extends StatefulWidget {
  const FriendRequestsList({Key? key}) : super(key: key);

  @override
  _FriendRequestsListState createState() => _FriendRequestsListState();
}

class _FriendRequestsListState extends State<FriendRequestsList> {
  List<Map<String, dynamic>> _friendRequests = [];

  @override
  void initState() {
    super.initState();
    _fetchFriendRequests();
  }

  Future<void> _fetchFriendRequests() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    QuerySnapshot requestSnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('receiverId', isEqualTo: currentUser.uid)
        .where('status', isEqualTo: 'pending')
        .get();

    List<Map<String, dynamic>> requests = [];
    for (var doc in requestSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DocumentSnapshot senderDoc = await FirebaseFirestore.instance
          .collection('Members')
          .doc(data['senderId'])
          .get();
      var senderData = senderDoc.data() as Map<String, dynamic>;
      requests.add({
        'requestId': doc.id,
        'senderId': data['senderId'],
        'senderName': "${senderData['firstName']} ${senderData['lastName']}",
        'senderEmail': senderData['email'],
        'sentAt': data['sentAt'] as Timestamp,
        'profileImage': 'assets/images/gong_yoo.jpg',
        'senderData': senderData,
      });
    }
    setState(() {
      _friendRequests = requests;
    });
  }

  void _handleAcceptRequest(
      BuildContext context, Map<String, dynamic> request) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    String requestId = request['requestId'];
    String senderId = request['senderId'];
    DocumentSnapshot senderDoc = await FirebaseFirestore.instance
        .collection('Members')
        .doc(senderId)
        .get();
    var senderData = senderDoc.data() as Map<String, dynamic>;

    try {
      // Start a Firestore batch write
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // 1. Create a friend document in the current user's friends subcollection.
      DocumentReference currentUserFriendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('friends')
          .doc(senderId);
      batch.set(currentUserFriendRef, {
        'friendId': senderId,
        'dateAdded': Timestamp.now(),
      });

      // 2. Create a friend document in the sender's friends subcollection.
      DocumentReference senderFriendRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(senderId)
          .collection('friends')
          .doc(currentUser.uid);
      batch.set(senderFriendRef, {
        'friendId': currentUser.uid,
        'dateAdded': Timestamp.now(),
      });

      // 3. Update the friend request document's status field to 'accepted'.
      DocumentReference requestRef = FirebaseFirestore.instance
          .collection('friend_requests')
          .doc(requestId);
      batch.update(requestRef, {'status': 'accepted'});

      // 4. Increment the current user's friendsAdded field by 1.
      DocumentReference currentUserRef =
          FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
      batch.update(currentUserRef, {
        'friendsAdded': FieldValue.increment(1),
      });

      // 5. Increment the sender's friendsAdded field by 1.
      DocumentReference senderRef =
          FirebaseFirestore.instance.collection('Members').doc(senderId);
      batch.update(senderRef, {
        'friendsAdded': FieldValue.increment(1),
      });

      // Commit the batch
      await batch.commit();

      // 6. Remove the accepted FriendRequestCard and add a FriendCard widget.
      setState(() {
        _friendRequests
            .removeWhere((element) => element['requestId'] == requestId);
      });

      Get.snackbar("Success", "Friend request accepted");
    } catch (e) {
      Get.snackbar("Error", "Failed to accept friend request");
    }
  }

  void _handleIgnoreRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('friend_requests')
          .doc(requestId)
          .update({'status': 'ignored'});
      setState(() {
        _friendRequests
            .removeWhere((element) => element['requestId'] == requestId);
      });
      Get.snackbar("Success", "Friend request ignored");
    } catch (e) {
      Get.snackbar("Error", "Failed to ignore friend request");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_friendRequests.isEmpty) {
      return Center(child: Text("No friend requests"));
    }

    return ListView(
      children: _friendRequests.map((request) {
        return FriendRequestCard(
          request: request,
          onAccept: () => _handleAcceptRequest(context, request),
          onIgnore: () => _handleIgnoreRequest(request['requestId']),
        );
      }).toList(),
    );
  }
}

class FriendRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final VoidCallback onAccept;
  final VoidCallback onIgnore;

  const FriendRequestCard({
    Key? key,
    required this.request,
    required this.onAccept,
    required this.onIgnore,
  }) : super(key: key);

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(request['profileImage']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            request['senderName'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formatTimeAgo(request['sentAt'].toDate()),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        request['senderEmail'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: onAccept,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(
                                  110, 30), // Minimum size to control height
                            ),
                            child: const Text('Accept'),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: onIgnore,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(
                                  color: Colors.red), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(
                                  110, 30), // Minimum size to control height
                            ),
                            child: const Text('Decline'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
//                       backgroundImage: AssetImage(profileImage),
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
//                             '',
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
//                   onPressed: onInteract,
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

// with nudge feature
class FriendCard extends StatelessWidget {
  final String name;
  final String profileImage;
  final String routineStatus;
  final String friendId;
  final VoidCallback onViewProfile;
  final VoidCallback onInteract;
  final Function(String friendId) onRemove;

  const FriendCard({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.routineStatus,
    required this.friendId,
    required this.onViewProfile,
    required this.onInteract,
    required this.onRemove,
  }) : super(key: key);

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Friend'),
        content: Text('Are you sure you want to remove this friend?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onRemove(friendId);
              Navigator.of(context).pop();
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onViewProfile, // Handle tap event here
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(profileImage),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          NudgeModal(friendId: friendId, friendFullName: name),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmationDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FriendProfile {
  final String name;
  final String email;
  final String bio;
  final int level;
  final int dailyStreak;
  final String country;
  final Timestamp createdAt;
  final Timestamp lastActive;

  FriendProfile({
    required this.name,
    required this.email,
    required this.bio,
    required this.level,
    required this.dailyStreak,
    required this.country,
    required this.createdAt,
    required this.lastActive,
  });
}

class FriendProfileOverlay extends StatelessWidget {
  final FriendProfile profile;

  const FriendProfileOverlay({Key? key, required this.profile})
      : super(key: key);

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('d MMMM y').format(dateTime);
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100, // radius * 2
                      height: 100, // radius * 2
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/gong_yoo.jpg'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      profile.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      profile.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildProfileSection('Bio', profile.bio, Icons.info_outline),
                  _buildProfileSection(
                      'Country', profile.country, Icons.location_on),
                  _buildStreakField('Daily Streak', profile.dailyStreak),
                  _buildProfileSection(
                      'Level', profile.level.toString(), Icons.star),
                  _buildProfileSection(
                      'Last online',
                      _formatTimeAgo(profile.lastActive.toDate()),
                      Icons.access_time),
                  _buildProfileSection(
                      'Joined on',
                      _formatTimestamp(profile.createdAt),
                      Icons.calendar_today),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.indigo),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    Text(
                      value.isNotEmpty ? value : 'No data',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakField(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.whatshot, color: Colors.red),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    QuerySnapshot friendQuery = await _firestore
        .collection('Members')
        .doc(currentUser.uid)
        .collection('friends')
        .where('friendId', isEqualTo: receiverId)
        .get();

    if (friendQuery.docs.isNotEmpty) {
      Get.snackbar("Error", "This member is already your friend");
      return;
    }

    // Check if there is a friend request from the receiver to the current user
    QuerySnapshot receivedRequestQuery = await _firestore
        .collection('friend_requests')
        .where('receiverId', isEqualTo: currentUser.uid)
        .where('senderId', isEqualTo: receiverId)
        .where('status', isEqualTo: 'pending')
        .get();

    if (receivedRequestQuery.docs.isNotEmpty) {
      Get.snackbar("Info",
          "You have already received a friend request from this member");
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
