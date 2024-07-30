// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/sleep_music_controller.dart';
// import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
// import 'package:mental_wellness_app/models/sleep_music.dart';
// import 'package:mental_wellness_app/models/sleep_story.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:provider/provider.dart';

// class SleepScreen extends StatelessWidget {
//   final SleepStoryController controller = Get.put(SleepStoryController());
//   final SleepMusicController sleepMusicController =
//       Get.put(SleepMusicController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Sleep',
//           style: TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Stories',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               // Display a sleep story card widget for every sleep story doc in Firestore
//               SizedBox(
//                 height: 265, // height for two rows of story cards
//                 child: Obx(() {
//                   if (controller.isLoading.value) {
//                     return Center(child: CircularProgressIndicator());
//                   } else {
//                     List<SleepStory> stories = controller.sleepStories;
//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: List.generate(
//                           (stories.length / 2).ceil(),
//                           (columnIndex) {
//                             int firstIndex = columnIndex * 2;
//                             int secondIndex = firstIndex + 1;
//                             return Padding(
//                               padding: const EdgeInsets.only(right: 12.0),
//                               child: Column(
//                                 children: [
//                                   StoryCard(sleepStory: stories[firstIndex]),
//                                   if (secondIndex < stories.length)
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: StoryCard(
//                                           sleepStory: stories[secondIndex]),
//                                     ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   }
//                 }),
//               ),
//               const SizedBox(height: 25),
//               const Text(
//                 'Music',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Obx(() {
//                 if (sleepMusicController.isLoading.value) {
//                   return Center(child: CircularProgressIndicator());
//                 } else {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: sleepMusicController.sleepMusic.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           MusicTile(
//                               sleepMusic:
//                                   sleepMusicController.sleepMusic[index]),
//                           if (index ==
//                               sleepMusicController.sleepMusic.length - 1)
//                             const SizedBox(
//                                 height: 45), // Add space before the last item
//                         ],
//                       );
//                     },
//                   );
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StoryCard extends StatelessWidget {
//   final SleepStory sleepStory;

//   StoryCard({required this.sleepStory});

//   @override
//   Widget build(BuildContext context) {
//     final audioPlayerState =
//         Provider.of<AudioPlayerState>(context, listen: false);

//     return GestureDetector(
//       onTap: () {
//         audioPlayerState.playAudio(sleepStory.audioPath);
//         audioPlayerState.setCurrentAudioTitle(sleepStory.title);
//       },
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   sleepStory.imagePath,
//                   fit: BoxFit.cover,
//                   height: 100,
//                   width: 100,
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       sleepStory.title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(sleepStory.getDurationText()),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MusicTile extends StatelessWidget {
//   final SleepMusic sleepMusic;

//   MusicTile({required this.sleepMusic});

//   @override
//   Widget build(BuildContext context) {
//     final audioPlayerState =
//         Provider.of<AudioPlayerState>(context, listen: false);
//     return GestureDetector(
//       onTap: () {
//         audioPlayerState.playAudio(sleepMusic.audioPath);
//         audioPlayerState.setCurrentAudioTitle(sleepMusic.title);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Colors.white24, width: 1),
//           ),
//         ),
//         child: ListTile(
//           leading: Icon(Icons.play_circle_filled, color: Colors.white),
//           title: Text(
//             sleepMusic.title,
//             style: TextStyle(color: Colors.white),
//           ),
//           // subtitle: Text(
//           //   description,
//           //   style: TextStyle(color: Colors.white70),
//           // ),
//           trailing: Text(
//             sleepMusic.getMinSecDurationText(),
//             style: TextStyle(color: Colors.white, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
