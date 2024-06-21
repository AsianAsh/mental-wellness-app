import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_wellness_app/views/breathing_play_screen.dart';
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

  // Breathing Exercise Options
  final List<BreathingExercise> breathingExercises = const [
    BreathingExercise(
      title: "Anxiety",
      duration: "2 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
    BreathingExercise(
      title: "Anger",
      duration: "3 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
    BreathingExercise(
      title: "Irritation",
      duration: "3 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
    BreathingExercise(
      title: "Sadness",
      duration: "3 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
    BreathingExercise(
      title: "Fear",
      duration: "3 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
    BreathingExercise(
      title: "Worry",
      duration: "4 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
    BreathingExercise(
      title: "Envy",
      duration: "3 min",
      imagePath: "assets/images/relaxing/relaxing_sounds_1.png",
      audioPath: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meditation',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // // Recommended Exercise Section
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15.0),
            //   ),
            //   elevation: 5,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Row(
            //       children: [
            //         Image.asset(
            //           'lib/images/google.png', // Replace with your image path
            //           height: 60,
            //           width: 60,
            //         ),
            //         const SizedBox(width: 10),
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Recommended Exercise',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               const SizedBox(height: 5),
            //               Text(
            //                 'Try this new yoga routine to improve your flexibility.',
            //                 style: TextStyle(
            //                   fontSize: 16,
            //                   color: Colors.grey[700],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Breathing Exercises Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      'What do you want to reduce?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: breathingExercises.length,
                      itemBuilder: (context, index) {
                        return BreathingExerciseCard(
                            exercise: breathingExercises[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Add spacing between sections

            // Meditation Exercise Section
            // Meditation Exercise Title
            Align(
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Meditation Exercises',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Meditation Options Grid
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

class BreathingExercise {
  final String title;
  final String duration;
  final String imagePath;
  final String audioPath;

  const BreathingExercise({
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.audioPath,
  });
}

class BreathingExerciseCard extends StatelessWidget {
  final BreathingExercise exercise;

  const BreathingExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Go to Selected Breathing Screen
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BreathingPlayScreen(),
          ),
        );
      },
      child: Container(
        width: 110, // Adjust the width as needed
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.indigo[600],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exercise.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 5),
            Text(
              exercise.duration,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Image.asset(
              exercise.imagePath,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
