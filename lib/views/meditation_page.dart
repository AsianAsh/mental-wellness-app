import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/meditation_exercise_controller.dart';
import 'package:mental_wellness_app/controllers/breathing_exercise_controller.dart';
import 'package:mental_wellness_app/widgets/meditation_card.dart';
import 'package:mental_wellness_app/widgets/breathing_exercise_card.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class MeditationPage extends StatelessWidget {
  MeditationPage({super.key});

  final BreathingExerciseController breathingController =
      Get.put(BreathingExerciseController());

  final MeditationExerciseController meditationController =
      Get.put(MeditationExerciseController());

  final FirestoreService firestoreService = FirestoreService();

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
        child: SingleChildScrollView(
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
                    SizedBox(
                      height: 150, // Adjust the height as needed
                      child: Obx(() {
                        if (breathingController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                breathingController.breathingExercises.length,
                            itemBuilder: (context, index) {
                              return BreathingExerciseCard(
                                exercise: breathingController
                                    .breathingExercises[index],
                                onComplete: () async {
                                  await firestoreService.updateTaskCompletion(
                                      breathingController
                                          .breathingExercises[index].id,
                                      'Breathe',
                                      true,
                                      context);
                                },
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
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
              Obx(() {
                if (meditationController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: meditationController.meditationExercises.length,
                    itemBuilder: (context, index) {
                      return MeditationCard(
                        meditation:
                            meditationController.meditationExercises[index],
                        onComplete: () async {
                          await firestoreService.updateTaskCompletion(
                              meditationController
                                  .meditationExercises[index].id,
                              'Meditation',
                              true,
                              context);
                        },
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
