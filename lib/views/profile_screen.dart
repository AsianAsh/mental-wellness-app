// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/auth/auth_screen.dart';
// import 'package:mental_wellness_app/services/firestore.dart'; // Import the Firestore service
// import 'package:mental_wellness_app/views/achievements_screen.dart';
// import 'package:mental_wellness_app/views/friends_list_screen.dart';
// import 'package:mental_wellness_app/views/privacy_policy_screen.dart';
// import 'package:mental_wellness_app/views/rewards_screen.dart';
// import 'package:mental_wellness_app/views/terms_screen.dart';
// import 'package:mental_wellness_app/views/update_profile_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({Key? key}) : super(key: key);

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final FirestoreService _firestoreService = FirestoreService();
//   late Future<DocumentSnapshot<Map<String, dynamic>>> _userDetailsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   void _loadUserData() {
//     setState(() {
//       _userDetailsFuture = _firestoreService.getMemberDetails();
//     });
//   }

//   void logout(BuildContext context) {
//     FirebaseAuth.instance.signOut();
//     Get.offAll(() => const AuthScreen());
//   }

//   void _showInfoDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Daily Streak Info"),
//           content: const Text(
//               "To increase your daily streak, complete all tasks in your daily routine. If you do not complete your routine before the next day, the streak will be reset to 0. The longer the streak, the higher the multiplier when earning points."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Get.back(); // Close the dialog
//               },
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Profile',
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineSmall
//                 ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
//         actions: [
//           // IconButton(
//           //     onPressed: () {},
//           //     iconSize: 25.0,
//           //     icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode)),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.indigo[50]?.withOpacity(0.1),
//             ),
//             child: IconButton(
//               onPressed: () => Get.back(),
//               iconSize: 28.0,
//               icon: const Icon(Icons.close),
//             ),
//           ),
//         ],
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//           future: _userDetailsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else if (!snapshot.hasData || snapshot.data == null) {
//               return const Center(
//                 child: Text('No data available'),
//               );
//             } else if (snapshot.hasData) {
//               // Extract user data
//               Map<String, dynamic>? user = snapshot.data!.data();
//               int currentLevel = user?['level'] ?? 1;
//               int currentPoints = user?['points'] ?? 0;
//               int pointsRequired =
//                   _firestoreService.calculateRequiredPoints(currentLevel);

//               double progressRatio = currentPoints / pointsRequired;
//               String? profilePicUrl = user?['profilePic'];

