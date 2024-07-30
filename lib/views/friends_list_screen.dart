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
