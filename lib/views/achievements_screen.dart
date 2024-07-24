// Legacy version
// import 'package:flutter/material.dart';

// class AchievementsScreen extends StatelessWidget {
//   const AchievementsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Achievements'),
//         backgroundColor: Colors.indigo, // Distinct app bar color
//       ),
//       body: Container(
//         color: Colors.white, // Set the background color to white
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView(
//             children: [
//               AchievementCard(
//                 icon: Icons.book,
//                 title: 'Finishing a Book',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               AchievementCard(
//                 icon: Icons.add,
//                 title: 'Adding a Book',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               AchievementCard(
//                 icon: Icons.rate_review,
//                 title: 'Giving a Review',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               AchievementCard(
//                 icon: Icons.star,
//                 title: 'First Reader',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               AchievementCard(
//                 icon: Icons.bookmark,
//                 title: 'Pages Read',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               AchievementCard(
//                 icon: Icons.star_rate,
//                 title: 'Star Rating',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               AchievementCard(
//                 icon: Icons.list,
//                 title: 'Finishing Influence List',
//                 description:
//                     'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
//               ),
//               // Add more AchievementCard widgets as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AchievementCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String description;

//   const AchievementCard({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.description,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             HexagonIcon(
//               icon: icon,
//               size: 50,
//               color: Colors.indigo,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HexagonIcon extends StatelessWidget {
//   final IconData icon;
//   final double size;
//   final Color color;

//   const HexagonIcon({
//     Key? key,
//     required this.icon,
//     required this.size,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         CustomPaint(
//           size: Size(size, size),
//           painter: HexagonPainter(color: color),
//         ),
//         Icon(
//           icon,
//           size: size * 0.6, // Adjust the icon size to fit inside the hexagon
//           color: Colors.white,
//         ),
//       ],
//     );
//   }
// }

// class HexagonPainter extends CustomPainter {
//   final Color color;

//   HexagonPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final Path path = Path();
//     final double width = size.width;
//     final double height = size.height;

//     path.moveTo(width * 0.5, 0);
//     path.lineTo(width, height * 0.25);
//     path.lineTo(width, height * 0.75);
//     path.lineTo(width * 0.5, height);
//     path.lineTo(0, height * 0.75);
//     path.lineTo(0, height * 0.25);
//     path.close();

//     canvas.drawPath(path, paint);

//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4.0;
//     paint.color = color;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_wellness_app/widgets/achievement_card.dart';

class AchievementsScreen extends StatelessWidget {
  Future<List<Map<String, String>>> _getEarnedAchievements() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);

    QuerySnapshot achievementsSnapshot =
        await userDoc.collection('achievements').get();

    List<Map<String, String>> earnedAchievements = [];

    for (var doc in achievementsSnapshot.docs) {
      String achievementId = doc['achievementId'];
      DocumentSnapshot achievementDoc = await FirebaseFirestore.instance
          .collection('achievements')
          .doc(achievementId)
          .get();

      if (achievementDoc.exists) {
        earnedAchievements.add({
          'imagePath': achievementDoc['imagePath'],
          'name': achievementDoc['name'],
          'description': achievementDoc['description'],
        });
      }
    }

    return earnedAchievements;
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How Achievements Work'),
          content: Text(
              'Achievements are earned by completing various tasks and milestones within the app. Each achievement has specific criteria that must be met to unlock it.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: Text('Achievements'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _getEarnedAchievements(),
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
