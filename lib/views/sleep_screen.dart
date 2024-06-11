import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('Sleep'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              height: 120, // height of the story cards
              width: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  StoryCard(
                    image:
                        'assets/images/relaxing/relaxing_sounds_1.png', // replace with your image asset
                    title: 'Adventures of Huckleberry Finn',
                    duration: '15 min',
                  ),
                  SizedBox(width: 16),
                  StoryCard(
                    image:
                        'assets/images/relaxing/relaxing_sounds_2.png', // replace with your image asset
                    title: 'Pollyanna',
                    duration: '18 min',
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Music',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
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
                  // Add more MusicTile widgets here
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
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image,
                fit: BoxFit.cover, height: 50, width: 50), // Adjust image size
            SizedBox(width: 8), // Add some spacing between image and text
            Expanded(
              child: Column(
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
    return ListTile(
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
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
