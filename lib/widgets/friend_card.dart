import 'package:flutter/material.dart';
import 'package:mental_wellness_app/models/nudge.dart';

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
                      backgroundImage: profileImage.isNotEmpty
                          ? (profileImage.startsWith('http')
                                  ? NetworkImage(profileImage)
                                  : AssetImage(profileImage))
                              as ImageProvider<Object>
                          : const AssetImage(
                              'assets/images/default_profile.png'),
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
