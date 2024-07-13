// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/util/emote_face.dart';
// import 'package:intl/intl.dart';

// class MoodTrackerScreen extends StatefulWidget {
//   const MoodTrackerScreen({Key? key}) : super(key: key);

//   @override
//   _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
// }

// class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
//   bool isAddingNote = false;
//   TextEditingController _noteController = TextEditingController();
//   bool isNoteFilled = false;

//   // TextField to write note (pops up when Add Note button is tapped)
//   void _showAddNoteBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.indigo[600],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat.yMMMMd().format(DateTime.now()),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _noteController,
//                   onChanged: (text) {
//                     setState(() {
//                       isNoteFilled = text.isNotEmpty;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Write here your thoughts and emotions',
//                     hintStyle: TextStyle(color: Colors.white70),
//                     filled: true,
//                     fillColor: Colors.indigo[400],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.add, color: Colors.white),
//                       onPressed: () {
//                         // Handle note submission
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
//                   maxLines: 3,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mood Tracker'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Today's Check-in Card
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.cloud, color: Colors.purple[300]),
//                       SizedBox(width: 8),
//                       Text(
//                         "Today's check-in",
//                         style: TextStyle(
//                           color: Colors.purple[300],
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'How you feeling today?',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Time to reflect on your day',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SafeArea(
//                     child: Column(
//                       children: [
//                         // Mood of the day Options
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             // bad
//                             Column(
//                               children: [
//                                 EmoticonFace(emoticonFace: '😒'),
//                                 SizedBox(height: 5),
//                                 Text('Bad',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     )),
//                               ],
//                             ),

//                             // fine
//                             Column(
//                               children: [
//                                 EmoticonFace(emoticonFace: '😐'),
//                                 SizedBox(height: 5),
//                                 Text('Fine',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     )),
//                               ],
//                             ),

//                             // good
//                             Column(
//                               children: [
//                                 EmoticonFace(emoticonFace: '😀'),
//                                 SizedBox(height: 5),
//                                 Text('Good',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     )),
//                               ],
//                             ),

//                             // excellent
//                             Column(
//                               children: [
//                                 EmoticonFace(emoticonFace: '😎'),
//                                 SizedBox(height: 5),
//                                 Text('Fantastic',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.center,
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           _showAddNoteBottomSheet(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 16), // Adjust the radius as needed
//                           ),
//                         ),
//                         child: Text(isNoteFilled ? 'Edit Note' : 'Add Note'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Tracker History Card
//             SizedBox(height: 20),

//             // Tracker History Card
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ChoiceChip(
//                         label:
//                             Text('Week', style: TextStyle(color: Colors.white)),
//                         selected: true,
//                         backgroundColor: Colors.indigo,
//                         selectedColor: Colors.purple,
//                         onSelected: (bool selected) {},
//                       ),
//                       ChoiceChip(
//                         label: Text('Month',
//                             style: TextStyle(color: Colors.white)),
//                         selected: false,
//                         backgroundColor: Colors.indigo,
//                         onSelected: (bool selected) {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Last 7 check-ins',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     height: 90,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: List.generate(7, (index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Container(
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: index == 0 ? Colors.blue : Colors.white24,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Check-ins Left Card
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo[800],
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.lock, color: Colors.white, size: 40),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '6 check-ins left',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Track your moods a bit longer to unlock the mood score',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Display selected mood, add option to replace selected mood, hide Add Note button
// until mood is selected
// mood_tracker_screen.dart (view)
// mood_tracker_screen.dart (view)
// mood_tracker_screen.dart (view)
// mood_tracker_screen.dart (view)
//

// Add storing and displaying mood entry documents from Firestore
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mental_wellness_app/util/emote_face.dart';
// import 'package:intl/intl.dart';

// class MoodTrackerScreen extends StatefulWidget {
//   const MoodTrackerScreen({Key? key}) : super(key: key);

//   @override
//   _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
// }

// class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
//   bool isAddingNote = false;
//   TextEditingController _noteController = TextEditingController();
//   bool isNoteFilled = false;
//   String? selectedMood;
//   String? selectedMoodText;

//   final List<Map<String, String>> moods = [
//     {'emoticon': '😒', 'text': 'Bad'},
//     {'emoticon': '😐', 'text': 'Fine'},
//     {'emoticon': '😀', 'text': 'Good'},
//     {'emoticon': '😎', 'text': 'Fantastic'}
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadMoodEntryForToday();
//   }

