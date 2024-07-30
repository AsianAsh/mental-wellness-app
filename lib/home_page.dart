// views/home_page.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/views/meditation_page.dart';
import 'package:mental_wellness_app/views/relaxing_sounds_screen.dart';
import 'package:mental_wellness_app/views/routine_page.dart';
import 'package:mental_wellness_app/views/sleep_screen.dart';
import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';

class HomePage extends StatefulWidget {
  HomePage._privateConstructor();
  static final HomePage _instance = HomePage._privateConstructor();
  static HomePage get instance => _instance;

  @override
  State<HomePage> createState() => _HomePageState();

  static _HomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomePageState>();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    RoutinePage(),
    MeditationPage(),
    SleepScreen(),
    RelaxingSoundsScreen(),
  ];

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
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.indigo[600],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.self_improvement), label: 'Meditation'),
            BottomNavigationBarItem(
                icon: Icon(Icons.night_shelter), label: 'Sleep'),
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
