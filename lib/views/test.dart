// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mental_wellness_app/controllers/meditation_exercise_controller.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/views/breathing_play_screen.dart';
// import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';

// class MeditationPage extends StatelessWidget {
//   MeditationPage({super.key});

//   final BreathingExerciseController controller =
//       Get.put(BreathingExerciseController());

//   final MeditationExerciseController meditationController =
//       Get.put(MeditationExerciseController());

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
//       body:
//           Padding(
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
//                   // new
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

//             // Meditation Exercise Section
//             // Meditation Exercise Title
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(
//                   'Meditation Exercises',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             // Meditation Options Grid
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(10),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.7,
//                 ),
//                 itemCount: meditations.length,
//                 itemBuilder: (context, index) {
//                   return MeditationCard(meditation: meditations[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MeditationCard extends StatelessWidget {
//   final MeditationExercise meditation;

//   const MeditationCard({required this.meditation, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 const MeditationDetailScreen(), //MeditationDetailScreen(meditation: meditation),
//           ),
//         );
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Image.asset(
//               meditation.imagePath,
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               alignment:
//                   Alignment.centerRight, // Align the image to the right side
//             ),
//           ),
//           const SizedBox(height: 8), // Add spacing between image and text
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Flexible(
//                       child: Text(
//                         meditation.title,
//                         style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         meditation.getDurationText(),
//                         style: GoogleFonts.lato(
//                           fontSize: 12,
//                           color: Colors.grey[400],
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BreathingExerciseCard extends StatelessWidget {
//   final BreathingExercise exercise;

//   const BreathingExerciseCard(
//       //new
//       {required this.exercise,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       //onTap: onTap,
//       //new
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
//             // const SizedBox(height: 5),
//             Text(
//               exercise.getDurationText(),
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontSize: 12,
//               ),
//             ),
//             const SizedBox(height: 8),
//             ClipOval(
//               child: Image.asset(
//                 exercise.imagePath,
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
