// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mental_wellness_app/widgets/achievement_card.dart';

// class AchievementsScreen extends StatelessWidget {
//   Future<List<Map<String, String>>> _getEarnedAchievements() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return [];

//     DocumentReference userDoc =
//         FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);

//     QuerySnapshot achievementsSnapshot =
//         await userDoc.collection('achievements').get();

//     List<Map<String, String>> earnedAchievements = [];

//     for (var doc in achievementsSnapshot.docs) {
//       String achievementId = doc['achievementId'];
//       DocumentSnapshot achievementDoc = await FirebaseFirestore.instance
//           .collection('achievements')
//           .doc(achievementId)
//           .get();

//       if (achievementDoc.exists) {
//         earnedAchievements.add({
//           'imagePath': achievementDoc['imagePath'],
//           'name': achievementDoc['name'],
//           'description': achievementDoc['description'],
//         });
//       }
//     }

//     return earnedAchievements;
//   }

//   void _showInfoDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('How Achievements Work'),
//           content: Text(
//               'Achievements are earned by completing various tasks and milestones within the app. Each achievement has specific criteria that must be met to unlock it.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
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
//         title: Text('Achievements'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info_outline),
//             onPressed: () {
//               _showInfoDialog(context);
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Map<String, String>>>(
//         future: _getEarnedAchievements(),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<Map<String, String>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No achievements earned yet.'));
//           } else {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var achievement = snapshot.data![index];
//                   return AchievementCard(
//                     imagePath: achievement['imagePath']!,
//                     name: achievement['name']!,
//                     description: achievement['description']!,
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// achievements_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/achievements_controller.dart';
import 'package:mental_wellness_app/widgets/achievement_card.dart';

class AchievementsScreen extends StatelessWidget {
  final AchievementsController _controller = Get.put(AchievementsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _controller.showInfoDialog(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _controller.getEarnedAchievements(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No achievements earned yet.'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var achievement = snapshot.data![index];
                  return AchievementCard(
                    imagePath: achievement['imagePath']!,
                    name: achievement['name']!,
                    description: achievement['description']!,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
