import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/views/relaxing_sounds.dart';
import 'package:mental_wellness_app/views/sleep_screen.dart';
import 'routine_page.dart';
import 'meditation_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const RoutinePage(),
    MeditationPage(),
    SleepScreen(),
    const RelaxingSoundsScreen(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Allows more than 3 navbar items
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
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
