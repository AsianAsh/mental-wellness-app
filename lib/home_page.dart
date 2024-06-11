import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_wellness_app/util/emote_face.dart';
import 'package:mental_wellness_app/views/relaxing_sounds.dart';
import 'package:mental_wellness_app/views/sleep_screen.dart';
import './random_words.dart';
import 'routine_page.dart';
import 'meditation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  // final _tab1navigatorKey = GlobalKey<NavigatorState>();
  // final _tab2navigatorKey = GlobalKey<NavigatorState>();
  // final _tab3navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const RoutinePage(),
    const MeditationPage(),
    SleepScreen(),
    const RelaxingSoundsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Allows more than 3 navbar item
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
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        // onTap: _onItemTapped,
      ),
      // appBar: AppBar(
      //   title: const Text('Home Page', style: TextStyle(color: Colors.white)),
      // ),

      body: _pages[_currentIndex],
      // SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(25.0),
      //     child: Column(children: [
      //       // Daily Task Title + Profile Button
      //       const Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             'Wellness Routine',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 22,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           Icon(
      //             Icons.person,
      //             color: Colors.white,
      //           ),
      //         ],
      //       ),

      //       const SizedBox(
      //         height: 15,
      //       ),

      //       // Random Words Page Button
      //       Row(children: [
      //         Expanded(
      //           child: ElevatedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) => RandomWords()),
      //               );
      //             },
      //             child: const Text('Go to Random Words'),
      //           ),
      //         ),
      //       ]),

      //       // Sized Box for space between components
      //       const SizedBox(
      //         height: 20,
      //       ),

      //       // Search bar
      //       Container(
      //         decoration: BoxDecoration(
      //             color: Colors.blue[900],
      //             borderRadius: BorderRadius.circular(15)),
      //         padding: const EdgeInsets.all(12),
      //         child: const Row(
      //           children: [
      //             Icon(
      //               Icons.search,
      //               color: Colors.white,
      //             ),
      //             SizedBox(
      //               width: 5,
      //             ),
      //             Text('Search',
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                 )),
      //           ],
      //         ),
      //       ),

      //       const SizedBox(
      //         height: 20,
      //       ),

      //       // How you feeling today Text
      //       const Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         // By default, content in Row is left-aligned unless stated otherwise such as mainAxisAlignment
      //         children: [
      //           Text('How you feeling today?',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold,
      //               )),
      //           Icon(
      //             Icons.more_horiz,
      //             color: Colors.white,
      //           ),
      //         ],
      //       ),

      //       const SizedBox(
      //         height: 20,
      //       ),

      //       // Mood of the day Options
      //       const Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           // bad
      //           Column(
      //             children: [
      //               EmoticonFace(
      //                 emoticonFace: '😒',
      //               ),
      //               SizedBox(height: 5),
      //               Text('Bad',
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   )),
      //             ],
      //           ),

      //           // fine
      //           Column(
      //             children: [
      //               EmoticonFace(
      //                 emoticonFace: '😐',
      //               ),
      //               SizedBox(height: 5),
      //               Text('Fine',
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   )),
      //             ],
      //           ),

      //           // good
      //           Column(
      //             children: [
      //               EmoticonFace(
      //                 emoticonFace: '😀',
      //               ),
      //               SizedBox(height: 5),
      //               Text('Good',
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   )),
      //             ],
      //           ),

      //           // excellent
      //           Column(
      //             children: [
      //               EmoticonFace(
      //                 emoticonFace: '😎',
      //               ),
      //               SizedBox(height: 5),
      //               Text('Fantastic',
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   )),
      //             ],
      //           ),
      //         ],
      //       )
      //     ]),
      //   ),
      // )
    );
  }
}
