// controllers/routine_controller.dart
// controllers/routine_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/meditation_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/views/breathing_play_screen.dart';
import 'package:mental_wellness_app/views/meditation_detail_screen.dart';
import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
import 'package:mental_wellness_app/home_page.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/widgets/task_card.dart';

class RoutineController extends GetxController {
  List<TaskCard> taskCards = [];
  final MeditationExerciseController meditationController =
      Get.put(MeditationExerciseController());
  final BreathingExerciseController breathingExerciseController =
      Get.put(BreathingExerciseController());
  final SleepStoryController sleepStoryController =
      Get.put(SleepStoryController());
  final FirestoreService firestoreService = FirestoreService();

  void preloadImages(BuildContext context) {
    const List<String> imageAssets = [
      'assets/images/relaxing/relaxing_sounds_1.png',
    ];

    for (String imagePath in imageAssets) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  Future<List<TaskCard>> fetchTasks(
      DocumentSnapshot memberSnapshot, BuildContext context) async {
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
                    Get.to(() => BreathingPlayScreen(
                          exercise: breathingExercise,
                          onComplete: () async {
                            await firestoreService.updateTaskCompletion(
                                taskId, 'Breathe', true, context);
                            isCompletedNotifier.value = true;
                          },
                        ));
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
                    Get.to(() => MeditationDetailScreen(
                          meditation: meditationExercise,
                          onComplete: () async {
                            await firestoreService.updateTaskCompletion(
                                taskId, 'Meditation', true, context);
                            isCompletedNotifier.value = true;
                          },
                        ));
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
                await Get.to(() => MoodTrackerScreen());
                updateTaskCards(memberSnapshot,
                    context); // Update task cards when returning from mood tracker screen
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

  Future<void> updateTaskCards(
      DocumentSnapshot memberSnapshot, BuildContext context) async {
    List<TaskCard> tasks = await fetchTasks(memberSnapshot, context);
    taskCards = tasks;
    update();
  }

  Stream<DocumentSnapshot> getRoutineStream() {
    return firestoreService.getRoutineStream();
  }

  String getDurationText(int durationInSeconds) {
    int minutes = (durationInSeconds / 60).ceil();
    return '$minutes min';
  }
}
