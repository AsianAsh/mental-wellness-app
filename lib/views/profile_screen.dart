import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/auth/auth_screen.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/views/achievements_screen.dart';
import 'package:mental_wellness_app/views/friends_list_screen.dart';
import 'package:mental_wellness_app/views/login_screen.dart';
import 'package:mental_wellness_app/views/privacy_policy_screen.dart';
import 'package:mental_wellness_app/views/rewards_screen.dart';
import 'package:mental_wellness_app/views/terms_screen.dart';
import 'package:mental_wellness_app/views/update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  // // current logged in user
  // final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirestoreService _firestoreService = FirestoreService();

  // // future to fetch user details
  // Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
  //   return await FirebaseFirestore.instance
  //       .collection("Members")
  //       .doc(currentUser!.uid)
  //       .get();
  // }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes default go back button
        title: Text('Profile',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {},
              iconSize: 25.0,
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode)),
          Container(
            // width: 38.0, // Adjust the width as needed
            // height: 38.0, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.indigo[50]?.withOpacity(0.1),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              iconSize: 28.0, // Adjust the icon size as needed
              icon: const Icon(Icons.close),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _firestoreService.getMemberDetails(), //current logged in user
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );

              // error
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
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      // Profile Info
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
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/gong_yoo.jpg'))),
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
                                  onPressed: () =>
                                      Get.to(() => const UpdateProfileScreen()),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            width: 20), // Add spacing between image and text
                        // Profile Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                          )),
                                  const SizedBox(width: 8),
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
                              Text(user?['email'] ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white)),
                              const SizedBox(height: 10),

                              // Level Indicator
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
                              const SizedBox(height: 5),

                              // XP Progress Bar
                              Stack(
                                children: [
                                  Container(
                                    width: 150, // Adjust the width as needed
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        90, // Adjust the width according to the current XP
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '450 / 1000 XP',
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
                              const AchievementsScreen()); // Navigate to FriendsListPage
                        }),
                    ProfileMenuWidget(
                        title: "Rewards",
                        icon: Icons.card_giftcard,
                        textColor: Colors.white,
                        onPress: () {
                          Get.to(() =>
                              const RewardsScreen()); // Navigate to FriendsListPage
                        }),
                    // ProfileMenuWidget(
                    //     title: "Settings",
                    //     icon: Icons.settings,
                    //     textColor: Colors.white,
                    //     onPress: () {}),
                    ProfileMenuWidget(
                        title: "Wellness Support",
                        icon: Icons.local_hospital,
                        textColor: Colors.white,
                        onPress: () {}),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete All Personal Data"),
                                content: const Text(
                                    "Are you sure you want to delete all your tracked data? This action cannot be undone."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.back(); // Close the dialog
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Perform data deletion
                                      Get.snackbar(
                                        'Deleted',
                                        'All your tracked data has been deleted.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      Get.back(); // Close the dialog
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
                            title: "LOGOUT",
                            titleStyle: const TextStyle(fontSize: 20),
                            content: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text("Are you sure, you want to Logout?"),
                            ),
                            confirm: ElevatedButton(
                              // Template onPress code
                              // onPressed: () =>
                              //     // AuthenticationRepository.instance.logout(),

                              // Navigate to login screen
                              onPressed: () {
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => LoginScreen()),
                                // );
                                Navigator.pop(context);
                                // Logout
                                logout(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  side: BorderSide.none),
                              child: const Text("Yes"),
                            ),
                            cancel: OutlinedButton(
                                onPressed: () => Get.back(),
                                child: const Text("No")),
                          );
                        }),
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
              hintText:
                  'What should we do to improve the BetterMe: Mental Health app?',
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
                      'Thank you!', 'Your feedback has been submitted.');
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