//               return Container(
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Profile Image
//                         Stack(
//                           children: [
//                             SizedBox(
//                               width: 120,
//                               height: 120,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: profilePicUrl != null &&
//                                         profilePicUrl.isNotEmpty
//                                     ? Image.network(profilePicUrl)
//                                     : const Image(
//                                         image: AssetImage(
//                                             'assets/images/default_profile.png')),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 width: 35,
//                                 height: 35,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     color: Colors.indigo[50]),
//                                 child: IconButton(
//                                   icon: const Icon(
//                                     Icons.create_outlined,
//                                     color: Colors.black,
//                                     size: 20,
//                                   ),
//                                   onPressed: () async {
//                                     final result = await Get.to(
//                                         () => const UpdateProfileScreen());
//                                     if (result == true) {
//                                       _loadUserData();
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 20),
//                         // Profile Info
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Wrap(
//                                 children: [
//                                   Text(
//                                     '${user?['firstName'] ?? ''} ${user?['lastName'] ?? ''}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headlineSmall
//                                         ?.copyWith(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                               Wrap(
//                                 children: [
//                                   Text(
//                                     user?['email'] ?? '',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               // Level Indicator
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Lvl ${user?['level'] ?? 1}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.whatshot,
//                                         color: Colors.orange,
//                                       ),
//                                       const SizedBox(width: 2),
//                                       Text(
//                                         '${user?['dailyStreak'] ?? 0}', // Daily streak count
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(
//                                       Icons.info_outline,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                     onPressed: () {
//                                       _showInfoDialog(context);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 5),
//                               // XP Progress Bar
//                               Stack(
//                                 children: [
//                                   Container(
//                                     width: 160, // Total width of the XP bar
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                       //borderRadius: BorderRadius.circular(10),
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 160 *
//                                         progressRatio, // Width based on progress
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                       //borderRadius: BorderRadius.circular(10),
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                   Positioned.fill(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         '$currentPoints / $pointsRequired XP',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const Divider(),
//                     const SizedBox(height: 10),

//                     /// -- MENU
//                     ProfileMenuWidget(
//                         title: "Friends List",
//                         icon: Icons.people,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const FriendsListScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Achievements",
//                         icon: Icons.emoji_events,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               AchievementsScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Rewards",
//                         icon: Icons.card_giftcard,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const RewardsScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Wellness Support",
//                         icon: Icons.local_hospital,
//                         textColor: Colors.white,
//                         onPress: () {}),
//                     ProfileMenuWidget(
//                         title: "Send Feedback",
//                         icon: Icons.feedback,
//                         textColor: Colors.white,
//                         onPress: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (context) {
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                   bottom:
//                                       MediaQuery.of(context).viewInsets.bottom,
//                                 ),
//                                 child: FeedbackForm(),
//                               );
//                             },
//                           );
//                         }),
//                     const Divider(),
//                     const SizedBox(height: 10),
//                     ProfileMenuWidget(
//                         title: "Personal Data",
//                         icon: Icons.person,
//                         textColor: Colors.white,
//                         onPress: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text("Delete All Personal Data"),
//                                 content: const Text(
//                                     "Are you sure you want to delete all your tracked data? This action cannot be undone."),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () {
//                                       Get.back(); // Close the dialog
//                                     },
//                                     child: const Text("Cancel"),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       // Perform data deletion
//                                       Get.snackbar(
//                                         'Deleted',
//                                         'All your tracked data has been deleted.',
//                                         snackPosition: SnackPosition.BOTTOM,
//                                       );
//                                       Get.back(); // Close the dialog
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.redAccent,
//                                     ),
//                                     child: const Text("Delete"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }),
//                     ProfileMenuWidget(
//                         title: "Terms",
//                         icon: Icons.info,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const TermsScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Privacy Policy",
//                         icon: Icons.privacy_tip,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const PrivacyPolicyScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Logout",
//                         icon: Icons.logout,
//                         textColor: Colors.red,
//                         endIcon: false,
//                         onPress: () {
//                           Get.defaultDialog(
//                             title: "LOGOUT",
//                             titleStyle: const TextStyle(fontSize: 20),
//                             content: const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 15.0),
//                               child: Text("Are you sure, you want to Logout?"),
//                             ),
//                             confirm: ElevatedButton(
//                               // Template onPress code
//                               // onPressed: () =>
//                               //     // AuthenticationRepository.instance.logout(),
//                               // Navigate to login screen
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 // Logout
//                                 logout(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.redAccent,
//                                   side: BorderSide.none),
//                               child: const Text("Yes"),
//                             ),
//                             cancel: OutlinedButton(
//                                 onPressed: () => Get.back(),
//                                 child: const Text("No")),
//                           );
//                         }),
//                   ],
//                 ),
//               );
//             } else {
//               return const Text('No Data');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ProfileMenuWidget extends StatelessWidget {
//   const ProfileMenuWidget({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.onPress,
//     this.endIcon = true,
//     this.textColor,
//   }) : super(key: key);

//   final String title;
//   final IconData icon;
//   final VoidCallback onPress;
//   final bool endIcon;
//   final Color? textColor;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onPress,
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: Colors.indigo[50]?.withOpacity(0.1),
//         ),
//         child: Icon(icon, color: Colors.indigo[50]),
//       ),
//       title: Text(title,
//           style:
//               Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
//       trailing: endIcon
//           ? Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.grey.withOpacity(0.1),
//               ),
//               child: Icon(Icons.arrow_forward_ios,
//                   size: 18.0, color: Colors.indigo[50]))
//           : null,
//     );
//   }
// }

// class FeedbackForm extends StatelessWidget {
//   final TextEditingController _feedbackController = TextEditingController();

//   FeedbackForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Center(
//             child: Text(
//               'Make app better',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _feedbackController,
//             maxLines: 5,
//             decoration: InputDecoration(
//               hintText: 'What can we do to improve the ZenMate app?',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//             ),
//           ),
//           const SizedBox(height: 22),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () async {
//                 // Handle feedback submission
//                 String feedback = _feedbackController.text;
//                 if (feedback.isNotEmpty) {
//                   // Process the feedback
//                   await FirestoreService().addFeedback(feedback);
//                   Get.snackbar(
//                       'Thank you!', 'Your feedback has been submitted.');
//                   Navigator.pop(context);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.indigo,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//               child: const Text('SEND FEEDBACK'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// with delete account feature
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/auth/auth_screen.dart';
// import 'package:mental_wellness_app/services/firestore.dart'; // Import the Firestore service
// import 'package:mental_wellness_app/views/achievements_screen.dart';
// import 'package:mental_wellness_app/views/friends_list_screen.dart';
// import 'package:mental_wellness_app/views/privacy_policy_screen.dart';
// import 'package:mental_wellness_app/views/rewards_screen.dart';
// import 'package:mental_wellness_app/views/terms_screen.dart';
// import 'package:mental_wellness_app/views/update_profile_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({super.key});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final FirestoreService _firestoreService = FirestoreService();
//   late Future<DocumentSnapshot<Map<String, dynamic>>> _userDetailsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   void _loadUserData() {
//     setState(() {
//       _userDetailsFuture = _firestoreService.getMemberDetails();
//     });
//   }

//   void logout(BuildContext context) {
//     FirebaseAuth.instance.signOut();
//     Get.offAll(() => const AuthScreen());
//   }

//   Future<void> _deleteAccount(BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       Get.snackbar("Error", "User not logged in");
//       return;
//     }

//     String memberId = currentUser.uid;

//     WriteBatch batch = FirebaseFirestore.instance.batch();

//     // Remove references from friends subcollection
//     QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
//         .collection('Members')
//         .doc(memberId)
//         .collection('friends')
//         .get();

//     for (QueryDocumentSnapshot friendDoc in friendsSnapshot.docs) {
//       String friendId = friendDoc.id;
//       // Delete the member reference from each friend's friends subcollection
//       batch.delete(FirebaseFirestore.instance
//           .collection('Members')
//           .doc(friendId)
//           .collection('friends')
//           .doc(memberId));

//       // Delete the nudge documents sent by the member in each friend's nudges subcollection
//       QuerySnapshot nudgesSnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(friendId)
//           .collection('nudges')
//           .where('senderId', isEqualTo: memberId)
//           .get();

//       for (QueryDocumentSnapshot nudgeDoc in nudgesSnapshot.docs) {
//         batch.delete(nudgeDoc.reference);
//       }
//     }

//     // Remove references from counsellors' appointments
//     QuerySnapshot counsellorsSnapshot =
//         await FirebaseFirestore.instance.collection('counsellors').get();

//     for (QueryDocumentSnapshot counsellorDoc in counsellorsSnapshot.docs) {
//       QuerySnapshot appointmentsSnapshot = await FirebaseFirestore.instance
//           .collection('counsellors')
//           .doc(counsellorDoc.id)
//           .collection('appointments')
//           .where('bookedBy', isEqualTo: memberId)
//           .get();

//       for (QueryDocumentSnapshot appointmentDoc in appointmentsSnapshot.docs) {
//         batch.delete(FirebaseFirestore.instance
//             .collection('counsellors')
//             .doc(counsellorDoc.id)
//             .collection('appointments')
//             .doc(appointmentDoc.id));
//       }
//     }

//     // Remove references from feedback collection
//     QuerySnapshot feedbackSnapshot = await FirebaseFirestore.instance
//         .collection('feedback')
//         .where('memberId', isEqualTo: memberId)
//         .get();

//     for (QueryDocumentSnapshot feedbackDoc in feedbackSnapshot.docs) {
//       batch.delete(feedbackDoc.reference);
//     }

//     // Remove references from friend_requests collection
//     QuerySnapshot friendRequestsSnapshot = await FirebaseFirestore.instance
//         .collection('friend_requests')
//         .where('receiverId', isEqualTo: memberId)
//         .get();

//     for (QueryDocumentSnapshot requestDoc in friendRequestsSnapshot.docs) {
//       batch.delete(requestDoc.reference);
//     }

//     friendRequestsSnapshot = await FirebaseFirestore.instance
//         .collection('friend_requests')
//         .where('senderId', isEqualTo: memberId)
//         .get();

//     for (QueryDocumentSnapshot requestDoc in friendRequestsSnapshot.docs) {
//       batch.delete(requestDoc.reference);
//     }

//     // Delete member document
//     batch
//         .delete(FirebaseFirestore.instance.collection('Members').doc(memberId));

//     // Commit batch
//     await batch.commit();

//     // Delete Firebase Authentication user
//     await currentUser.delete();

//     // Logout and navigate to AuthScreen
//     Navigator.pop(context);
//     logout(context);
//   }

//   void _showDeleteAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Delete Account"),
//           content: const Text(
//               "Are you sure you want to delete your account? This action cannot be undone."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Get.back(); // Close the dialog
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Get.back(); // Close the dialog
//                 await _deleteAccount(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//               ),
//               child: const Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showInfoDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Daily Streak Info"),
//           content: const Text(
//               "To increase your daily streak, complete all tasks in your daily routine. If you do not complete your routine before the next day, the streak will be reset to 0. The longer the streak, the higher the multiplier when earning points."),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Get.back(); // Close the dialog
//               },
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Profile',
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineSmall
//                 ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
//         actions: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.indigo[50]?.withOpacity(0.1),
//             ),
//             child: IconButton(
//               onPressed: () => Get.back(),
//               iconSize: 28.0,
//               icon: const Icon(Icons.close),
//             ),
//           ),
//         ],
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//           future: _userDetailsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else if (!snapshot.hasData || snapshot.data == null) {
//               return const Center(
//                 child: Text('No data available'),
//               );
//             } else if (snapshot.hasData) {
//               // Extract user data
//               Map<String, dynamic>? user = snapshot.data!.data();
//               int currentLevel = user?['level'] ?? 1;
//               int currentPoints = user?['points'] ?? 0;
//               int pointsRequired =
//                   _firestoreService.calculateRequiredPoints(currentLevel);

//               double progressRatio = currentPoints / pointsRequired;
//               String? profilePicUrl = user?['profilePic'];

//               return Container(
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Profile Image
//                         Stack(
//                           children: [
//                             SizedBox(
//                               width: 120,
//                               height: 120,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: profilePicUrl != null &&
//                                         profilePicUrl.isNotEmpty
//                                     ? Image.network(profilePicUrl)
//                                     : const Image(
//                                         image: AssetImage(
//                                             'assets/images/default_profile.png')),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 width: 35,
//                                 height: 35,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     color: Colors.indigo[50]),
//                                 child: IconButton(
//                                   icon: const Icon(
//                                     Icons.create_outlined,
//                                     color: Colors.black,
//                                     size: 20,
//                                   ),
//                                   onPressed: () async {
//                                     final result = await Get.to(
//                                         () => const UpdateProfileScreen());
//                                     if (result == true) {
//                                       _loadUserData();
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 20),
//                         // Profile Info
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Wrap(
//                                 children: [
//                                   Text(
//                                     '${user?['firstName'] ?? ''} ${user?['lastName'] ?? ''}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headlineSmall
//                                         ?.copyWith(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                               Wrap(
//                                 children: [
//                                   Text(
//                                     user?['email'] ?? '',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               // Level Indicator
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Lvl ${user?['level'] ?? 1}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.whatshot,
//                                         color: Colors.orange,
//                                       ),
//                                       const SizedBox(width: 2),
//                                       Text(
//                                         '${user?['dailyStreak'] ?? 0}', // Daily streak count
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(
//                                       Icons.info_outline,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                     onPressed: () {
//                                       _showInfoDialog(context);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 5),
//                               // XP Progress Bar
//                               Stack(
//                                 children: [
//                                   Container(
//                                     width: 160, // Total width of the XP bar
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 160 *
//                                         progressRatio, // Width based on progress
//                                     height: 20,
//                                     decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                   Positioned.fill(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         '$currentPoints / $pointsRequired XP',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const Divider(),
//                     const SizedBox(height: 10),

//                     /// -- MENU
//                     ProfileMenuWidget(
//                         title: "Friends List",
//                         icon: Icons.people,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const FriendsListScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Achievements",
//                         icon: Icons.emoji_events,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               AchievementsScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Rewards",
//                         icon: Icons.card_giftcard,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const RewardsScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Wellness Support",
//                         icon: Icons.local_hospital,
//                         textColor: Colors.white,
//                         onPress: () {}),
//                     ProfileMenuWidget(
//                         title: "Send Feedback",
//                         icon: Icons.feedback,
//                         textColor: Colors.white,
//                         onPress: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (context) {
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                   bottom:
//                                       MediaQuery.of(context).viewInsets.bottom,
//                                 ),
//                                 child: FeedbackForm(),
//                               );
//                             },
//                           );
//                         }),
//                     const Divider(),
//                     const SizedBox(height: 10),
//                     ProfileMenuWidget(
//                         title: "Personal Data",
//                         icon: Icons.person,
//                         textColor: Colors.white,
//                         onPress: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text("Delete All Personal Data"),
//                                 content: const Text(
//                                     "Are you sure you want to delete all your tracked data? This action cannot be undone."),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () {
//                                       Get.back(); // Close the dialog
//                                     },
//                                     child: const Text("Cancel"),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       // Perform data deletion
//                                       Get.snackbar(
//                                         'Deleted',
//                                         'All your tracked data has been deleted.',
//                                         snackPosition: SnackPosition.BOTTOM,
//                                       );
//                                       Get.back(); // Close the dialog
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.redAccent,
//                                     ),
//                                     child: const Text("Delete"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }),
//                     ProfileMenuWidget(
//                         title: "Terms",
//                         icon: Icons.info,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const TermsScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Privacy Policy",
//                         icon: Icons.privacy_tip,
//                         textColor: Colors.white,
//                         onPress: () {
//                           Get.to(() =>
//                               const PrivacyPolicyScreen()); // Navigate to FriendsListPage
//                         }),
//                     ProfileMenuWidget(
//                         title: "Logout",
//                         icon: Icons.logout,
//                         textColor: Colors.red,
//                         endIcon: false,
//                         onPress: () {
//                           Get.defaultDialog(
//                             title: "LOGOUT",
//                             titleStyle: const TextStyle(fontSize: 20),
//                             content: const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 15.0),
//                               child: Text("Are you sure, you want to Logout?"),
//                             ),
//                             confirm: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 logout(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.redAccent,
//                                   side: BorderSide.none),
//                               child: const Text("Yes"),
//                             ),
//                             cancel: OutlinedButton(
//                                 onPressed: () => Get.back(),
//                                 child: const Text("No")),
//                           );
//                         }),
//                     ProfileMenuWidget(
//                         title: "Delete Account",
//                         icon: Icons.delete,
//                         textColor: Colors.red,
//                         onPress: () {
//                           _showDeleteAccountDialog(context);
//                         }),
//                   ],
//                 ),
//               );
//             } else {
//               return const Text('No Data');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ProfileMenuWidget extends StatelessWidget {
//   const ProfileMenuWidget({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.onPress,
//     this.endIcon = true,
//     this.textColor,
//   }) : super(key: key);

//   final String title;
//   final IconData icon;
//   final VoidCallback onPress;
//   final bool endIcon;
//   final Color? textColor;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onPress,
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: Colors.indigo[50]?.withOpacity(0.1),
//         ),
//         child: Icon(icon, color: Colors.indigo[50]),
//       ),
//       title: Text(title,
//           style:
//               Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
//       trailing: endIcon
//           ? Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.grey.withOpacity(0.1),
//               ),
//               child: Icon(Icons.arrow_forward_ios,
//                   size: 18.0, color: Colors.indigo[50]))
//           : null,
//     );
//   }
// }

// class FeedbackForm extends StatelessWidget {
//   final TextEditingController _feedbackController = TextEditingController();

//   FeedbackForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Center(
//             child: Text(
//               'Make app better',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _feedbackController,
//             maxLines: 5,
//             decoration: InputDecoration(
//               hintText: 'What can we do to improve the ZenMate app?',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//             ),
//           ),
//           const SizedBox(height: 22),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () async {
//                 // Handle feedback submission
//                 String feedback = _feedbackController.text;
//                 if (feedback.isNotEmpty) {
//                   // Process the feedback
//                   await FirestoreService().addFeedback(feedback);
//                   Get.snackbar(
//                       'Thank you!', 'Your feedback has been submitted.');
//                   Navigator.pop(context);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.indigo,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//               child: const Text('SEND FEEDBACK'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// navigate to login screen after delete account
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/auth/auth_screen.dart';
import 'package:mental_wellness_app/services/firestore.dart'; // Import the Firestore service
import 'package:mental_wellness_app/views/achievements_screen.dart';
import 'package:mental_wellness_app/views/friends_list_screen.dart';
import 'package:mental_wellness_app/views/help_resources_screen.dart';
import 'package:mental_wellness_app/views/privacy_policy_screen.dart';
import 'package:mental_wellness_app/views/rewards_screen.dart';
import 'package:mental_wellness_app/views/terms_screen.dart';
import 'package:mental_wellness_app/views/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDetailsFuture;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      _userDetailsFuture = _firestoreService.getMemberDetails();
    });
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(() => const AuthScreen());
    });
  }

  Future<void> _deleteAccount(BuildContext context) async {
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

    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Remove references from friends subcollection
    QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
        .collection('Members')
        .doc(memberId)
        .collection('friends')
        .get();

    for (QueryDocumentSnapshot friendDoc in friendsSnapshot.docs) {
      String friendId = friendDoc.id;
      // Delete the member reference from each friend's friends subcollection
      batch.delete(FirebaseFirestore.instance
          .collection('Members')
          .doc(friendId)
          .collection('friends')
          .doc(memberId));

      // Delete the nudge documents sent by the member in each friend's nudges subcollection
      QuerySnapshot nudgesSnapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(friendId)
          .collection('nudges')
          .where('senderId', isEqualTo: memberId)
          .get();

      for (QueryDocumentSnapshot nudgeDoc in nudgesSnapshot.docs) {
        batch.delete(nudgeDoc.reference);
      }
    }

    // Remove references from counsellors' appointments
    QuerySnapshot counsellorsSnapshot =
        await FirebaseFirestore.instance.collection('counsellors').get();

    for (QueryDocumentSnapshot counsellorDoc in counsellorsSnapshot.docs) {
      QuerySnapshot appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(counsellorDoc.id)
          .collection('appointments')
          .where('bookedBy', isEqualTo: memberId)
          .get();

      for (QueryDocumentSnapshot appointmentDoc in appointmentsSnapshot.docs) {
        batch.delete(FirebaseFirestore.instance
            .collection('counsellors')
            .doc(counsellorDoc.id)
            .collection('appointments')
            .doc(appointmentDoc.id));
      }
    }

    // Remove references from feedback collection
    QuerySnapshot feedbackSnapshot = await FirebaseFirestore.instance
        .collection('feedback')
        .where('memberId', isEqualTo: memberId)
        .get();

    for (QueryDocumentSnapshot feedbackDoc in feedbackSnapshot.docs) {
      batch.delete(feedbackDoc.reference);
    }

    // Remove references from friend_requests collection
    QuerySnapshot friendRequestsSnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('receiverId', isEqualTo: memberId)
        .get();

    for (QueryDocumentSnapshot requestDoc in friendRequestsSnapshot.docs) {
      batch.delete(requestDoc.reference);
    }

    friendRequestsSnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('senderId', isEqualTo: memberId)
        .get();

    for (QueryDocumentSnapshot requestDoc in friendRequestsSnapshot.docs) {
      batch.delete(requestDoc.reference);
    }

    // Delete member document
    batch
        .delete(FirebaseFirestore.instance.collection('Members').doc(memberId));

    // Commit batch
    await batch.commit();

    // Delete Firebase Authentication user
    await currentUser.delete();

    // Navigate to login screen
    Get.offAll(() => const AuthScreen());
  }

  void _showDeleteAccountDialog(BuildContext context) {
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
                await _deleteAccount(context);
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

  void _showInfoDialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.indigo[50]?.withOpacity(0.1),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              iconSize: 28.0,
              icon: const Icon(Icons.close),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _userDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('No data available'),
              );
            } else if (snapshot.hasData) {
              // Extract user data
              Map<String, dynamic>? user = snapshot.data!.data();
              int currentLevel = user?['level'] ?? 1;
              int currentPoints = user?['points'] ?? 0;
              int pointsRequired =
                  _firestoreService.calculateRequiredPoints(currentLevel);

              double progressRatio = currentPoints / pointsRequired;
              String? profilePicUrl = user?['profilePic'];

              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: profilePicUrl != null &&
                                        profilePicUrl.isNotEmpty
                                    ? Image.network(
                                        profilePicUrl,
                                        fit: BoxFit.cover,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            'assets/images/default_profile.png'),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.indigo[50]),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.create_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    final result = await Get.to(
                                        () => const UpdateProfileScreen());
                                    if (result == true) {
                                      _loadUserData();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        // Profile Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    '${user?['firstName'] ?? ''} ${user?['lastName'] ?? ''}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                  ),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    user?['email'] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Level Indicator
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lvl ${user?['level'] ?? 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.whatshot,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${user?['dailyStreak'] ?? 0}', // Daily streak count
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      _showInfoDialog(context);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              // XP Progress Bar
                              Stack(
                                children: [
                                  Container(
                                    width: 160, // Total width of the XP bar
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Container(
                                    width: 160 *
                                        progressRatio, // Width based on progress
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$currentPoints / $pointsRequired XP',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),

                    /// -- MENU
                    ProfileMenuWidget(
                        title: "Friends List",
                        icon: Icons.people,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() =>
                              const FriendsListScreen()); // Navigate to FriendsListPage
                        }),
                    ProfileMenuWidget(
                        title: "Achievements",
                        icon: Icons.emoji_events,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() =>
                              AchievementsScreen()); // Navigate to FriendsListPage
                        }),
                    ProfileMenuWidget(
                        title: "Rewards",
                        icon: Icons.card_giftcard,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() =>
                              const RewardsScreen()); // Navigate to FriendsListPage
                        }),
                    ProfileMenuWidget(
                        title: "Help Resources",
                        icon: Icons.local_hospital,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() => WellnessResourcesScreen());
                        }),
                    ProfileMenuWidget(
                        title: "Send Feedback",
                        icon: Icons.feedback,
                        textColor: Colors.white,
                        onPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: FeedbackForm(),
                              );
                            },
                          );
                        }),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(
                        title: "Personal Data",
                        icon: Icons.person,
                        textColor: Colors.white,
                        onPress: () {
                          _showDeleteAccountDialog(context);
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: const Text("Delete All Personal Data"),
                          //       content: const Text(
                          //           "Are you sure you want to delete all your tracked data? This action cannot be undone."),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           onPressed: () {
                          //             Get.back(); // Close the dialog
                          //           },
                          //           child: const Text("Cancel"),
                          //         ),
                          //         ElevatedButton(
                          //           onPressed: () {
                          //             // Perform data deletion
                          //             Get.snackbar(
                          //               'Deleted',
                          //               'All your tracked data has been deleted.',
                          //               snackPosition: SnackPosition.BOTTOM,
                          //             );
                          //             Get.back(); // Close the dialog
                          //           },
                          //           style: ElevatedButton.styleFrom(
                          //             backgroundColor: Colors.redAccent,
                          //           ),
                          //           child: const Text("Delete"),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        }),
                    ProfileMenuWidget(
                        title: "Terms",
                        icon: Icons.info,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() =>
                              const TermsScreen()); // Navigate to FriendsListPage
                        }),
                    ProfileMenuWidget(
                        title: "Privacy Policy",
                        icon: Icons.privacy_tip,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() =>
                              const PrivacyPolicyScreen()); // Navigate to FriendsListPage
                        }),
                    ProfileMenuWidget(
                        title: "Logout",
                        icon: Icons.logout,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          Get.defaultDialog(
                            title: "",
                            titleStyle: const TextStyle(fontSize: 20),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.logout,
                                    size: 80,
                                    color: Colors.indigo[800]), // Larger icon
                                SizedBox(
                                    height: 20), // More space below the icon
                                Text(
                                  "Are you sure you want to logout?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 220, // Make buttons the same width
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      logout(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo[800],
                                      side: BorderSide.none,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15), // Make button wider
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // Less circular border
                                      ),
                                    ),
                                    child: Text(
                                      "Yes, Log Me Out",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10), // Space between buttons
                                SizedBox(
                                  width: 220, // Make buttons the same width
                                  child: OutlinedButton(
                                    onPressed: () => Get.back(),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.indigo),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15), // Make button wider
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // Less circular border
                                      ),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style:
                                          TextStyle(color: Colors.indigo[800]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    // ProfileMenuWidget(
                    //     title: "Delete Account",
                    //     icon: Icons.delete,
                    //     textColor: Colors.red,
                    //     onPress: () {
                    //       _showDeleteAccountDialog(context);
                    //     }),
                  ],
                ),
              );
            } else {
              return const Text('No Data');
            }
          },
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo[50]?.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.indigo[50]),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Icons.arrow_forward_ios,
                  size: 18.0, color: Colors.indigo[50]))
          : null,
    );
  }
}

class FeedbackForm extends StatelessWidget {
  final TextEditingController _feedbackController = TextEditingController();

  FeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Make app better',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'What can we do to improve the ZenMate app?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Handle feedback submission
                String feedback = _feedbackController.text;
                if (feedback.isNotEmpty) {
                  // Process the feedback
                  await FirestoreService().addFeedback(feedback);
                  Get.snackbar(
                    'Thank you!',
                    'Your feedback has been submitted.',
                    backgroundColor: Colors.white60,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('SEND FEEDBACK'),
            ),
          ),
        ],
      ),
    );
  }
}
