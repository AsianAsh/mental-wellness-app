// before getting sleep_story data and displaying in StoryCard
// import 'package:flutter/material.dart';

// class SleepScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.blue[900],
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
//         automaticallyImplyLeading: false, // Remove the back button
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Stories',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             SizedBox(
//               height: 265, // height for two rows of story cards
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         StoryCard(
//                           image:
//                               'assets/images/relaxing/relaxing_sounds_1.png', // replace with your image asset
//                           title: 'Adventures of Huckleberry Finn',
//                           duration: '15 min',
//                         ),
//                         SizedBox(height: 8),
//                         StoryCard(
//                           image:
//                               'assets/images/relaxing/relaxing_sounds_2.png', // replace with your image asset
//                           title: 'Pollyanna',
//                           duration: '18 min',
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 12),
//                     Column(
//                       children: [
//                         StoryCard(
//                           image:
//                               'assets/images/relaxing/relaxing_sounds_2.png', // replace with your image asset
//                           title: 'Adventures of Huckleberry Finn',
//                           duration: '15 min',
//                         ),
//                         SizedBox(height: 8),
//                         StoryCard(
//                           image:
//                               'assets/images/relaxing/relaxing_sounds_1.png', // replace with your image asset
//                           title: 'Pollyanna',
//                           duration: '18 min',
//                         ),
//                       ],
//                     ),
//                     // Add more Columns for additional story cards here
//                   ],
//                 ),

//                 // Fetch story documents from database and displays them
//                 // child: StreamBuilder<QuerySnapshot>(
//                 //   stream: FirebaseFirestore.instance
//                 //       .collection('stories')
//                 //       .snapshots(),
//                 //   builder: (context, snapshot) {
//                 //     if (!snapshot.hasData) {
//                 //       return Center(child: CircularProgressIndicator());
//                 //     }

//                 //     var documents = snapshot.data!.docs;
//                 //     List<Widget> rows = [];

//                 //     for (int i = 0; i < documents.length; i += 2) {
//                 //       rows.add(
//                 //         Column(
//                 //           children: [
//                 //             StoryCard(
//                 //               image: documents[i]['image'],
//                 //               title: documents[i]['title'],
//                 //               duration: documents[i]['duration'],
//                 //             ),
//                 //             SizedBox(height: 16),
//                 //             if (i + 1 < documents.length)
//                 //               StoryCard(
//                 //                 image: documents[i + 1]['image'],
//                 //                 title: documents[i + 1]['title'],
//                 //                 duration: documents[i + 1]['duration'],
//                 //               ),
//                 //           ],
//                 //         ),
//                 //       );

//                 //       if (i + 1 < documents.length) {
//                 //         rows.add(SizedBox(width: 16));
//                 //       }
//                 //     }

//                 //     return Row(children: rows);
//                 //   },
//                 // ),
//               ),
//             ),
//             const SizedBox(height: 32),
//             // Music Section Title
//             const Text(
//               'Music',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   MusicTile(
//                     title: 'Sweet sleep',
//                     description: 'Music with soft and binaural pads',
//                     duration: '15:09',
//                   ),
//                   MusicTile(
//                     title: 'Ambient sleep',
//                     description: 'Gentle bells and flute',
//                     duration: '15:22',
//                   ),
//                   MusicTile(
//                     title: 'Ambient sleep',
//                     description: 'Gentle bells and flute',
//                     duration: '15:22',
//                   ),
//                   MusicTile(
//                     title: 'Rain and thunder',
//                     description: 'Anxiety-free sound effect',
//                     duration: '15:20',
//                   ),
//                   MusicTile(
//                     title: 'White noise',
//                     description: 'Fall asleep fast',
//                     duration: '15:16',
//                   ),
//                   // Extra MusicTile widgets are added here
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StoryCard extends StatelessWidget {
//   final String image;
//   final String title;
//   final String duration;

//   StoryCard({required this.image, required this.title, required this.duration});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(image,
//                 fit: BoxFit.cover,
//                 height: 100,
//                 width: 100), // Adjust image size
//             SizedBox(width: 12), // Add some spacing between image and text
//             Expanded(
//               child: Column(
//                 // Vertically center title and duration text
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(duration),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MusicTile extends StatelessWidget {
//   final String title;
//   final String description;
//   final String duration;

//   MusicTile(
//       {required this.title, required this.description, required this.duration});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.white24, width: 1),
//         ),
//       ),
//       child: ListTile(
//         leading: Icon(Icons.play_circle_filled, color: Colors.white),
//         title: Text(
//           title,
//           style: TextStyle(color: Colors.white),
//         ),
//         subtitle: Text(
//           description,
//           style: TextStyle(color: Colors.white70),
//         ),
//         trailing: Text(
//           duration,
//           style: TextStyle(color: Colors.white, fontSize: 12),
//         ),
//       ),
//     );
//   }
// }

// sleep_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/sleep_music_controller.dart';
import 'package:mental_wellness_app/controllers/sleep_story_controller.dart';
import 'package:mental_wellness_app/models/sleep_music.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'package:provider/provider.dart';

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
                  List<SleepStory> stories = controller.sleepStories;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        (stories.length / 2).ceil(),
                        (columnIndex) {
                          int firstIndex = columnIndex * 2;
                          int secondIndex = firstIndex + 1;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                StoryCard(sleepStory: stories[firstIndex]),
                                if (secondIndex < stories.length)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: StoryCard(
                                        sleepStory: stories[secondIndex]),
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
            Expanded(
              child: Obx(() {
                if (sleepMusicController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final SleepStory sleepStory;

  StoryCard({required this.sleepStory});

  @override
  Widget build(BuildContext context) {
    final audioPlayerState =
        Provider.of<AudioPlayerState>(context, listen: false);

    return GestureDetector(
      onTap: () {
        audioPlayerState.playAudio(sleepStory.audioPath);
        audioPlayerState.setCurrentAudioTitle(sleepStory.title);
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  sleepStory.imagePath,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sleepStory.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(sleepStory.getDurationText()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicTile extends StatelessWidget {
  final SleepMusic sleepMusic;

  MusicTile({required this.sleepMusic});

  @override
  Widget build(BuildContext context) {
    final audioPlayerState =
        Provider.of<AudioPlayerState>(context, listen: false);
    return GestureDetector(
      onTap: () {
        audioPlayerState.playAudio(sleepMusic.audioPath);
        audioPlayerState.setCurrentAudioTitle(sleepMusic.title);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white24, width: 1),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.play_circle_filled, color: Colors.white),
          title: Text(
            sleepMusic.title,
            style: TextStyle(color: Colors.white),
          ),
          // subtitle: Text(
          //   description,
          //   style: TextStyle(color: Colors.white70),
          // ),
          trailing: Text(
            sleepMusic.getMinSecDurationText(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
