import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  final List<Meditation> meditations = const [
    Meditation(
      title: "A Woodland Stroll to Sleep",
      author: "Prof. Megan Reitz",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "34 min",
    ),
    Meditation(
      title: "Soften Into Sleep",
      author: "Chibs Okereke",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "30 min",
    ),
    Meditation(
      title: "Falling Back to Sleep With Ease",
      author: "Dr. Eric López, Ph.D.",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "15 min",
    ),
    Meditation(
      title: "Journey to Rest on the Mountaintop",
      author: "Dr. Eric López, Ph.D.",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "30 min",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Recommended Exercise Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Image.asset(
                      'lib/images/google.png', // Replace with your image path
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recommended Exercise',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Try this new yoga routine to improve your flexibility.',
                            style: TextStyle(
                              fontSize: 16,
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

            const SizedBox(height: 10), // Add spacing between sections

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: meditations.length,
                itemBuilder: (context, index) {
                  return MeditationCard(meditation: meditations[index]);
                },
              ),
            ),

            // Expanded(
            //   child: GridView.count(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //     children: const [
            //       DashboardItem(
            //         title: 'Spiritual Growth',
            //         subtitle: 'Ongoing - 2nd Set\n52% remaining',
            //         isOngoing: true,
            //         imagePath:
            //             'lib/images/google.png', // Replace with your image path
            //       ),
            //       DashboardItem(
            //         title: 'Mind Training',
            //         subtitle: '3 sets - Done\nCompleted 100%',
            //         isOngoing: false,
            //         imagePath:
            //             'lib/images/google.png', // Replace with your image path
            //       ),
            //       DashboardItem(
            //         title: 'Me. Wellbeing',
            //         subtitle: '3 sets - Done\nCompleted 100%',
            //         isOngoing: false,
            //         imagePath:
            //             'lib/images/google.png', // Replace with your image path
            //       ),
            //       DashboardItem(
            //         title: 'Intro',
            //         subtitle: '10 minutes - Done\nCompleted 100%',
            //         isOngoing: false,
            //         imagePath:
            //             'lib/images/google.png', // Replace with your image path
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class DashboardItem extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final bool isOngoing;
//   final String imagePath;

//   const DashboardItem({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.isOngoing,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (isOngoing)
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Image.asset(
//                   imagePath,
//                   height: 40,
//                   width: 40,
//                 ),
//               ),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[700],
//               ),
//             ),
//             if (!isOngoing)
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Image.asset(
//                   imagePath,
//                   height: 40,
//                   width: 40,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Meditation {
  final String title;
  final String author;
  final String imagePath;
  final String duration;

  const Meditation({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.duration,
  });
}

class MeditationCard extends StatelessWidget {
  final Meditation meditation;

  const MeditationCard({required this.meditation, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MeditationDetailScreen(), //MeditationDetailScreen(meditation: meditation),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              meditation.imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment:
                  Alignment.centerRight, // Align the image to the right side
            ),
          ),
          const SizedBox(height: 8), // Add spacing between image and text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        meditation.title,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        meditation.author,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
