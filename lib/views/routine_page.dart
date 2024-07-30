// // views/routine_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mental_wellness_app/widgets/routine_section.dart';
// import 'package:mental_wellness_app/controllers/routine_controller.dart';
// import 'package:mental_wellness_app/views/counselling_screen.dart';
// import 'package:mental_wellness_app/views/received_nudge_screen.dart';
// import 'package:mental_wellness_app/views/profile_screen.dart';

// class RoutinePage extends StatefulWidget {
//   const RoutinePage({super.key});

//   @override
//   _RoutinePageState createState() => _RoutinePageState();
// }

// class _RoutinePageState extends State<RoutinePage> {
//   final RoutineController routineController = Get.put(RoutineController());
//   final User? currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routineController.preloadImages(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: StreamBuilder<DocumentSnapshot>(
//           stream: routineController.getRoutineStream(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData && snapshot.data != null) {
//               routineController.updateTaskCards(snapshot.data!, context);
//             }

//             return GetBuilder<RoutineController>(
//               builder: (controller) {
//                 return Column(
//                   children: [
//                     // Daily Task Title + Profile Button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Text(
//                               'Routine',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             StreamBuilder<DocumentSnapshot>(
//                               stream: FirebaseFirestore.instance
//                                   .collection('Members')
//                                   .doc(currentUser?.uid)
//                                   .snapshots(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.hasData && snapshot.data != null) {
//                                   int dailyStreak =
//                                       snapshot.data!['dailyStreak'] ?? 0;
//                                   int level = snapshot.data!['level'] ?? 1;
//                                   return Row(
//                                     children: [
//                                       const SizedBox(width: 2),
//                                       const Icon(
//                                         Icons.whatshot,
//                                         color: Colors.orange,
//                                         size: 22,
//                                       ),
//                                       const SizedBox(width: 1),
//                                       Text(
//                                         '$dailyStreak',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(
//                                         'Lvl $level',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 } else {
//                                   return Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.whatshot,
//                                         color: Colors.orange,
//                                         size: 22,
//                                       ),
//                                       const SizedBox(width: 1),
//                                       const Text(
//                                         '0',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       const Text(
//                                         'Lvl 1',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             StreamBuilder<QuerySnapshot>(
//                               stream: FirebaseFirestore.instance
//                                   .collection('Members')
//                                   .doc(currentUser?.uid)
//                                   .collection('nudges')
//                                   .where('read', isEqualTo: false)
//                                   .snapshots(),
//                               builder: (context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 int unreadCount = 0;
//                                 if (snapshot.hasData) {
//                                   unreadCount = snapshot.data!.docs.length;
//                                 }

//                                 return Stack(
//                                   children: [
//                                     IconButton(
//                                       padding: EdgeInsets.all(0),
//                                       constraints: BoxConstraints(),
//                                       onPressed: () {
//                                         Get.to(() => ReceivedNudgesScreen());
//                                       },
//                                       icon: const Icon(
//                                         Icons.notifications,
//                                         color: Colors.white,
//                                         size: 22,
//                                       ),
//                                     ),
//                                     if (unreadCount > 0)
//                                       Positioned(
//                                         right: 4,
//                                         top: 4,
//                                         child: Container(
//                                           padding: EdgeInsets.all(0),
//                                           decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           constraints: BoxConstraints(
//                                             minWidth: 16,
//                                             minHeight: 16,
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               '$unreadCount',
//                                               style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 10,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 );
//                               },
//                             ),
//                             IconButton(
//                               padding: EdgeInsets.all(0),
//                               constraints: BoxConstraints(),
//                               onPressed: () {
//                                 Get.to(() => CounsellingScreen());
//                               },
//                               icon: const Icon(
//                                 Icons.headset_mic,
//                                 color: Colors.white,
//                                 size: 22,
//                               ),
//                             ),
//                             IconButton(
//                               padding: EdgeInsets.all(0),
//                               constraints: BoxConstraints(),
//                               onPressed: () {
//                                 Get.to(() => ProfileScreen());
//                               },
//                               icon: const Icon(
//                                 Icons.person,
//                                 color: Colors.white,
//                                 size: 22,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),

