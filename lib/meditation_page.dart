// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/models/breathing_list_provider.dart';
import 'package:mental_wellness_app/views/breathing_play_screen.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';

import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';

class MeditationPage extends StatelessWidget {
  MeditationPage({super.key});

  final BreathingExerciseController controller =
      Get.put(BreathingExerciseController());

  // // get breathing playlist provider
  // late final dynamic playlistProvider;

  // @override
  // void initState() {
  //   super.initState();

  //   // get breathing playlist provider
  //   playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  // }

  // // got to a breathing exercise
  // void goToBreathingExercise(int breathingExerciseIndex) {
  //   // update current exefcise index
  //   playlistProvider.currentBreathingExerciseIndex = breathingExerciseIndex;

  //   // navigate to breathing exercise screen
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BreathingPlayScreen(),
  //     ),
  //   );
  // }

  final List<MeditationExercise> meditations = const [
    MeditationExercise(
      title: "A Woodland Stroll to Sleep",
      author: "Prof. Megan Reitz",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "34 min",
    ),
    MeditationExercise(
      title: "Soften Into Sleep",
      author: "Chibs Okereke",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "30 min",
    ),
    MeditationExercise(
      title: "Falling Back to Sleep With Ease",
      author: "Dr. Eric López, Ph.D.",
      imagePath: "assets/images/meditation_1.jpg",
      duration: "15 min",
    ),
    MeditationExercise(
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
      body:
          // Consumer<BreathingListProvider>(
          //   builder: (context, value, child){
          //     final List<BreathingExercise> playlist = value.playlist;
          //   },
          // ),

          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('breathing_exercise')
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (!snapshot.hasData) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     }

                  //     final exercises = snapshot.data!.docs.map((doc) {
                  //       return BreathingExercise(
                  //         title: doc['title'],
                  //         duration: doc['duration'],
                  //         imagePath: doc['imagePath'],
                  //         audioPath: doc['audioPath'],
                  //       );
                  //     }).toList();

                  //     return SizedBox(
                  //       height: 150,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: exercises.length,
                  //         itemBuilder: (context, index) {
                  //           return BreathingExerciseCard(
                  //             exercise: exercises[index],
                  //             onTap: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) => BreathingPlayScreen(
                  //                     exercise: exercises[index],
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                  // new
                  SizedBox(
                    height: 150, // Adjust the height as needed
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.breathingExercises.length,
                          itemBuilder: (context, index) {
                            return BreathingExerciseCard(
                              exercise: controller.breathingExercises[index],
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add spacing between sections

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
          ],
        ),
      ),
    );
  }
}

// Replaced by the model file of the name MeditationExercise instead of Meditation
// class Meditation {
//   final String title;
//   final String author;
//   final String imagePath;
//   final String duration;

//   const Meditation({
//     required this.title,
//     required this.author,
//     required this.imagePath,
//     required this.duration,
//   });
// }

class MeditationCard extends StatelessWidget {
  final MeditationExercise meditation;

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

// class BreathingExercise {
//   final String title;
//   final int duration;
//   final String imagePath;
//   final String audioPath;

//   const BreathingExercise({
//     required this.title,
//     required this.duration,
//     required this.imagePath,
//     required this.audioPath,
//   });

//   String getDurationText() {
//     return '${duration ~/ 60} min';
//   }
// }

class BreathingExerciseCard extends StatelessWidget {
  final BreathingExercise exercise;
  // final VoidCallback onTap;

  const BreathingExerciseCard(
      // {required this.exercise, required this.onTap, super.key});
      //new
      {required this.exercise,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onTap,
      //new
      onTap: () {
        // Navigate to BreathingPlayScreen with the exercise details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BreathingPlayScreen(exercise: exercise),
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
              exercise.getDurationText(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            ClipOval(
              child: Image.asset(
                exercise.imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/views/breathing_play_screen.dart';

// class MeditationPage extends StatelessWidget {
//   MeditationPage({Key? key}) : super(key: key);

//   final BreathingExerciseController controller =
//       Get.put(BreathingExerciseController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Meditation',
//           style: TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         automaticallyImplyLeading: false, // Remove the back button
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Breathing Exercises Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                     child: Text(
//                       'What do you want to reduce?',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     height: 150, // Adjust the height as needed
//                     child: Obx(() {
//                       if (controller.isLoading.value) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else {
//                         return ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: controller.breathingExercises.length,
//                           itemBuilder: (context, index) {
//                             return BreathingExerciseCard(
//                               exercise: controller.breathingExercises[index],
//                             );
//                           },
//                         );
//                       }
//                     }),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20), // Add spacing between sections

//             // Other Sections...
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BreathingExerciseCard extends StatelessWidget {
//   final BreathingExercise exercise;

//   const BreathingExerciseCard({super.key, required this.exercise});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to BreathingPlayScreen with the exercise details
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BreathingPlayScreen(exercise: exercise),
//           ),
//         );
//       },
//       child: Container(
//         width: 110, // Adjust the width as needed
//         margin: const EdgeInsets.symmetric(horizontal: 5.0),
//         decoration: BoxDecoration(
//           color: Colors.indigo[600],
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               exercise.title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               exercise.getDurationText(),
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontSize: 12,
//               ),
//             ),
//             const SizedBox(height: 5),
//             ClipOval(
//               child: Image.asset(
//                 exercise.imagePath,
//                 height: 80,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