//   Future<void> _loadMoodEntryForToday() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       QuerySnapshot moodEntrySnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('mood_entries')
//           .where('date',
//               isEqualTo: DateTime.now().toIso8601String().substring(0, 10))
//           .get();

//       if (moodEntrySnapshot.docs.isNotEmpty) {
//         var moodEntry =
//             moodEntrySnapshot.docs.first.data() as Map<String, dynamic>;
//         setState(() {
//           selectedMood = moodEntry['mood'];
//           selectedMoodText = _getMoodText(moodEntry['mood']);
//           _noteController.text = moodEntry['note'];
//           isNoteFilled = moodEntry['note'].isNotEmpty;
//         });
//       }
//     }
//   }

//   String _getMoodText(String emoticon) {
//     return moods.firstWhere((mood) => mood['emoticon'] == emoticon)['text']!;
//   }

//   Future<void> _saveMoodEntry() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null && selectedMood != null) {
//       await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('mood_entries')
//           .doc(DateTime.now()
//               .toIso8601String()
//               .substring(0, 10)) // Use date as document ID
//           .set({
//         'date': DateTime.now().toIso8601String().substring(0, 10),
//         'mood': selectedMood,
//         'note': _noteController.text,
//       });
//     }
//   }

//   void _selectMood(String emoticon, String text) {
//     setState(() {
//       selectedMood = emoticon;
//       selectedMoodText = text;
//       _saveMoodEntry(); // Save mood entry when a mood is selected
//     });
//   }

