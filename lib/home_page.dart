// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:mental_wellness_app/views/relaxing_sounds.dart';
// import 'package:mental_wellness_app/views/sleep_screen.dart';
// import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
// import 'package:provider/provider.dart';
// import 'views/routine_page.dart';
// import 'views/meditation_page.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     RoutinePage(),
//     MeditationPage(),
//     SleepScreen(),
//     RelaxingSoundsScreen(),
//   ];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//   }

//   void _preloadImages() {
//     // List of image assets to preload
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AudioPlayerState(),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             IndexedStack(
//               index: _currentIndex,
//               children: _pages,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: PersistentAudioPlayer(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type:
//               BottomNavigationBarType.fixed, // Allows more than 3 navbar items
//           currentIndex: _currentIndex,
//           onTap: _onItemTapped,
//           backgroundColor:
//               Colors.indigo[600], // Set the background color to indigo
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.self_improvement), label: 'Meditation'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//           ],
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white38,
//         ),
//         // body: IndexedStack(
//         //   index: _currentIndex,
//         //   children: _pages,
//         // ),
//       ),
//     );
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Stack(
//   //       children: [
//   //         _pages[_currentIndex],
//   //         Align(
//   //           alignment: Alignment.bottomCenter,
//   //           child: PersistentAudioPlayer(),
//   //         ),
//   //       ],
//   //     ),
//   //     bottomNavigationBar: BottomNavigationBar(
//   //         currentIndex: _currentIndex,
//   //         onTap: (index) {
//   //           setState(() {
//   //             _currentIndex = index;
//   //           });
//   //         },
//   //         backgroundColor:
//   //             Colors.indigo[600], // Set the background color to indigo
//   //         items: [
//   //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//   //           BottomNavigationBarItem(
//   //               icon: Icon(Icons.self_improvement), label: 'Meditation'),
//   //           BottomNavigationBarItem(
//   //               icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//   //           BottomNavigationBarItem(
//   //               icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//   //         ],
//   //         selectedItemColor: Colors.white,
//   //         unselectedItemColor: Colors.white38),
//   //   );
//   // }
// }

// to allow Routine Taskcard widget onTap(Sleep Story) to navigate to SleepScreen and play audio
// result: works
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:mental_wellness_app/views/relaxing_sounds.dart';
// import 'package:mental_wellness_app/views/sleep_screen.dart';
// import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
// import 'package:provider/provider.dart';
// import 'views/routine_page.dart';
// import 'views/meditation_page.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   State<HomePage> createState() => _HomePageState();

//   static _HomePageState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_HomePageState>();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     RoutinePage(),
//     MeditationPage(),
//     SleepScreen(),
//     RelaxingSoundsScreen(),
//   ];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _preloadImages();
//   }

//   void _preloadImages() {
//     // List of image assets to preload
//     const List<String> imageAssets = [
//       'assets/images/relaxing/relaxing_sounds_1.png',
//     ];

//     for (String imagePath in imageAssets) {
//       precacheImage(AssetImage(imagePath), context);
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void navigateToPage(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AudioPlayerState(),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             IndexedStack(
//               index: _currentIndex,
//               children: _pages,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: PersistentAudioPlayer(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type:
//               BottomNavigationBarType.fixed, // Allows more than 3 navbar items
//           currentIndex: _currentIndex,
//           onTap: _onItemTapped,
//           backgroundColor:
//               Colors.indigo[600], // Set the background color to indigo
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.self_improvement), label: 'Meditation'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.night_shelter), label: 'Sleep Stories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.music_note_rounded), label: 'Sounds'),
//           ],
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white38,
//         ),
//       ),
//     );
//   }
// }

// make HomePage singleton
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'package:mental_wellness_app/views/relaxing_sounds.dart';
import 'package:mental_wellness_app/views/sleep_screen.dart';
import 'package:mental_wellness_app/widgets/persistent_audio_player.dart';
import 'package:provider/provider.dart';
import 'views/routine_page.dart';
import 'views/meditation_page.dart';

class HomePage extends StatefulWidget {
  HomePage._privateConstructor();
  static final HomePage _instance = HomePage._privateConstructor();
  static HomePage get instance => _instance;

  final user = FirebaseAuth.instance.currentUser!;

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
          type:
              BottomNavigationBarType.fixed, // Allows more than 3 navbar items
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
      ),
    );
  }
}
