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
import 'package:mental_wellness_app/views/counselling_screen.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
import 'package:mental_wellness_app/views/nudge_screen.dart';
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
  List<TaskCard> taskCards = [];
  final MeditationExerciseController meditationController =
      Get.put(MeditationExerciseController());
  final BreathingExerciseController breathingExerciseController =
      Get.put(BreathingExerciseController());
  final SleepStoryController sleepStoryController =
      Get.put(SleepStoryController());
  final FirestoreService firestoreService = FirestoreService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
  }

  void _preloadImages() {
    const List<String> imageAssets = [
      'assets/images/relaxing/relaxing_sounds_1.png',
    ];

    for (String imagePath in imageAssets) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  String getDurationText(int durationInSeconds) {
    int minutes = (durationInSeconds / 60).ceil();
    return '$minutes min';
  }

  Future<List<TaskCard>> _fetchTasks(DocumentSnapshot memberSnapshot) async {
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
                description: getDurationText(breathingExercise.duration),
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
                description: getDurationText(meditationExercise.duration),
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
                description: getDurationText(sleepStory.duration),
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
                //_updateTaskCards(); // Update task cards when returning from mood tracker screen
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
    return [];
  }

  Future<void> _updateTaskCards(DocumentSnapshot memberSnapshot) async {
    // print("Updating task cards");
    List<TaskCard> tasks = await _fetchTasks(memberSnapshot);
    setState(() {
      taskCards = tasks;
      // print("Task cards updated");
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirestoreService().getRoutineStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _updateTaskCards(snapshot.data!);
            }

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
                        SizedBox(width: 5),
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
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.whatshot,
                                    color: Colors.orange,
                                    size: 22,
                                  ),
                                  SizedBox(width: 1),
                                  Text(
                                    '$dailyStreak',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Lvl $level',
                                    style: TextStyle(
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
                                  Icon(
                                    Icons.whatshot,
                                    color: Colors.orange,
                                    size: 22,
                                  ),
                                  SizedBox(width: 1),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
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
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            int unreadCount = 0;
                            if (snapshot.hasData) {
                              unreadCount = snapshot.data!.docs.length;
                            }

                            return Stack(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    Get.to(ReceivedNudgesScreen());
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$unreadCount',
                                          style: TextStyle(
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
                            // Get.to(() => RequestCounsellingScreen());
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
                            Get.to(ProfileScreen());
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
                const SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: ListView(
                    children: [
                      RoutineSection(
                        title: 'Morning',
                        icon: Icons.sunny_snowing,
                        tasks: taskCards
                            .where((task) => task.category == 'Breathe')
                            .toList(),
                      ),
                      RoutineSection(
                        title: 'Day',
                        icon: Icons.sunny,
                        tasks: taskCards
                            .where((task) => task.category == 'Meditation')
                            .toList(),
                      ),
                      RoutineSection(
                        title: 'Evening',
                        icon: Icons.nights_stay,
                        tasks: taskCards
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
        ),
      ),
    );
  }
}

class RoutineSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<TaskCard> tasks;

  RoutineSection({
    required this.title,
    required this.icon,
    required this.tasks,
  });

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
        const SizedBox(
          height: 10,
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
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isCompleted,
      builder: (context, isCompleted, child) {
        bool isMoodTracker = widget.category == 'Mood Tracker';
        return GestureDetector(
          onTap: isMoodTracker || !isCompleted ? widget.onTap : null,
          child: Opacity(
            opacity: isMoodTracker ? 1.0 : (isCompleted ? 0.5 : 1.0),
            child: Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: null,
                  shape: CircleBorder(),
                  checkColor: Colors.white,
                  activeColor: Colors.indigo[600],
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                                  Icon(widget.icon,
                                      color: Colors.white, size: 22),
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
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(widget.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
