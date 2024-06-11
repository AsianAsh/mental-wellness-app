import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[900],
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
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 265, // height for two rows of story cards
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        StoryCard(
                          image:
                              'assets/images/relaxing/relaxing_sounds_1.png', // replace with your image asset
                          title: 'Adventures of Huckleberry Finn',
                          duration: '15 min',
                        ),
                        SizedBox(height: 8),
                        StoryCard(
                          image:
                              'assets/images/relaxing/relaxing_sounds_2.png', // replace with your image asset
                          title: 'Pollyanna',
                          duration: '18 min',
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        StoryCard(
                          image:
                              'assets/images/relaxing/relaxing_sounds_2.png', // replace with your image asset
                          title: 'Adventures of Huckleberry Finn',
                          duration: '15 min',
                        ),
                        SizedBox(height: 8),
                        StoryCard(
                          image:
                              'assets/images/relaxing/relaxing_sounds_1.png', // replace with your image asset
                          title: 'Pollyanna',
                          duration: '18 min',
                        ),
                      ],
                    ),
                    // Add more Columns for additional story cards here
                  ],
                ),

                // Fetch story documents from database and displays them
                // child: StreamBuilder<QuerySnapshot>(
                //   stream: FirebaseFirestore.instance
                //       .collection('stories')
                //       .snapshots(),
                //   builder: (context, snapshot) {
                //     if (!snapshot.hasData) {
                //       return Center(child: CircularProgressIndicator());
                //     }

                //     var documents = snapshot.data!.docs;
                //     List<Widget> rows = [];

                //     for (int i = 0; i < documents.length; i += 2) {
                //       rows.add(
                //         Column(
                //           children: [
                //             StoryCard(
                //               image: documents[i]['image'],
                //               title: documents[i]['title'],
                //               duration: documents[i]['duration'],
                //             ),
                //             SizedBox(height: 16),
                //             if (i + 1 < documents.length)
                //               StoryCard(
                //                 image: documents[i + 1]['image'],
                //                 title: documents[i + 1]['title'],
                //                 duration: documents[i + 1]['duration'],
                //               ),
                //           ],
                //         ),
                //       );

                //       if (i + 1 < documents.length) {
                //         rows.add(SizedBox(width: 16));
                //       }
                //     }

                //     return Row(children: rows);
                //   },
                // ),
              ),
            ),
            const SizedBox(height: 32),
            // Music Section Title
            const Text(
              'Music',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  MusicTile(
                    title: 'Sweet sleep',
                    description: 'Music with soft and binaural pads',
                    duration: '15:09',
                  ),
                  MusicTile(
                    title: 'Ambient sleep',
                    description: 'Gentle bells and flute',
                    duration: '15:22',
                  ),
                  MusicTile(
                    title: 'Ambient sleep',
                    description: 'Gentle bells and flute',
                    duration: '15:22',
                  ),
                  MusicTile(
                    title: 'Rain and thunder',
                    description: 'Anxiety-free sound effect',
                    duration: '15:20',
                  ),
                  MusicTile(
                    title: 'White noise',
                    description: 'Fall asleep fast',
                    duration: '15:16',
                  ),
                  // Extra MusicTile widgets are added here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String duration;

  StoryCard({required this.image, required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Image.asset(image,
                fit: BoxFit.cover,
                height: 100,
                width: 100), // Adjust image size
            SizedBox(width: 12), // Add some spacing between image and text
            Expanded(
              child: Column(
                // Vertically center title and duration text
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(duration),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicTile extends StatelessWidget {
  final String title;
  final String description;
  final String duration;

  MusicTile(
      {required this.title, required this.description, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white24, width: 1),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.play_circle_filled, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          duration,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
