// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:mental_wellness_app/views/relaxing_sounds.dart';
// import 'package:mental_wellness_app/views/sleep_screen.dart';
// import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
// import 'package:provider/provider.dart';
// import 'views/routine_page.dart';
// import 'views/meditation_page.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     RoutinePage(),
//     MeditationPage(),
//     SleepScreen(),
//     RelaxingSoundsScreen(),
//   ];

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

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AudioPlayerState(),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             IndexedStack(
//               index: _currentIndex,
//               children: _pages,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: PersistentAudioPlayer(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type:
//               BottomNavigationBarType.fixed, // Allows more than 3 navbar items
//           currentIndex: _currentIndex,
//           onTap: _onItemTapped,
//           backgroundColor:
//               Colors.indigo[600], // Set the background color to indigo
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.self_improvement), label: 'Meditation'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//           ],
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white38,
//         ),
//         // body: IndexedStack(
//         //   index: _currentIndex,
//         //   children: _pages,
//         // ),
//       ),
//     );
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Stack(
//   //       children: [
//   //         _pages[_currentIndex],
//   //         Align(
//   //           alignment: Alignment.bottomCenter,
//   //           child: PersistentAudioPlayer(),
//   //         ),
//   //       ],
//   //     ),
//   //     bottomNavigationBar: BottomNavigationBar(
//   //         currentIndex: _currentIndex,
//   //         onTap: (index) {
//   //           setState(() {
//   //             _currentIndex = index;
//   //           });
//   //         },
//   //         backgroundColor:
//   //             Colors.indigo[600], // Set the background color to indigo
//   //         items: [
//   //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//   //           BottomNavigationBarItem(
//   //               icon: Icon(Icons.self_improvement), label: 'Meditation'),
//   //           BottomNavigationBarItem(
//   //               icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//   //           BottomNavigationBarItem(
//   //               icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//   //         ],
//   //         selectedItemColor: Colors.white,
//   //         unselectedItemColor: Colors.white38),
//   //   );
//   // }
// }

// to allow Routine Taskcard widget onTap(Sleep Story) to navigate to SleepScreen and play audio
// result: works
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:mental_wellness_app/views/relaxing_sounds.dart';
// import 'package:mental_wellness_app/views/sleep_screen.dart';
// import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
// import 'package:provider/provider.dart';
// import 'views/routine_page.dart';
// import 'views/meditation_page.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   State<HomePage> createState() => _HomePageState();

//   static _HomePageState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_HomePageState>();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     RoutinePage(),
//     MeditationPage(),
//     SleepScreen(),
//     RelaxingSoundsScreen(),
//   ];

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

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void navigateToPage(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AudioPlayerState(),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             IndexedStack(
//               index: _currentIndex,
//               children: _pages,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: PersistentAudioPlayer(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type:
//               BottomNavigationBarType.fixed, // Allows more than 3 navbar items
//           currentIndex: _currentIndex,
//           onTap: _onItemTapped,
//           backgroundColor:
//               Colors.indigo[600], // Set the background color to indigo
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.self_improvement), label: 'Meditation'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//           ],
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white38,
//         ),
//       ),
//     );
//   }
// }

// make HomePage singleton
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:mental_wellness_app/views/relaxing_sounds.dart';
// import 'package:mental_wellness_app/views/sleep_screen.dart';
// import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
// import 'package:provider/provider.dart';
// import 'views/routine_page.dart';
// import 'views/meditation_page.dart';

// class HomePage extends StatefulWidget {
//   HomePage._privateConstructor();
//   static final HomePage _instance = HomePage._privateConstructor();
//   static HomePage get instance => _instance;

//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   State<HomePage> createState() => _HomePageState();

//   static _HomePageState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_HomePageState>();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     RoutinePage(),
//     MeditationPage(),
//     SleepScreen(),
//     RelaxingSoundsScreen(),
//   ];

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

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void navigateToPage(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AudioPlayerState(),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             IndexedStack(
//               index: _currentIndex,
//               children: _pages,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: PersistentAudioPlayer(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type:
//               BottomNavigationBarType.fixed, // Allows more than 3 navbar items
//           currentIndex: _currentIndex,
//           onTap: _onItemTapped,
//           backgroundColor:
//               Colors.indigo[600], // Set the background color to indigo
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.self_improvement), label: 'Meditation'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//           ],
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white38,
//         ),
//       ),
//     );
//   }
// }

// addded print statements to diagnose loading circle and daily routine issue
// home_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/meditation_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'package:mental_wellness_app/views/breathing_play_screen.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
import 'package:mental_wellness_app/views/relaxing_sounds.dart';
import 'package:mental_wellness_app/views/sleep_screen.dart';
import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
import 'package:provider/provider.dart';
import 'views/routine_page.dart';
import 'views/meditation_page.dart';

class HomePage extends StatefulWidget {
  HomePage._privateConstructor();
  static final HomePage _instance = HomePage._privateConstructor();
  static HomePage get instance => _instance;

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();

  static _HomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomePageState>();
}

class _HomePageState extends State<HomePage> {
  List<TaskCard> taskCards = [];
  final MeditationExerciseController meditationController =
      Get.put(MeditationExerciseController());
  final BreathingExerciseController breathingExerciseController =
      Get.put(BreathingExerciseController());
  final SleepStoryController sleepStoryController =
      Get.put(SleepStoryController());
  final FirestoreService firestoreService = FirestoreService();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    RoutinePage(),
    MeditationPage(),
    SleepScreen(),
    RelaxingSoundsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _updateTaskCards();
  }

  void _preloadImages() {
    // List of image assets to preload
    const List<String> imageAssets = [
      'assets/images/relaxing/relaxing_sounds_1.png',
    ];

    for (String imagePath in imageAssets) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  Future<void> _updateTaskCards() async {
    // print("Updating task cards");
    List<TaskCard> tasks = await _fetchTasks();
    setState(() {
      taskCards = tasks;
      // print("Task cards updated");
    });
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
                              await firestoreService.updateTaskCompletion(
                                  taskId, 'Breathe', true, context);
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
                              await firestoreService.updateTaskCompletion(
                                  taskId, 'Meditation', true, context);
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
                  onTap: () async {
                    if (!isCompletedNotifier.value) {
                      final audioPlayerState =
                          Provider.of<AudioPlayerState>(context, listen: false);
                      HomePage.of(context)?.navigateToPage(2);
                      audioPlayerState.playAudio(sleepStory.audioPath);
                      audioPlayerState.setCurrentAudioTitle(sleepStory.title);

                      await firestoreService.updateTaskCompletion(
                          taskId, 'Sleep Story', true, context);
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
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MoodTrackerScreen(),
                    ),
                  );
                  _updateTaskCards(); // Update task cards when returning from mood tracker screen
                  await firestoreService.updateMoodTrackerCompletion(
                      true, context);
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AudioPlayerState(),
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PersistentAudioPlayer(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type:
              BottomNavigationBarType.fixed, // Allows more than 3 navbar items
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor:
              Colors.indigo[600], // Set the background color to indigo
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.self_improvement), label: 'Meditation'),
            BottomNavigationBarItem(
                icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
        ),
      ),
    );
  }
}
