import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/views/achievements_screen.dart';
import 'package:mental_wellness_app/views/friends_list_screen.dart';
import 'package:mental_wellness_app/views/login_screen.dart';
import 'package:mental_wellness_app/views/rewards_screen.dart';
import 'package:mental_wellness_app/views/update_profile_screen.dart';

class FriendsListScreen extends StatelessWidget {
  const FriendsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Friends List',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Friend',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Friend\'s Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle send friend request
                      Navigator.pop(context);
                    },
                    child: Text('Send Request'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class FriendsTab extends StatelessWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendProfile = FriendProfile(
      name: 'Emily Elliott',
      email: 'emily@example.com',
      bio: 'Bio of Emily Elliott',
      description: 'Description of Emily Elliott',
      level: 13,
      dailyStreak: 20,
      countryFlag: '🇺🇸',
      countryName: 'United States',
      achievements: [Icons.star, Icons.spa, Icons.emoji_events],
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      child: ListView(
        children: [
          FriendCard(
            name: 'Emily Elliott',
            profileImage: 'assets/images/gong_yoo.jpg',
            routineStatus: 'Could use a nudge',
            onViewProfile: () {
              // View profile functionality
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) =>
                    FriendProfileOverlay(profile: friendProfile),
              );
            },
            onInteract: () {
              // Interact functionality
              showMindfulMessageModal(context, 'Emily Elliott');
            },
            onRemove: () {
              // Remove friend functionality
            },
          ),
          FriendCard(
            name: 'Piers Merchant',
            profileImage: 'assets/images/gong_yoo.jpg',
            routineStatus: '',
            onViewProfile: () {
              // View profile functionality
            },
            onInteract: () {
              // Interact functionality
              showMindfulMessageModal(context, 'Piers Merchant');
            },
            onRemove: () {
              // Remove friend functionality
            },
          ),
          FriendCard(
            name: 'Olivia Burns',
            profileImage: 'assets/images/gong_yoo.jpg',
            routineStatus: 'Could use a nudge',
            onViewProfile: () {
              // View profile functionality
            },
            onInteract: () {
              // Interact functionality
              showMindfulMessageModal(context, 'Olivia Burns');
            },
            onRemove: () {
              // Remove friend functionality
            },
          ),
          // Add more FriendCard widgets here
        ],
      ),
    );
  }

  // Modal to select and send mindful message to friend
  void showMindfulMessageModal(BuildContext context, String friendName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize:
              0.8, // Set the initial size to 80% of the screen height
          minChildSize: 0.5, // Minimum size is 50% of the screen height
          maxChildSize: 0.88, // Maximum size is 90% of the screen height
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // X cancel button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Center(
                    child: Text(
                      'Send $friendName a mindful message',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        MindfulMessageCard(
                          icon: Icons.sentiment_satisfied,
                          message: 'Keep up that run streak, buddy.',
                          backgroundColor: Colors.blue[200]!,
                        ),
                        MindfulMessageCard(
                          icon: Icons.favorite,
                          message: 'Sending some love your way.',
                          backgroundColor: Colors.pink[200]!,
                        ),
                        MindfulMessageCard(
                          icon: Icons.waving_hand,
                          message: 'Just saying hi.',
                          backgroundColor: Colors.green[200]!,
                        ),
                        MindfulMessageCard(
                          icon: Icons.cloud,
                          message: 'Be kind to your mind.',
                          backgroundColor: Colors.blue[100]!,
                        ),
                        MindfulMessageCard(
                          icon: Icons.bubble_chart,
                          message: 'You deserve some Headspace today.',
                          backgroundColor: Colors.orange[200]!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class MindfulMessageCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color backgroundColor;

  const MindfulMessageCard({
    Key? key,
    required this.icon,
    required this.message,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListTile(
          leading:
              Icon(icon, size: 50, color: Colors.white), // Increased icon size
          title: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
      child: ListView(
        children: [
          FriendRequestCard(
            name: 'Emily Elliott',
            profileImage: 'assets/images/gong_yoo.jpg',
            onAccept: () {
              // Accept request functionality
            },
            onIgnore: () {
              // Ignore request functionality
            },
          ),
          FriendRequestCard(
            name: 'Piers Merchant',
            profileImage: 'assets/images/gong_yoo.jpg',
            onAccept: () {
              // Accept request functionality
            },
            onIgnore: () {
              // Ignore request functionality
            },
          ),
          FriendRequestCard(
            name: 'Olivia Burns',
            profileImage: 'assets/images/gong_yoo.jpg',
            onAccept: () {
              // Accept request functionality
            },
            onIgnore: () {
              // Ignore request functionality
            },
          ),
          // Add more FriendRequestCard widgets here
        ],
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  final String name;
  final String profileImage;
  final String routineStatus;
  final VoidCallback onViewProfile;
  final VoidCallback onInteract;
  final VoidCallback onRemove;

  const FriendCard({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.routineStatus,
    required this.onViewProfile,
    required this.onInteract,
    required this.onRemove,
  }) : super(key: key);

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
                            routineStatus,
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
                  onPressed: onInteract,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FriendRequestCard extends StatelessWidget {
  final String name;
  final String profileImage;
  final VoidCallback onAccept;
  final VoidCallback onIgnore;

  const FriendRequestCard({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.onAccept,
    required this.onIgnore,
  }) : super(key: key);

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
                  backgroundImage: AssetImage(profileImage),
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
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '5 min ago',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Wants to be your Friend',
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

class FriendProfile {
  final String name;
  final String email;
  final String bio;
  final String description;
  final int level;
  final int dailyStreak;
  final String countryFlag;
  final String countryName;
  final List<IconData> achievements;

  FriendProfile({
    required this.name,
    required this.email,
    required this.bio,
    required this.description,
    required this.level,
    required this.dailyStreak,
    required this.countryFlag,
    required this.countryName,
    required this.achievements,
  });
}

class FriendProfileOverlay extends StatelessWidget {
  final FriendProfile profile;

  const FriendProfileOverlay({Key? key, required this.profile})
      : super(key: key);

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/gong_yoo.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  profile.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bio',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(profile.bio),
              const SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(profile.description),
              const SizedBox(height: 20),
              Text(
                'Level: ${profile.level}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Daily Streak: ${profile.dailyStreak}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    profile.countryFlag,
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    profile.countryName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Achievements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: profile.achievements
                    .map((icon) => Icon(icon, size: 30))
                    .toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