//   void _showAddNoteBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.indigo[600],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat.yMMMMd().format(DateTime.now()),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _noteController,
//                   onChanged: (text) {
//                     setState(() {
//                       isNoteFilled = text.isNotEmpty;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Write here your thoughts and emotions',
//                     hintStyle: TextStyle(color: Colors.white70),
//                     filled: true,
//                     fillColor: Colors.indigo[400],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.add, color: Colors.white),
//                       onPressed: () {
//                         _saveMoodEntry(); // Save mood entry when note is added
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
//                   maxLines: 3,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showMoodSelectionModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.indigo[600],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Changing your mood?',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: moods.map((mood) {
//                   return GestureDetector(
//                     onTap: () {
//                       _selectMood(mood['emoticon']!, mood['text']!);
//                       Navigator.pop(context);
//                     },
//                     child: Column(
//                       children: [
//                         EmoticonFace(emoticonFace: mood['emoticon']!),
//                         SizedBox(height: 5),
//                         Text(mood['text']!,
//                             style: TextStyle(
//                               color: Colors.white,
//                             )),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mood Tracker'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Today's Check-in Card
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.cloud, color: Colors.purple[300]),
//                       SizedBox(width: 8),
//                       Text(
//                         "Today's check-in",
//                         style: TextStyle(
//                           color: Colors.purple[300],
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Text(
//                         selectedMood == null
//                             ? 'How you feeling today?'
//                             : "You're feeling $selectedMood",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (selectedMood != null)
//                         IconButton(
//                           icon: Icon(Icons.edit, color: Colors.white),
//                           onPressed: () {
//                             _showMoodSelectionModal(context);
//                           },
//                         ),
//                     ],
//                   ),
//                   if (selectedMood == null)
//                     Column(
//                       children: [
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: moods.map((mood) {
//                             return GestureDetector(
//                               onTap: () {
//                                 _selectMood(mood['emoticon']!, mood['text']!);
//                               },
//                               child: Column(
//                                 children: [
//                                   EmoticonFace(emoticonFace: mood['emoticon']!),
//                                   SizedBox(height: 5),
//                                   Text(mood['text']!,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       )),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   if (selectedMoodText != null)
//                     Text(
//                       selectedMoodText!,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   SizedBox(height: 20),
//                   if (selectedMood != null)
//                     Align(
//                       alignment: Alignment.center,
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _showAddNoteBottomSheet(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: Text(isNoteFilled ? 'Edit Note' : 'Add Note'),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             // Tracker History Card
//             SizedBox(height: 20),

//             // Tracker History Card
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ChoiceChip(
//                         label:
//                             Text('Week', style: TextStyle(color: Colors.white)),
//                         selected: true,
//                         backgroundColor: Colors.indigo,
//                         selectedColor: Colors.purple,
//                         onSelected: (bool selected) {},
//                       ),
//                       ChoiceChip(
//                         label: Text('Month',
//                             style: TextStyle(color: Colors.white)),
//                         selected: false,
//                         backgroundColor: Colors.indigo,
//                         onSelected: (bool selected) {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Last 7 check-ins',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     height: 90,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: List.generate(7, (index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Container(
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: index == 0 ? Colors.blue : Colors.white24,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Check-ins Left Card
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo[800],
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.lock, color: Colors.white, size: 40),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '6 check-ins left',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Track your moods a bit longer to unlock the mood score',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// get 7 latest mood entries form firestore and display under the containers section
// when a container is presses, a modal pops up showing the entry details of that day
// mood_tracker_screen.dart (view)
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/util/emote_face.dart';

// class MoodTrackerScreen extends StatefulWidget {
//   const MoodTrackerScreen({Key? key}) : super(key: key);

//   @override
//   _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
// }

// class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
//   bool isAddingNote = false;
//   TextEditingController _noteController = TextEditingController();
//   bool isNoteFilled = false;
//   String? selectedMood;
//   String? selectedMoodText;
//   List<Map<String, dynamic>> moodEntries = [];

//   final List<Map<String, String>> moods = [
//     {'emoticon': '😒', 'text': 'Bad'},
//     {'emoticon': '😐', 'text': 'Fine'},
//     {'emoticon': '😀', 'text': 'Good'},
//     {'emoticon': '😎', 'text': 'Fantastic'}
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadMoodEntryForToday();
//     _fetchMoodEntries();
//   }

//   Future<void> _loadMoodEntryForToday() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       QuerySnapshot moodEntrySnapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('mood_entries')
//           .where('date',
//               isEqualTo: DateTime.now().toIso8601String().substring(0, 10))
//           .get();

//       if (moodEntrySnapshot.docs.isNotEmpty) {
//         var moodEntry =
//             moodEntrySnapshot.docs.first.data() as Map<String, dynamic>;
//         setState(() {
//           selectedMood = moodEntry['mood'];
//           selectedMoodText = _getMoodText(moodEntry['mood']);
//           _noteController.text = moodEntry['note'];
//           isNoteFilled = moodEntry['note'].isNotEmpty;
//         });
//       }
//     }
//   }

//   String _getMoodText(String emoticon) {
//     return moods.firstWhere((mood) => mood['emoticon'] == emoticon)['text']!;
//   }

//   Future<void> _fetchMoodEntries() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('mood_entries')
//           .orderBy('date', descending: true)
//           .limit(7)
//           .get();

//       setState(() {
//         moodEntries = snapshot.docs
//             .map((doc) => doc.data() as Map<String, dynamic>)
//             .toList();
//       });
//     }
//   }

//   Future<void> _saveMoodEntry() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null && selectedMood != null) {
//       await FirebaseFirestore.instance
//           .collection('Members')
//           .doc(currentUser.uid)
//           .collection('mood_entries')
//           .doc(DateTime.now()
//               .toIso8601String()
//               .substring(0, 10)) // Use date as document ID
//           .set({
//         'date': DateTime.now().toIso8601String().substring(0, 10),
//         'mood': selectedMood,
//         'note': _noteController.text,
//       });
//     }
//   }

//   void _selectMood(String emoticon, String text) {
//     setState(() {
//       selectedMood = emoticon;
//       selectedMoodText = text;
//       _saveMoodEntry(); // Save mood entry when a mood is selected
//     });
//   }

//   void _showAddNoteBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.indigo[600],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   DateFormat.yMMMMd().format(DateTime.now()),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _noteController,
//                   onChanged: (text) {
//                     setState(() {
//                       isNoteFilled = text.isNotEmpty;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Write here your thoughts and emotions',
//                     hintStyle: TextStyle(color: Colors.white70),
//                     filled: true,
//                     fillColor: Colors.indigo[400],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.add, color: Colors.white),
//                       onPressed: () {
//                         _saveMoodEntry(); // Save mood entry when note is added
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.white),
//                   maxLines: 3,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showMoodSelectionModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.indigo[600],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Changing your mood?',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: moods.map((mood) {
//                   return GestureDetector(
//                     onTap: () {
//                       _selectMood(mood['emoticon']!, mood['text']!);
//                       Navigator.pop(context);
//                     },
//                     child: Column(
//                       children: [
//                         EmoticonFace(emoticonFace: mood['emoticon']!),
//                         SizedBox(height: 5),
//                         Text(mood['text']!,
//                             style: TextStyle(
//                               color: Colors.white,
//                             )),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showMoodDetailsModal(
//       BuildContext context, Map<String, dynamic> moodEntry) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.indigo[600],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Your mood on ${DateFormat.yMMMMd().format(DateTime.parse(moodEntry['date']))}',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 moodEntry['mood'],
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//               SizedBox(height: 10),
//               if (moodEntry['note'] != null && moodEntry['note'].isNotEmpty)
//                 Text(
//                   moodEntry['note'],
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mood Tracker'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Today's Check-in Card
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.cloud, color: Colors.purple[300]),
//                       SizedBox(width: 8),
//                       Text(
//                         "Today's check-in",
//                         style: TextStyle(
//                           color: Colors.purple[300],
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Text(
//                         selectedMood == null
//                             ? 'How you feeling today?'
//                             : "You're feeling $selectedMood",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (selectedMood != null)
//                         IconButton(
//                           icon: Icon(Icons.edit, color: Colors.white),
//                           onPressed: () {
//                             _showMoodSelectionModal(context);
//                           },
//                         ),
//                     ],
//                   ),
//                   if (selectedMood == null)
//                     Column(
//                       children: [
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: moods.map((mood) {
//                             return GestureDetector(
//                               onTap: () {
//                                 _selectMood(mood['emoticon']!, mood['text']!);
//                               },
//                               child: Column(
//                                 children: [
//                                   EmoticonFace(emoticonFace: mood['emoticon']!),
//                                   SizedBox(height: 5),
//                                   Text(mood['text']!,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       )),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   if (selectedMoodText != null)
//                     Text(
//                       selectedMoodText!,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   SizedBox(height: 20),
//                   if (selectedMood != null)
//                     Align(
//                       alignment: Alignment.center,
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _showAddNoteBottomSheet(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: Text(isNoteFilled ? 'Edit Note' : 'Add Note'),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             // Tracker History Card
//             SizedBox(height: 20),

//             // Tracker History Card
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.indigo[600],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ChoiceChip(
//                         label:
//                             Text('Week', style: TextStyle(color: Colors.white)),
//                         selected: true,
//                         backgroundColor: Colors.indigo,
//                         selectedColor: Colors.purple,
//                         onSelected: (bool selected) {},
//                       ),
//                       ChoiceChip(
//                         label: Text('Month',
//                             style: TextStyle(color: Colors.white)),
//                         selected: false,
//                         backgroundColor: Colors.indigo,
//                         onSelected: (bool selected) {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Last 7 check-ins',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     height: 90,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 7,
//                       itemBuilder: (context, index) {
//                         bool isOccupied = index < moodEntries.length;
//                         Map<String, dynamic>? moodEntry =
//                             isOccupied ? moodEntries[index] : null;
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: GestureDetector(
//                             onTap: isOccupied
//                                 ? () =>
//                                     _showMoodDetailsModal(context, moodEntry!)
//                                 : null,
//                             child: Container(
//                               width: 50,
//                               decoration: BoxDecoration(
//                                 color: isOccupied
//                                     ? _getMoodColor(moodEntry!['mood'])
//                                     : Colors.white24,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Check-ins Left Card
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.indigo[800],
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.lock, color: Colors.white, size: 40),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '6 check-ins left',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Track your moods a bit longer to unlock the mood score',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getMoodColor(String mood) {
//     switch (mood) {
//       case '😒':
//         return Colors.red;
//       case '😐':
//         return Colors.orange;
//       case '😀':
//         return Colors.green;
//       case '😎':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }
// }

// immeditely update container when current mood and note is changed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/util/emote_face.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  bool isAddingNote = false;
  TextEditingController _noteController = TextEditingController();
  bool isNoteFilled = false;
  String? selectedMood;
  String? selectedMoodText;
  List<Map<String, dynamic>> moodEntries = [];
  final FirestoreService _firestoreService = FirestoreService();

  final List<Map<String, String>> moods = [
    {'emoticon': '😒', 'text': 'Bad'},
    {'emoticon': '😐', 'text': 'Fine'},
    {'emoticon': '😀', 'text': 'Good'},
    {'emoticon': '😎', 'text': 'Fantastic'}
  ];

  @override
  void initState() {
    super.initState();
    _loadMoodEntryForToday();
    _fetchMoodEntries();
  }

  Future<void> _loadMoodEntryForToday() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot moodEntrySnapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .where('date',
              isEqualTo: DateTime.now().toIso8601String().substring(0, 10))
          .get();

      if (moodEntrySnapshot.docs.isNotEmpty) {
        var moodEntry =
            moodEntrySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          selectedMood = moodEntry['mood'];
          selectedMoodText = _getMoodText(moodEntry['mood']);
          _noteController.text = moodEntry['note'];
          isNoteFilled = moodEntry['note'].isNotEmpty;
        });
      }
    }
  }

  String _getMoodText(String emoticon) {
    return moods.firstWhere((mood) => mood['emoticon'] == emoticon)['text']!;
  }

  Future<void> _fetchMoodEntries() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .orderBy('date', descending: true)
          .limit(7)
          .get();

      setState(() {
        moodEntries = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    }
  }

  Future<void> _saveMoodEntry() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && selectedMood != null) {
      await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .doc(DateTime.now()
              .toIso8601String()
              .substring(0, 10)) // Use date as document ID
          .set({
        'date': DateTime.now().toIso8601String().substring(0, 10),
        'mood': selectedMood,
        'note': _noteController.text,
      });
      await _firestoreService.updateMoodTrackerCompletion(true, context);
      await _fetchMoodEntries(); // Re-fetch the mood entries after saving
    }
  }

  void _selectMood(String emoticon, String text) {
    setState(() {
      selectedMood = emoticon;
      selectedMoodText = text;
    });
    _saveMoodEntry(); // Save mood entry when a mood is selected
  }

  void _showAddNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.indigo[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _noteController,
                  onChanged: (text) {
                    setState(() {
                      isNoteFilled = text.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Write here your thoughts and emotions',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.indigo[400],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        _saveMoodEntry(); // Save mood entry when note is added
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMoodSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.indigo[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Changing your mood?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: moods.map((mood) {
                  return GestureDetector(
                    onTap: () {
                      _selectMood(mood['emoticon']!, mood['text']!);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        EmoticonFace(emoticonFace: mood['emoticon']!),
                        SizedBox(height: 5),
                        Text(mood['text']!,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMoodDetailsModal(
      BuildContext context, Map<String, dynamic> moodEntry) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.indigo[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your mood on ${DateFormat.yMMMMd().format(DateTime.parse(moodEntry['date']))}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                moodEntry['mood'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              if (moodEntry['note'] != null && moodEntry['note'].isNotEmpty)
                Text(
                  moodEntry['note'],
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Check-in Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cloud, color: Colors.purple[300]),
                      SizedBox(width: 8),
                      Text(
                        "Today's check-in",
                        style: TextStyle(
                          color: Colors.purple[300],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        selectedMood == null
                            ? 'How you feeling today?'
                            : "You're feeling $selectedMood",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (selectedMood != null)
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            _showMoodSelectionModal(context);
                          },
                        ),
                    ],
                  ),
                  if (selectedMood == null)
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: moods.map((mood) {
                            return GestureDetector(
                              onTap: () {
                                _selectMood(mood['emoticon']!, mood['text']!);
                              },
                              child: Column(
                                children: [
                                  EmoticonFace(emoticonFace: mood['emoticon']!),
                                  SizedBox(height: 5),
                                  Text(mood['text']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  if (selectedMoodText != null)
                    Text(
                      selectedMoodText!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  SizedBox(height: 20),
                  if (selectedMood != null)
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _showAddNoteBottomSheet(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(isNoteFilled ? 'Edit Note' : 'Add Note'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Tracker History Card
            SizedBox(height: 20),

            // Tracker History Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label:
                            Text('Week', style: TextStyle(color: Colors.white)),
                        selected: true,
                        backgroundColor: Colors.indigo,
                        selectedColor: Colors.purple,
                        onSelected: (bool selected) {},
                      ),
                      ChoiceChip(
                        label: Text('Month',
                            style: TextStyle(color: Colors.white)),
                        selected: false,
                        backgroundColor: Colors.indigo,
                        onSelected: (bool selected) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Last 7 check-ins',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        bool isOccupied = index < moodEntries.length;
                        Map<String, dynamic>? moodEntry =
                            isOccupied ? moodEntries[index] : null;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: isOccupied
                                ? () =>
                                    _showMoodDetailsModal(context, moodEntry!)
                                : null,
                            child: Container(
                              width: 40,
                              decoration: BoxDecoration(
                                color: isOccupied
                                    ? _getMoodColor(moodEntry!['mood'])
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Check-ins Left Card
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock, color: Colors.white, size: 40),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '6 check-ins left',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Track your moods a bit longer to unlock the mood score',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case '😒':
        return Colors.red;
      case '😐':
        return Colors.orange;
      case '😀':
        return Colors.green;
      case '😎':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
