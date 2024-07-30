// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/profile_controller.dart';
import 'package:mental_wellness_app/views/achievements_screen.dart';
import 'package:mental_wellness_app/views/friends_list_screen.dart';
import 'package:mental_wellness_app/views/help_resources_screen.dart';
import 'package:mental_wellness_app/views/privacy_policy_screen.dart';
import 'package:mental_wellness_app/views/rewards_screen.dart';
import 'package:mental_wellness_app/views/terms_screen.dart';
import 'package:mental_wellness_app/views/update_profile_screen.dart';
import 'package:mental_wellness_app/widgets/profile_menu_widget.dart';
import 'package:mental_wellness_app/widgets/feedback_form.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

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
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.userDetails.value == null) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            var user = _controller.userDetails.value!;
            int currentLevel = user['level'] ?? 1;
            int currentPoints = user['points'] ?? 0;
            int pointsRequired =
                _controller.calculateRequiredPoints(currentLevel);

            double progressRatio = currentPoints / pointsRequired;
            String? profilePicUrl = user['profilePic'];

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
                                  final result =
                                      await Get.to(() => UpdateProfileScreen());
                                  if (result == true) {
                                    _controller.loadUserData();
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
                                  '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}',
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
                                  user['email'] ?? '',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lvl ${user['level'] ?? 1}',
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
                                      '${user['dailyStreak'] ?? 0}', // Daily streak count
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
                                    _controller.showInfoDialog(context);
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
                        _controller.showDeleteAccountDialog(context);
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
                            SizedBox(height: 20), // More space below the icon
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
                                  _controller.logout(context);
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
                                  style: TextStyle(color: Colors.indigo[800]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
