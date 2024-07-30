import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/sleep_music_controller.dart';
import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
import 'package:mental_wellness_app/widgets/story_card.dart';
import 'package:mental_wellness_app/widgets/music_tile.dart';

class SleepScreen extends StatelessWidget {
  final SleepStoryController controller = Get.put(SleepStoryController());
  final SleepMusicController sleepMusicController =
      Get.put(SleepMusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sleep',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Display a sleep story card widget for every sleep story doc in Firestore
              SizedBox(
                height: 265, // height for two rows of story cards
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          (controller.sleepStories.length / 2).ceil(),
                          (columnIndex) {
                            int firstIndex = columnIndex * 2;
                            int secondIndex = firstIndex + 1;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Column(
                                children: [
                                  StoryCard(
                                      sleepStory:
                                          controller.sleepStories[firstIndex]),
                                  if (secondIndex <
                                      controller.sleepStories.length)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: StoryCard(
                                          sleepStory: controller
                                              .sleepStories[secondIndex]),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
              ),
              const SizedBox(height: 25),
              const Text(
                'Music',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() {
                if (sleepMusicController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sleepMusicController.sleepMusic.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          MusicTile(
                              sleepMusic:
                                  sleepMusicController.sleepMusic[index]),
                          if (index ==
                              sleepMusicController.sleepMusic.length - 1)
                            const SizedBox(
                                height: 45), // Add space before the last item
                        ],
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