//                     Expanded(
//                       child: ListView(
//                         children: [
//                           RoutineSection(
//                             title: 'Morning',
//                             icon: Icons.sunny_snowing,
//                             tasks: routineController.taskCards
//                                 .where((task) => task.category == 'Breathe')
//                                 .toList(),
//                           ),
//                           RoutineSection(
//                             title: 'Day',
//                             icon: Icons.sunny,
//                             tasks: routineController.taskCards
//                                 .where((task) => task.category == 'Meditation')
//                                 .toList(),
//                           ),
//                           RoutineSection(
//                             title: 'Evening',
//                             icon: Icons.nights_stay,
//                             tasks: routineController.taskCards
//                                 .where((task) =>
//                                     task.category == 'Sleep Story' ||
//                                     task.category == 'Mood Tracker')
//                                 .toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// received nudges mark read
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_wellness_app/widgets/routine_section.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/controllers/routine_controller.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'package:mental_wellness_app/widgets/task_card.dart';
import 'package:mental_wellness_app/views/counselling_screen.dart';
import 'package:mental_wellness_app/views/received_nudge_screen.dart';
import 'package:mental_wellness_app/views/profile_screen.dart';
import 'package:mental_wellness_app/controllers/nudge_controller.dart'; // Import the NudgeController

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final RoutineController routineController = Get.put(RoutineController());
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final NudgeController nudgeController =
      Get.put(NudgeController()); // Initialize the NudgeController

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routineController.preloadImages(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: routineController.getRoutineStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              routineController.updateTaskCards(snapshot.data!, context);
            }

            return GetBuilder<RoutineController>(
              builder: (controller) {
                return Column(
                  children: [
                    // Daily Task Title + Profile Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Routine',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Members')
                                  .doc(currentUser?.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  int dailyStreak =
                                      snapshot.data!['dailyStreak'] ?? 0;
                                  int level = snapshot.data!['level'] ?? 1;
                                  return Row(
                                    children: [
                                      const SizedBox(width: 2),
                                      const Icon(
                                        Icons.whatshot,
                                        color: Colors.orange,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 1),
                                      Text(
                                        '$dailyStreak',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Lvl $level',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.whatshot,
                                        color: Colors.orange,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 1),
                                      const Text(
                                        '0',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Lvl 1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Members')
                                  .doc(currentUser?.uid)
                                  .collection('nudges')
                                  .where('read', isEqualTo: false)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                int unreadCount = 0;
                                if (snapshot.hasData) {
                                  unreadCount = snapshot.data!.docs.length;
                                }

                                return Stack(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      constraints: BoxConstraints(),
                                      onPressed: () async {
                                        nudgeController
                                            .markNudgesAsRead(); // Mark nudges as read
                                        Get.to(() => ReceivedNudgesScreen());
                                      },
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    if (unreadCount > 0)
                                      Positioned(
                                        right: 4,
                                        top: 4,
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 16,
                                            minHeight: 16,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$unreadCount',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints(),
                              onPressed: () {
                                Get.to(() => CounsellingScreen());
                              },
                              icon: const Icon(
                                Icons.headset_mic,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints(),
                              onPressed: () {
                                Get.to(() => ProfileScreen());
                              },
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView(
                        children: [
                          RoutineSection(
                            title: 'Morning',
                            icon: Icons.sunny_snowing,
                            tasks: routineController.taskCards
                                .where((task) => task.category == 'Breathe')
                                .toList(),
                          ),
                          RoutineSection(
                            title: 'Day',
                            icon: Icons.sunny,
                            tasks: routineController.taskCards
                                .where((task) => task.category == 'Meditation')
                                .toList(),
                          ),
                          RoutineSection(
                            title: 'Evening',
                            icon: Icons.nights_stay,
                            tasks: routineController.taskCards
                                .where((task) =>
                                    task.category == 'Sleep Story' ||
                                    task.category == 'Mood Tracker')
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
