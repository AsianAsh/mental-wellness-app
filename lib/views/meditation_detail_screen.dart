// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/views/meditation_play_screen.dart';

// class MeditationDetailScreen extends StatelessWidget {
//   const MeditationDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           // Top Image
//           Container(
//             height: 335, // Adjust the height as needed
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/meditation_1.jpg'),
//                 fit: BoxFit.cover,
//                 alignment:
//                     Alignment.centerRight, // Align the image to the right side
//               ),
//             ),
//           ),
//           // Content
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[800],
//                 // borderRadius: const BorderRadius.only(
//                 //   topLeft: Radius.circular(20),
//                 //   topRight: Radius.circular(20),
//                 // ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Gently Back to Sleep',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     '30 min', // Duration text
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Slip back into sleep with a still mind and calm heart', //
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   Center(
//                     child: Column(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     const MeditationPlayScreen(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: const CircleBorder(),
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.all(14), // Button color
//                           ),
//                           child: const Icon(
//                             Icons.play_arrow_rounded,
//                             size: 45,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           'START',
//                           style: TextStyle(
//                             color: Colors.grey[400],
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/views/meditation_play_screen.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';

// class MeditationDetailScreen extends StatelessWidget {
//   final MeditationExercise meditation;

//   const MeditationDetailScreen({required this.meditation, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           // Top Image
//           Container(
//             height: 335, // Adjust the height as needed
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(meditation.imagePath),
//                 fit: BoxFit.cover,
//                 alignment:
//                     Alignment.center, // Align the image to the right side
//               ),
//             ),
//           ),
//           // Content
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[800],
//                 // borderRadius: const BorderRadius.only(
//                 //   topLeft: Radius.circular(20),
//                 //   topRight: Radius.circular(20),
//                 // ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     meditation.title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '${meditation.duration ~/ 60} min', // Duration text
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(
//                         meditation.description,
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Center(
//                     child: Column(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => MeditationPlayScreen(
//                                   meditation: meditation,
//                                 ),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: const CircleBorder(),
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.all(14), // Button color
//                           ),
//                           child: const Icon(
//                             Icons.play_arrow_rounded,
//                             size: 45,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           'START',
//                           style: TextStyle(
//                             color: Colors.grey[400],
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// update: when play button pressed, check if the MeditationExercise is the same as
// todays Meditaiton task routine, mark as complete if it is
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/views/meditation_play_screen.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';

class MeditationDetailScreen extends StatelessWidget {
  final MeditationExercise meditation;
  final VoidCallback onComplete;

  const MeditationDetailScreen({
    required this.meditation,
    required this.onComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Top Image
          Container(
            height: 335, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(meditation.imagePath),
                fit: BoxFit.cover,
                alignment:
                    Alignment.center, // Align the image to the right side
              ),
            ),
          ),
          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo[800],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meditation.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${meditation.duration ~/ 60} min', // Duration text
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        meditation.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            onComplete();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeditationPlayScreen(
                                  meditation: meditation,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(14), // Button color
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'START',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
