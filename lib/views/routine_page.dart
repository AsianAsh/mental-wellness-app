// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
// import 'package:mental_wellness_app/views/profile_screen.dart';
// import 'package:get/get.dart';

// class RoutinePage extends StatefulWidget {
//   const RoutinePage({Key? key}) : super(key: key);

//   @override
//   _RoutinePageState createState() => _RoutinePageState();
// }

// class _RoutinePageState extends State<RoutinePage> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//   }

//   void _preloadImages() {
//     // List of image assets to preload
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(children: [
//           // Daily Task Title + Profile Button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Row(
//                 children: [
//                   Text(
//                     'Routine',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.whatshot,
//                         color: Colors.orange,
//                       ),
//                       SizedBox(width: 2),
//                       Text(
//                         '20',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Navigate to the ProfileScreen
//                   Get.to(ProfileScreen());
//                 },
//                 icon: const Icon(
//                   Icons.person,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(
//             height: 20,
//           ),

//           Expanded(
//             child: ListView(
//               children: [
//                 RoutineSection(
//                   title: 'Morning',
//                   icon: Icons.sunny_snowing,
//                   tasks: [
//                     TaskCard(
//                       icon: Icons.brightness_5,
//                       category: 'Breath',
//                       title: 'Irritation',
//                       description: '3 min meditation',
//                       image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                     ),
//                     // TaskCard(
//                     //   icon: Icons.article,
//                     //   category: 'Articles',
//                     //   title: '12 Habits of Happy Women',
//                     //   description: '2 min read',
//                     //   image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                     // ),
//                   ],
//                 ),
//                 RoutineSection(
//                   title: 'Day',
//                   icon: Icons.sunny,
//                   tasks: [
//                     // TaskCard(
//                     //   icon: Icons.school,
//                     //   category: 'Course',
//                     //   title: 'Anxiety',
//                     //   description: 'Create a sense of balance and peace',
//                     //   image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                     // ),
//                     TaskCard(
//                       icon: Icons.self_improvement,
//                       category: 'Meditation',
//                       title: 'Showering',
//                       description: '',
//                       image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                     ),
//                   ],
//                 ),
//                 RoutineSection(
//                   title: 'Evening',
//                   icon: Icons.nights_stay,
//                   tasks: [
//                     TaskCard(
//                       icon: Icons.nights_stay,
//                       category: 'Sleep Story',
//                       title: 'Calm Sleep',
//                       description: '5 min story',
//                       image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                     ),
//                     // TaskCard(
//                     //   icon: Icons.music_note,
//                     //   category: 'Sleep Sound',
//                     //   title: 'Ocean Waves',
//                     //   description: '10 min sound',
//                     //   image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                     // ),
//                     TaskCard(
//                       icon: Icons.sentiment_satisfied_alt,
//                       category: 'Mood Tracker',
//                       title: 'Mood Tracker',
//                       description: 'Track your mood',
//                       image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MoodTrackerScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class RoutineSection extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final List<TaskCard> tasks;

//   RoutineSection(
//       {required this.title, required this.icon, required this.tasks});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           children: tasks
//               .map((task) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(child: task),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class TaskCard extends StatefulWidget {
//   final IconData icon;
//   final String category;
//   final String title;
//   final String description;
//   final String image;
//   final VoidCallback? onTap; // Optional onTap callback

//   TaskCard({
//     required this.icon,
//     required this.category,
//     required this.title,
//     required this.description,
//     required this.image,
//     this.onTap,
//   });

//   @override
//   _TaskCardState createState() => _TaskCardState();
// }

// class _TaskCardState extends State<TaskCard> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap, // Handle tap
//       child: Row(
//         children: [
//           // Circular Checkbox
//           Checkbox(
//             value: isChecked,
//             onChanged: (bool? value) {
//               setState(() {
//                 isChecked = value ?? false;
//               });
//             },
//             shape: CircleBorder(), // Make the checkbox circular
//             checkColor: Colors.white,
//             activeColor: Colors.indigo[600], // Checkbox color when checked
//             materialTapTargetSize: MaterialTapTargetSize
//                 .shrinkWrap, // Remove extra padding around checkbox
//           ),
//           // Task Card
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(widget.icon, color: Colors.white, size: 22),
//                             const SizedBox(
//                                 width: 8), // Add spacing between icon and text
//                             Text(
//                               widget.category,
//                               style: TextStyle(
//                                 color: Colors.indigo[100],
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                             height:
//                                 10), // Add some spacing between category row and title
//                         Text(
//                           widget.title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           widget.description,
//                           style: TextStyle(
//                             color: Colors.blue[100],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                     child: Image.asset(
//                       widget.image,
//                       width: 80,
//                       height: 80,
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

// Verison 2: Get breathing exercise task of the day and dispay it as TaskCard widget
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
// import 'package:mental_wellness_app/views/profile_screen.dart';
// import 'package:get/get.dart';

// class RoutinePage extends StatefulWidget {
//   const RoutinePage({super.key});

//   @override
//   _RoutinePageState createState() => _RoutinePageState();
// }

// class _RoutinePageState extends State<RoutinePage> {
//   late Future<List<TaskCard>> taskCards;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//     taskCards = _fetchTasks();
//   }

//   void _preloadImages() {
//     // List of image assets to preload
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   Future<List<TaskCard>> _fetchTasks() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .get();

//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;

//       if (memberData['routine'] != null &&
//           memberData['routine']['tasks'] != null) {
//         List<dynamic> tasks = memberData['routine']['tasks'];
//         print('Fetched tasks: $tasks');
//         List<TaskCard> taskCards = [];

//         for (var task in tasks) {
//           String category = task['category'];
//           bool completed = task['completed'];
//           String? taskId = task['id']; // Use String? to allow null values

//           switch (category) {
//             case 'Breathe':
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('breathing_exercise')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.brightness_5,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//               ));
//               break;

//             case 'Mood Tracker':
//               taskCards.add(TaskCard(
//                 icon: Icons.sentiment_satisfied_alt,
//                 category: 'Mood Tracker',
//                 title: 'Mood Tracker',
//                 description: 'Track your mood',
//                 image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                 isCompleted: completed,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const MoodTrackerScreen(),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             case 'Meditation':
//               // Add logic for Meditation
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('meditation_exercise')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.self_improvement,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//               ));
//               break;

//             case 'Sleep Story':
//               // Add logic for Sleep Story
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('sleep_story')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.nights_stay,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//               ));
//               break;

//             default:
//               break;
//           }
//         }

//         return taskCards;
//       }
//     }
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Daily Task Title + Profile Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     Text(
//                       'Routine',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.whatshot,
//                           color: Colors.orange,
//                         ),
//                         SizedBox(width: 2),
//                         Text(
//                           '20',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Navigate to the ProfileScreen
//                     Get.to(ProfileScreen());
//                   },
//                   icon: const Icon(
//                     Icons.person,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(
//               height: 20,
//             ),

//             Expanded(
//               child: FutureBuilder<List<TaskCard>>(
//                 future: taskCards,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error loading tasks'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No tasks available'));
//                   } else {
//                     List<TaskCard> morningTasks = snapshot.data!
//                         .where((task) => task.category == 'Breathe')
//                         .toList();
//                     List<TaskCard> dayTasks = snapshot.data!
//                         .where((task) => task.category == 'Meditation')
//                         .toList();
//                     List<TaskCard> eveningTasks = snapshot.data!
//                         .where((task) =>
//                             task.category == 'Sleep Story' ||
//                             task.category == 'Mood Tracker')
//                         .toList();

//                     return ListView(
//                       children: [
//                         RoutineSection(
//                           title: 'Morning',
//                           icon: Icons.sunny_snowing,
//                           tasks: morningTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Day',
//                           icon: Icons.sunny,
//                           tasks: dayTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Evening',
//                           icon: Icons.nights_stay,
//                           tasks: eveningTasks,
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoutineSection extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final List<TaskCard> tasks;

//   RoutineSection(
//       {required this.title, required this.icon, required this.tasks});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           children: tasks
//               .map((task) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(child: task),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class TaskCard extends StatefulWidget {
//   final IconData icon;
//   final String category;
//   final String title;
//   final String description;
//   final String image;
//   final bool isCompleted;
//   final VoidCallback? onTap; // Optional onTap callback

//   TaskCard({
//     required this.icon,
//     required this.category,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.isCompleted,
//     this.onTap,
//   });

//   @override
//   _TaskCardState createState() => _TaskCardState();
// }

// class _TaskCardState extends State<TaskCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap, // Handle tap
//       child: Row(
//         children: [
//           // Circular Checkbox
//           Checkbox(
//             value: widget.isCompleted,
//             onChanged: null, // Disable checkbox interaction
//             shape: CircleBorder(), // Make the checkbox circular
//             checkColor: Colors.white,
//             activeColor: Colors.indigo[600], // Checkbox color when checked
//             materialTapTargetSize: MaterialTapTargetSize
//                 .shrinkWrap, // Remove extra padding around checkbox
//           ),
//           // Task Card
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(widget.icon, color: Colors.white, size: 22),
//                             const SizedBox(
//                                 width: 8), // Add spacing between icon and text
//                             Text(
//                               widget.category,
//                               style: TextStyle(
//                                 color: Colors.indigo[100],
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                             height:
//                                 10), // Add some spacing between category row and title
//                         Text(
//                           widget.title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           widget.description,
//                           style: TextStyle(
//                             color: Colors.blue[100],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                     child: Image.asset(
//                       widget.image,
//                       width: 80,
//                       height: 80,
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

// TaskCard widget (Breathe and Meditation) can navigate to BreathPlayScreen
// result: works
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/views/breathing_play_screen.dart';
// import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
// import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
// import 'package:mental_wellness_app/views/profile_screen.dart';
// import 'package:get/get.dart';

// class RoutinePage extends StatefulWidget {
//   const RoutinePage({super.key});

//   @override
//   _RoutinePageState createState() => _RoutinePageState();
// }

// class _RoutinePageState extends State<RoutinePage> {
//   late Future<List<TaskCard>> taskCards;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//     taskCards = _fetchTasks();
//   }

//   void _preloadImages() {
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   Future<List<TaskCard>> _fetchTasks() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .get();

//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;

//       if (memberData['routine'] != null &&
//           memberData['routine']['tasks'] != null) {
//         List<dynamic> tasks = memberData['routine']['tasks'];
//         List<TaskCard> taskCards = [];

//         for (var task in tasks) {
//           String category = task['category'];
//           bool completed = task['completed'];
//           String? taskId = task['id'];

//           switch (category) {
//             case 'Breathe':
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('breathing_exercise')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               BreathingExercise exercise = BreathingExercise(
//                 title: taskData['title'],
//                 duration: taskData['duration'],
//                 imagePath: taskData['imagePath'],
//                 audioPath: taskData['audioPath'],
//               );

//               taskCards.add(TaskCard(
//                 icon: Icons.brightness_5,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BreathingPlayScreen(exercise: exercise),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             case 'Mood Tracker':
//               taskCards.add(TaskCard(
//                 icon: Icons.sentiment_satisfied_alt,
//                 category: 'Mood Tracker',
//                 title: 'Mood Tracker',
//                 description: 'Track your mood',
//                 image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                 isCompleted: completed,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const MoodTrackerScreen(),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             case 'Meditation':
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('meditation_exercise')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.self_improvement,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MeditationDetailScreen(
//                         meditation: MeditationExercise.fromMap(taskData),
//                       ),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             case 'Sleep Story':
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('sleep_story')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.nights_stay,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//               ));
//               break;

//             default:
//               break;
//           }
//         }

//         return taskCards;
//       }
//     }
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Daily Task Title + Profile Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     Text(
//                       'Routine',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.whatshot,
//                           color: Colors.orange,
//                         ),
//                         SizedBox(width: 2),
//                         Text(
//                           '20',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Get.to(ProfileScreen());
//                   },
//                   icon: const Icon(
//                     Icons.person,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: FutureBuilder<List<TaskCard>>(
//                 future: taskCards,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return const Center(child: Text('Error loading tasks'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('No tasks available'));
//                   } else {
//                     List<TaskCard> morningTasks = snapshot.data!
//                         .where((task) => task.category == 'Breathe')
//                         .toList();
//                     List<TaskCard> dayTasks = snapshot.data!
//                         .where((task) => task.category == 'Meditation')
//                         .toList();
//                     List<TaskCard> eveningTasks = snapshot.data!
//                         .where((task) =>
//                             task.category == 'Sleep Story' ||
//                             task.category == 'Mood Tracker')
//                         .toList();

//                     return ListView(
//                       children: [
//                         RoutineSection(
//                           title: 'Morning',
//                           icon: Icons.sunny_snowing,
//                           tasks: morningTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Day',
//                           icon: Icons.sunny,
//                           tasks: dayTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Evening',
//                           icon: Icons.nights_stay,
//                           tasks: eveningTasks,
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoutineSection extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final List<TaskCard> tasks;

//   RoutineSection(
//       {required this.title, required this.icon, required this.tasks});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             const SizedBox(width: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           children: tasks
//               .map((task) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(child: task),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class TaskCard extends StatelessWidget {
//   final IconData icon;
//   final String category;
//   final String title;
//   final String description;
//   final String image;
//   final bool isCompleted;
//   final VoidCallback? onTap;

//   TaskCard({
//     required this.icon,
//     required this.category,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.isCompleted,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Checkbox(
//             value: isCompleted,
//             onChanged: null,
//             shape: const CircleBorder(),
//             checkColor: Colors.white,
//             activeColor: Colors.indigo[600],
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(icon, color: Colors.white, size: 22),
//                             const SizedBox(width: 8),
//                             Text(
//                               category,
//                               style: TextStyle(
//                                 color: Colors.indigo[100],
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           description,
//                           style: TextStyle(
//                             color: Colors.blue[100],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                     child: Image.asset(
//                       image,
//                       width: 80,
//                       height: 80,
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

// TaskCard Widget (Sleep Story) naviagtes to SleepScreen and play audio on persistent audio player
// routine_page.dart
// routine_page.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/home_page.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/views/breathing_play_screen.dart';
// import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
// import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
// import 'package:mental_wellness_app/views/profile_screen.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class RoutinePage extends StatefulWidget {
//   const RoutinePage({super.key});

//   @override
//   _RoutinePageState createState() => _RoutinePageState();
// }

// class _RoutinePageState extends State<RoutinePage> {
//   late Future<List<TaskCard>> taskCards;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//     taskCards = _fetchTasks();
//   }

//   void _preloadImages() {
//     // List of image assets to preload
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   Future<List<TaskCard>> _fetchTasks() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .get();

//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;

//       if (memberData['routine'] != null &&
//           memberData['routine']['tasks'] != null) {
//         List<dynamic> tasks = memberData['routine']['tasks'];
//         print('Fetched tasks: $tasks');
//         List<TaskCard> taskCards = [];

//         for (var task in tasks) {
//           String category = task['category'];
//           bool completed = task['completed'];
//           String? taskId = task['id']; // Use String? to allow null values

//           switch (category) {
//             // case 'Breathe':
//             //   DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//             //       .collection('breathing_exercise')
//             //       .doc(taskId)
//             //       .get();

//             //   Map<String, dynamic> taskData =
//             //       taskDoc.data() as Map<String, dynamic>;

//             //   taskCards.add(TaskCard(
//             //     icon: Icons.brightness_5,
//             //     category: category,
//             //     title: taskData['title'],
//             //     description: '${taskData['duration']} min',
//             //     image: taskData['imagePath'],
//             //     isCompleted: completed,
//             //     onTap: () {
//             //       // Navigate to BreathingPlayScreen with the exercise details
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (context) => BreathingPlayScreen(
//             //             exercise: BreathingExercise.fromMap(taskData),
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   ));
//             //   break;

//             // with doc id for completion verification
//             // case 'Breathe':
//             //   DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//             //       .collection('breathing_exercise')
//             //       .doc(taskId)
//             //       .get();

//             //   Map<String, dynamic> taskData =
//             //       taskDoc.data() as Map<String, dynamic>;

//             //   taskCards.add(TaskCard(
//             //     icon: Icons.brightness_5,
//             //     category: category,
//             //     title: taskData['title'],
//             //     description: '${taskData['duration']} min',
//             //     image: taskData['imagePath'],
//             //     isCompleted: completed,
//             //     onTap: () {
//             //       if (!completed) {
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //             builder: (context) => BreathingPlayScreen(
//             //               exercise:
//             //                   BreathingExercise.fromMap(taskData, taskId!),
//             //             ),
//             //           ),
//             //         ).then((_) {
//             //           setState(() {
//             //             taskCards = _fetchTasks() as List<TaskCard>;
//             //           });
//             //         });
//             //       }
//             //     },
//             //   ));
//             //   break;

//             case 'Mood Tracker':
//               taskCards.add(TaskCard(
//                 icon: Icons.sentiment_satisfied_alt,
//                 category: 'Mood Tracker',
//                 title: 'Mood Tracker',
//                 description: 'Track your mood',
//                 image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                 isCompleted: completed,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const MoodTrackerScreen(),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             case 'Meditation':
//               // Add logic for Meditation
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('meditation_exercise')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.self_improvement,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MeditationDetailScreen(
//                         meditation: MeditationExercise.fromMap(taskData),
//                       ),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             case 'Sleep Story':
//               // Add logic for Sleep Story
//               DocumentSnapshot taskDoc = await FirebaseFirestore.instance
//                   .collection('sleep_story')
//                   .doc(taskId)
//                   .get();

//               Map<String, dynamic> taskData =
//                   taskDoc.data() as Map<String, dynamic>;

//               taskCards.add(TaskCard(
//                 icon: Icons.nights_stay,
//                 category: category,
//                 title: taskData['title'],
//                 description: '${taskData['duration']} min',
//                 image: taskData['imagePath'],
//                 isCompleted: completed,
//                 onTap: () {
//                   final audioPlayerState =
//                       Provider.of<AudioPlayerState>(context, listen: false);
//                   // Navigate to SleepScreen by changing the currentIndex
//                   HomePage.of(context)
//                       ?.navigateToPage(2); // Index for SleepScreen
//                   // Play the sleep story audio
//                   audioPlayerState.playAudio(taskData['audioPath']);
//                   audioPlayerState.setCurrentAudioTitle(taskData['title']);
//                 },
//               ));
//               break;

//             default:
//               break;
//           }
//         }

//         return taskCards;
//       }
//     }
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Daily Task Title + Profile Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     Text(
//                       'Routine',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.whatshot,
//                           color: Colors.orange,
//                         ),
//                         SizedBox(width: 2),
//                         Text(
//                           '20',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Navigate to the ProfileScreen
//                     Get.to(ProfileScreen());
//                   },
//                   icon: const Icon(
//                     Icons.person,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(
//               height: 20,
//             ),

//             Expanded(
//               child: FutureBuilder<List<TaskCard>>(
//                 future: taskCards,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error loading tasks'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No tasks available'));
//                   } else {
//                     List<TaskCard> morningTasks = snapshot.data!
//                         .where((task) => task.category == 'Breathe')
//                         .toList();
//                     List<TaskCard> dayTasks = snapshot.data!
//                         .where((task) => task.category == 'Meditation')
//                         .toList();
//                     List<TaskCard> eveningTasks = snapshot.data!
//                         .where((task) =>
//                             task.category == 'Sleep Story' ||
//                             task.category == 'Mood Tracker')
//                         .toList();

//                     return ListView(
//                       children: [
//                         RoutineSection(
//                           title: 'Morning',
//                           icon: Icons.sunny_snowing,
//                           tasks: morningTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Day',
//                           icon: Icons.sunny,
//                           tasks: dayTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Evening',
//                           icon: Icons.nights_stay,
//                           tasks: eveningTasks,
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoutineSection extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final List<TaskCard> tasks;

//   RoutineSection(
//       {required this.title, required this.icon, required this.tasks});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           children: tasks
//               .map((task) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(child: task),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// // class TaskCard extends StatefulWidget {
// //   final IconData icon;
// //   final String category;
// //   final String title;
// //   final String description;
// //   final String image;
// //   final bool isCompleted;
// //   final VoidCallback? onTap; // Optional onTap callback

// //   TaskCard({
// //     required this.icon,
// //     required this.category,
// //     required this.title,
// //     required this.description,
// //     required this.image,
// //     required this.isCompleted,
// //     this.onTap,
// //   });

// //   @override
// //   _TaskCardState createState() => _TaskCardState();
// // }

// // class _TaskCardState extends State<TaskCard> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: widget.onTap, // Handle tap
// //       child: Row(
// //         children: [
// //           // Circular Checkbox
// //           Checkbox(
// //             value: widget.isCompleted,
// //             onChanged: null, // Disable checkbox interaction
// //             shape: const CircleBorder(), // Make the checkbox circular
// //             checkColor: Colors.white,
// //             activeColor: Colors.indigo[600], // Checkbox color when checked
// //             materialTapTargetSize: MaterialTapTargetSize
// //                 .shrinkWrap, // Remove extra padding around checkbox
// //           ),
// //           // Task Card
// //           Expanded(
// //             child: Container(
// //               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
// //               decoration: BoxDecoration(
// //                 color: Colors.indigo[600],
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Row(
// //                           children: [
// //                             Icon(widget.icon, color: Colors.white, size: 22),
// //                             const SizedBox(
// //                                 width: 8), // Add spacing between icon and text
// //                             Text(
// //                               widget.category,
// //                               style: TextStyle(
// //                                 color: Colors.indigo[100],
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(
// //                             height:
// //                                 10), // Add some spacing between category row and title
// //                         Text(
// //                           widget.title,
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           widget.description,
// //                           style: TextStyle(
// //                             color: Colors.blue[100],
// //                             fontSize: 12,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
// //                     child: Image.asset(
// //                       widget.image,
// //                       width: 80,
// //                       height: 80,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// //TaskCard update to mark task as complete (Breathe)
// // class TaskCard extends StatefulWidget {
// //   final IconData icon;
// //   final String category;
// //   final String title;
// //   final String description;
// //   final String image;
// //   bool isCompleted;
// //   final VoidCallback? onTap; // Optional onTap callback

// //   TaskCard({
// //     required this.icon,
// //     required this.category,
// //     required this.title,
// //     required this.description,
// //     required this.image,
// //     required this.isCompleted,
// //     this.onTap,
// //   });

// //   @override
// //   _TaskCardState createState() => _TaskCardState();
// // }

// // class _TaskCardState extends State<TaskCard> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap:
// //           widget.isCompleted ? null : widget.onTap, // Disable tap if completed
// //       child: Row(
// //         children: [
// //           // Circular Checkbox
// //           Checkbox(
// //             value: widget.isCompleted,
// //             onChanged: (bool? value) {
// //               // Disable checkbox interaction
// //             },
// //             shape: CircleBorder(), // Make the checkbox circular
// //             checkColor: Colors.white,
// //             activeColor: Colors.indigo[600], // Checkbox color when checked
// //             materialTapTargetSize: MaterialTapTargetSize
// //                 .shrinkWrap, // Remove extra padding around checkbox
// //           ),
// //           // Task Card
// //           Expanded(
// //             child: Container(
// //               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
// //               decoration: BoxDecoration(
// //                 color: widget.isCompleted ? Colors.grey : Colors.indigo[600],
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Row(
// //                           children: [
// //                             Icon(widget.icon, color: Colors.white, size: 22),
// //                             const SizedBox(
// //                                 width: 8), // Add spacing between icon and text
// //                             Text(
// //                               widget.category,
// //                               style: TextStyle(
// //                                 color: Colors.indigo[100],
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(
// //                             height:
// //                                 10), // Add some spacing between category row and title
// //                         Text(
// //                           widget.title,
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           widget.description,
// //                           style: TextStyle(
// //                             color: Colors.blue[100],
// //                             fontSize: 12,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
// //                     child: Image.asset(
// //                       widget.image,
// //                       width: 80,
// //                       height: 80,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // immediately check taskcard when completed is true
// class TaskCard extends StatefulWidget {
//   final IconData icon;
//   final String category;
//   final String title;
//   final String description;
//   final String image;
//   final ValueNotifier<bool> isCompleted; // Use ValueNotifier
//   final VoidCallback? onTap;

//   TaskCard({
//     required this.icon,
//     required this.category,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.isCompleted,
//     this.onTap,
//   });

//   @override
//   _TaskCardState createState() => _TaskCardState();
// }

// class _TaskCardState extends State<TaskCard> {
//   @override
//   void initState() {
//     super.initState();
//     widget.isCompleted.addListener(_onCompletionChanged);
//   }

//   @override
//   void dispose() {
//     widget.isCompleted.removeListener(_onCompletionChanged);
//     super.dispose();
//   }

//   void _onCompletionChanged() {
//     setState(() {}); // Trigger rebuild when completion status changes
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Row(
//         children: [
//           Checkbox(
//             value: widget.isCompleted.value,
//             onChanged: null, // Disable checkbox interaction
//             shape: CircleBorder(),
//             checkColor: Colors.white,
//             activeColor: Colors.indigo[600],
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(widget.icon, color: Colors.white, size: 22),
//                             const SizedBox(width: 8),
//                             Text(
//                               widget.category,
//                               style: TextStyle(
//                                 color: Colors.indigo[100],
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           widget.title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           widget.description,
//                           style: TextStyle(
//                             color: Colors.blue[100],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                     child: Image.asset(
//                       widget.image,
//                       width: 80,
//                       height: 80,
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

//immediately check taskcard when completed is true
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';
// import 'package:mental_wellness_app/controllers/meditation_exercise_controller.dart';
// import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
// import 'package:mental_wellness_app/home_page.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/models/sleep_story.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
// import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
// import 'package:mental_wellness_app/views/profile_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'breathing_play_screen.dart';

// class RoutinePage extends StatefulWidget {
//   const RoutinePage({super.key});

//   @override
//   _RoutinePageState createState() => _RoutinePageState();
// }

// class _RoutinePageState extends State<RoutinePage> {
//   late Future<List<TaskCard>> taskCards;
//   final MeditationExerciseController meditationController =
//       Get.put(MeditationExerciseController());
//   final BreathingExerciseController breathingExerciseController =
//       Get.put(BreathingExerciseController());
//   final SleepStoryController sleepStoryController =
//       Get.put(SleepStoryController());
//   final ValueNotifier<bool> isCompletedNotifier = ValueNotifier(false);

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//     taskCards = _fetchTasks();
//   }

//   void _preloadImages() {
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   Future<List<TaskCard>> _fetchTasks() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .get();

//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;

//       if (memberData['routine'] != null &&
//           memberData['routine']['tasks'] != null) {
//         List<dynamic> tasks = memberData['routine']['tasks'];
//         List<TaskCard> taskCards = [];

//         for (var task in tasks) {
//           String category = task['category'];
//           bool completed = task['completed'];
//           String? taskId = task['id'];
//           ValueNotifier<bool> isCompletedNotifier = ValueNotifier(completed);

//           switch (category) {
//             case 'Breathe':
//               BreathingExercise? breathingExercise =
//                   await breathingExerciseController
//                       .getBreathingExerciseById(taskId!);

//               if (breathingExercise != null) {
//                 taskCards.add(TaskCard(
//                   icon: Icons.brightness_5,
//                   category: category,
//                   title: breathingExercise.title,
//                   description: '${breathingExercise.duration} min',
//                   image: breathingExercise.imagePath,
//                   isCompleted: ValueNotifier(completed),
//                   onTap: () {
//                     if (!completed) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BreathingPlayScreen(
//                             exercise: breathingExercise,
//                             onComplete: () async {
//                               await FirestoreService().updateTaskCompletion(
//                                   taskId, 'Breathe', true);
//                               isCompletedNotifier.value = true;
//                             },
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ));
//               }
//               break;

//             // Maintain consistency in fetching data only through controller
//             case 'Meditation':
//               MeditationExercise? meditationExercise =
//                   await meditationController.getMeditationExerciseById(taskId!);

//               if (meditationExercise != null) {
//                 taskCards.add(TaskCard(
//                   icon: Icons.self_improvement,
//                   category: category,
//                   title: meditationExercise.title,
//                   description: '${meditationExercise.duration} min',
//                   image: meditationExercise.imagePath,
//                   isCompleted: ValueNotifier(completed),
//                   onTap: () {
//                     if (!completed) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MeditationDetailScreen(
//                             meditation: meditationExercise,
//                             onComplete: () async {
//                               await FirestoreService().updateTaskCompletion(
//                                   taskId, 'Meditation', true);
//                               isCompletedNotifier.value = true;
//                             },
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ));
//               }
//               break;

//             case 'Sleep Story':
//               SleepStory? sleepStory =
//                   await sleepStoryController.getSleepStoryById(taskId!);

//               if (sleepStory != null) {
//                 taskCards.add(TaskCard(
//                   icon: Icons.nights_stay,
//                   category: category,
//                   title: sleepStory.title,
//                   description: '${sleepStory.duration} min',
//                   image: sleepStory.imagePath,
//                   isCompleted: isCompletedNotifier,
//                   onTap: () {
//                     if (!isCompletedNotifier.value) {
//                       final audioPlayerState =
//                           Provider.of<AudioPlayerState>(context, listen: false);
//                       HomePage.of(context)?.navigateToPage(2);
//                       audioPlayerState.playAudio(sleepStory.audioPath);
//                       audioPlayerState.setCurrentAudioTitle(sleepStory.title);

//                       FirestoreService()
//                           .updateTaskCompletion(taskId, 'Sleep Story', true);
//                       isCompletedNotifier.value = true;
//                     }
//                   },
//                 ));
//               }
//               break;

//             case 'Mood Tracker':
//               taskCards.add(TaskCard(
//                 icon: Icons.sentiment_satisfied_alt,
//                 category: 'Mood Tracker',
//                 title: 'Mood Tracker',
//                 description: 'Track your mood',
//                 image: 'assets/images/relaxing/relaxing_sounds_1.png',
//                 isCompleted: isCompletedNotifier,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const MoodTrackerScreen(),
//                     ),
//                   );
//                 },
//               ));
//               break;

//             default:
//               break;
//           }
//         }

//         return taskCards;
//       }
//     }
//     return [];
//   }

//   // Future<void> _markTaskAsCompleted(String taskId, String category) async {
//   //   await FirestoreService().updateTaskCompletion(taskId, category, true);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Daily Task Title + Profile Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     Text(
//                       'Routine',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.whatshot,
//                           color: Colors.orange,
//                         ),
//                         SizedBox(width: 2),
//                         Text(
//                           '20',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Get.to(ProfileScreen());
//                   },
//                   icon: const Icon(
//                     Icons.person,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(
//               height: 20,
//             ),

//             Expanded(
//               child: FutureBuilder<List<TaskCard>>(
//                 future: taskCards,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error loading tasks'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No tasks available'));
//                   } else {
//                     List<TaskCard> morningTasks = snapshot.data!
//                         .where((task) => task.category == 'Breathe')
//                         .toList();
//                     List<TaskCard> dayTasks = snapshot.data!
//                         .where((task) => task.category == 'Meditation')
//                         .toList();
//                     List<TaskCard> eveningTasks = snapshot.data!
//                         .where((task) =>
//                             task.category == 'Sleep Story' ||
//                             task.category == 'Mood Tracker')
//                         .toList();

//                     return ListView(
//                       children: [
//                         RoutineSection(
//                           title: 'Morning',
//                           icon: Icons.sunny_snowing,
//                           tasks: morningTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Day',
//                           icon: Icons.sunny,
//                           tasks: dayTasks,
//                         ),
//                         RoutineSection(
//                           title: 'Evening',
//                           icon: Icons.nights_stay,
//                           tasks: eveningTasks,
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoutineSection extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final List<TaskCard> tasks;

//   RoutineSection(
//       {required this.title, required this.icon, required this.tasks});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           children: tasks
//               .map((task) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(child: task),
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class TaskCard extends StatefulWidget {
//   final IconData icon;
//   final String category;
//   final String title;
//   final String description;
//   final String image;
//   final ValueNotifier<bool> isCompleted;
//   final VoidCallback? onTap;

//   TaskCard({
//     required this.icon,
//     required this.category,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.isCompleted,
//     this.onTap,
//   });

//   @override
//   _TaskCardState createState() => _TaskCardState();
// }

// class _TaskCardState extends State<TaskCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Row(
//         children: [
//           ValueListenableBuilder<bool>(
//             valueListenable: widget.isCompleted,
//             builder: (context, isCompleted, child) {
//               return Checkbox(
//                 value: isCompleted,
//                 onChanged: null,
//                 shape: CircleBorder(),
//                 checkColor: Colors.white,
//                 activeColor: Colors.indigo[600],
//                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               );
//             },
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(widget.icon, color: Colors.white, size: 22),
//                             const SizedBox(width: 8),
//                             Text(
//                               widget.category,
//                               style: TextStyle(
//                                 color: Colors.indigo[100],
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           widget.title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           widget.description,
//                           style: TextStyle(
//                             color: Colors.blue[100],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                     child: Image.asset(
//                       widget.image,
//                       width: 80,
//                       height: 80,
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

// imediately checks Breathe and Meditation TaskCards on completion
// previously had ot hot restart for changes to be viewable (sleep story worked fine though)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/meditation_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
import 'package:mental_wellness_app/home_page.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
import 'package:mental_wellness_app/views/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'breathing_play_screen.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  late Future<List<TaskCard>> taskCards;
  final MeditationExerciseController meditationController =
      Get.put(MeditationExerciseController());
  final BreathingExerciseController breathingExerciseController =
      Get.put(BreathingExerciseController());
  final SleepStoryController sleepStoryController =
      Get.put(SleepStoryController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
    taskCards = _fetchTasks();
  }

  void _preloadImages() {
    const List<String> imageAssets = [
      'assets/images/relaxing/relaxing_sounds_1.png',
    ];

    for (String imagePath in imageAssets) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  Future<List<TaskCard>> _fetchTasks() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .get();

      Map<String, dynamic> memberData =
          memberSnapshot.data() as Map<String, dynamic>;

      if (memberData['routine'] != null &&
          memberData['routine']['tasks'] != null) {
        List<dynamic> tasks = memberData['routine']['tasks'];
        List<TaskCard> taskCards = [];

        for (var task in tasks) {
          String category = task['category'];
          bool completed = task['completed'];
          String? taskId = task['id'];
          ValueNotifier<bool> isCompletedNotifier = ValueNotifier(completed);

          switch (category) {
            case 'Breathe':
              BreathingExercise? breathingExercise =
                  await breathingExerciseController
                      .getBreathingExerciseById(taskId!);

              if (breathingExercise != null) {
                taskCards.add(TaskCard(
                  icon: Icons.brightness_5,
                  category: category,
                  title: breathingExercise.title,
                  description: '${breathingExercise.duration} min',
                  image: breathingExercise.imagePath,
                  isCompleted: isCompletedNotifier,
                  onTap: () {
                    if (!isCompletedNotifier.value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BreathingPlayScreen(
                            exercise: breathingExercise,
                            onComplete: () async {
                              await FirestoreService().updateTaskCompletion(
                                  taskId, 'Breathe', true);
                              isCompletedNotifier.value = true;
                            },
                          ),
                        ),
                      );
                    }
                  },
                ));
              }
              break;

            case 'Meditation':
              MeditationExercise? meditationExercise =
                  await meditationController.getMeditationExerciseById(taskId!);

              if (meditationExercise != null) {
                taskCards.add(TaskCard(
                  icon: Icons.self_improvement,
                  category: category,
                  title: meditationExercise.title,
                  description: '${meditationExercise.duration} min',
                  image: meditationExercise.imagePath,
                  isCompleted: isCompletedNotifier,
                  onTap: () {
                    if (!isCompletedNotifier.value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeditationDetailScreen(
                            meditation: meditationExercise,
                            onComplete: () async {
                              await FirestoreService().updateTaskCompletion(
                                  taskId, 'Meditation', true);
                              isCompletedNotifier.value = true;
                            },
                          ),
                        ),
                      );
                    }
                  },
                ));
              }
              break;

            case 'Sleep Story':
              SleepStory? sleepStory =
                  await sleepStoryController.getSleepStoryById(taskId!);

              if (sleepStory != null) {
                taskCards.add(TaskCard(
                  icon: Icons.nights_stay,
                  category: category,
                  title: sleepStory.title,
                  description: '${sleepStory.duration} min',
                  image: sleepStory.imagePath,
                  isCompleted: isCompletedNotifier,
                  onTap: () {
                    if (!isCompletedNotifier.value) {
                      final audioPlayerState =
                          Provider.of<AudioPlayerState>(context, listen: false);
                      HomePage.of(context)?.navigateToPage(2);
                      audioPlayerState.playAudio(sleepStory.audioPath);
                      audioPlayerState.setCurrentAudioTitle(sleepStory.title);

                      FirestoreService()
                          .updateTaskCompletion(taskId, 'Sleep Story', true);
                      isCompletedNotifier.value = true;
                    }
                  },
                ));
              }
              break;

            case 'Mood Tracker':
              taskCards.add(TaskCard(
                icon: Icons.sentiment_satisfied_alt,
                category: 'Mood Tracker',
                title: 'Mood Tracker',
                description: 'Track your mood',
                image: 'assets/images/relaxing/relaxing_sounds_1.png',
                isCompleted: isCompletedNotifier,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MoodTrackerScreen(),
                    ),
                  );
                },
              ));
              break;

            default:
              break;
          }
        }

        return taskCards;
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Daily Task Title + Profile Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'Routine',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.whatshot,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 2),
                        Text(
                          '20',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Get.to(ProfileScreen());
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: FutureBuilder<List<TaskCard>>(
                future: taskCards,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading tasks'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No tasks available'));
                  } else {
                    List<TaskCard> morningTasks = snapshot.data!
                        .where((task) => task.category == 'Breathe')
                        .toList();
                    List<TaskCard> dayTasks = snapshot.data!
                        .where((task) => task.category == 'Meditation')
                        .toList();
                    List<TaskCard> eveningTasks = snapshot.data!
                        .where((task) =>
                            task.category == 'Sleep Story' ||
                            task.category == 'Mood Tracker')
                        .toList();

                    return ListView(
                      children: [
                        RoutineSection(
                          title: 'Morning',
                          icon: Icons.sunny_snowing,
                          tasks: morningTasks,
                        ),
                        RoutineSection(
                          title: 'Day',
                          icon: Icons.sunny,
                          tasks: dayTasks,
                        ),
                        RoutineSection(
                          title: 'Evening',
                          icon: Icons.nights_stay,
                          tasks: eveningTasks,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<TaskCard> tasks;

  RoutineSection(
      {required this.title, required this.icon, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: tasks
              .map((task) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: task),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class TaskCard extends StatefulWidget {
  final IconData icon;
  final String category;
  final String title;
  final String description;
  final String image;
  final ValueNotifier<bool> isCompleted;
  final VoidCallback? onTap;

  TaskCard({
    required this.icon,
    required this.category,
    required this.title,
    required this.description,
    required this.image,
    required this.isCompleted,
    this.onTap,
  });

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: widget.isCompleted,
            builder: (context, isCompleted, child) {
              return Checkbox(
                value: isCompleted,
                onChanged: null,
                shape: CircleBorder(),
                checkColor: Colors.white,
                activeColor: Colors.indigo[600],
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(widget.icon, color: Colors.white, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              widget.category,
                              style: TextStyle(
                                color: Colors.indigo[100],
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.blue[100],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                    child: Image.asset(
                      widget.image,
                      width: 80,
                      height: 80,
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
