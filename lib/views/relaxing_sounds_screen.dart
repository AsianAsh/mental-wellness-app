// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class RelaxingSoundsScreen extends StatefulWidget {
//   const RelaxingSoundsScreen({super.key});

//   @override
//   _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
// }

// class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
//   bool _controlsVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     // Make the status bar transparent
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with fixed height
//           Container(
//             height: MediaQuery.of(context).size.height *
//                 0.28, // Adjust the height as needed
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     'assets/images/test1.jpg'), // replace with your background image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top section with title, description, and image
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 16.0),
//                               child: Text(
//                                 'Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Relax Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Help for focus, relax or sleep. \nMix sounds together.',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 10), // Increased space between text and image
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25.0),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/relaxing/relaxing_sounds_4.png',
//                             height: 152, // Use original height if needed
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Sliders for different sounds
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
//                     children: [
//                       buildSoundSlider(context, 'BEACH WAVES AND BIRDS'),
//                       buildSoundSlider(context, 'FIRE'),
//                       buildSoundSlider(context, 'THUNDERSTORM'),
//                       buildSoundSlider(context, 'BIG CITY'),
//                       buildSoundSlider(context, 'BIRD CHIRPING'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: GestureDetector(
//           //     onTap: () {
//           //       if (!_controlsVisible) {
//           //         setState(() {
//           //           _controlsVisible = true;
//           //         });
//           //       }
//           //     },
//           //     child: Container(
//           //       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           //       height: 55,
//           //       decoration: BoxDecoration(
//           //         color: Colors.indigo[600],
//           //         borderRadius: const BorderRadius.only(
//           //           topLeft: Radius.circular(10),
//           //           topRight: Radius.circular(10),
//           //         ),
//           //         border: const Border(
//           //           bottom: BorderSide(
//           //             color: Colors.white12,
//           //             width: 0.5,
//           //           ),
//           //         ),
//           //       ),
//           //       child: Row(
//           //         // Change spacing alignment based on which content is shown
//           //         mainAxisAlignment: _controlsVisible
//           //             ? MainAxisAlignment.spaceBetween
//           //             : MainAxisAlignment.center,
//           //         children: _controlsVisible
//           //             ? [
//           //                 const Text(
//           //                   'Relax Sounds',
//           //                   style: TextStyle(
//           //                     color: Colors.white,
//           //                     fontSize: 14,
//           //                     fontWeight: FontWeight.bold,
//           //                   ),
//           //                 ),
//           //                 Row(
//           //                   children: [
//           //                     IconButton(
//           //                       icon: const Icon(Icons.timer_outlined,
//           //                           color: Colors.white),
//           //                       onPressed: () {
//           //                         // Timer action
//           //                       },
//           //                     ),
//           //                     IconButton(
//           //                       icon: const Icon(Icons.play_arrow_rounded,
//           //                           color: Colors.white),
//           //                       iconSize: 30,
//           //                       onPressed: () {
//           //                         // Play/Pause action
//           //                       },
//           //                     ),
//           //                   ],
//           //                 ),
//           //               ]
//           //             : [
//           //                 const Icon(Icons.play_arrow_rounded,
//           //                     color: Colors.white),
//           //                 const SizedBox(width: 5),
//           //                 const Text(
//           //                   'PLAY SOUNDS',
//           //                   style: TextStyle(
//           //                     color: Colors.white,
//           //                     fontSize: 16,
//           //                     fontWeight: FontWeight.bold,
//           //                   ),
//           //                 ),
//           //               ],
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget buildSoundSlider(BuildContext context, String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 0, 23, 34),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Icon(
//                   Icons.volume_up_outlined,
//                   color: Colors.indigo,
//                 ),
//               ],
//             ),
//             Slider(
//               value: 0.5,
//               onChanged: (value) {},
//               activeColor: Colors.indigo,
//               inactiveColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// creates relaxing sounds widget from collection and Plays audio but player has many issues
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:provider/provider.dart';

// class RelaxingSoundsScreen extends StatefulWidget {
//   RelaxingSoundsScreen({super.key});
//   final RelaxingSoundController controller = Get.put(RelaxingSoundController());

//   @override
//   _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
// }

// class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
//   bool _controlsVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     // Make the status bar transparent
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with fixed height
//           Container(
//             height: MediaQuery.of(context).size.height * 0.28,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/test1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top section with title, description, and image
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 16.0),
//                               child: Text(
//                                 'Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Relax Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Help for focus, relax or sleep. \nMix sounds together.',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25.0),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/relaxing/relaxing_sounds_4.png',
//                             height: 152,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Main play/pause button
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         widget.controller.togglePlayAll(
//                             !widget.controller.isPlayingAll.value);
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       backgroundColor: Colors.indigo[600],
//                       padding: const EdgeInsets.all(24),
//                     ),
//                     child: Icon(
//                       widget.controller.isPlayingAll.value
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 // Sliders for different sounds
//                 Expanded(
//                   child: Obx(() {
//                     if (widget.controller.isLoading.value) {
//                       return Center(child: CircularProgressIndicator());
//                     } else {
//                       return ListView(
//                         padding:
//                             const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
//                         children: widget.controller.relaxingSounds
//                             .map((sound) => SoundSlider(
//                                   sound: sound,
//                                   controller: widget.controller,
//                                 ))
//                             .toList(),
//                       );
//                     }
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SoundSlider extends StatefulWidget {
//   final RelaxingSound sound;
//   final RelaxingSoundController controller;

//   const SoundSlider({required this.sound, required this.controller});

//   @override
//   _SoundSliderState createState() => _SoundSliderState();
// }

// class _SoundSliderState extends State<SoundSlider> {
//   double _volume = 0.5;
//   bool _isEnabled = true;

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.setVolume(
//         widget.controller.relaxingSounds.indexOf(widget.sound), _volume);
//   }

//   void _toggleSound() {
//     setState(() {
//       _isEnabled = !_isEnabled;
//       widget.controller.toggleIndividualPlay(
//           widget.controller.relaxingSounds.indexOf(widget.sound), _isEnabled);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final audioPlayerState =
//         Provider.of<AudioPlayerState>(context, listen: false);

//     if (_isEnabled && audioPlayerState.isPlaying) {
//       widget.controller.toggleIndividualPlay(
//           widget.controller.relaxingSounds.indexOf(widget.sound), true);
//     } else {
//       widget.controller.toggleIndividualPlay(
//           widget.controller.relaxingSounds.indexOf(widget.sound), false);
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 0, 23, 34),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.sound.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     _isEnabled
//                         ? Icons.volume_up_outlined
//                         : Icons.volume_off_outlined,
//                     color: Colors.indigo,
//                   ),
//                   onPressed: _toggleSound,
//                 ),
//               ],
//             ),
//             Slider(
//               value: _volume,
//               onChanged: (value) {
//                 setState(() {
//                   _volume = value;
//                   widget.controller.setVolume(
//                       widget.controller.relaxingSounds.indexOf(widget.sound),
//                       _volume);
//                 });
//               },
//               activeColor: Colors.indigo,
//               inactiveColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// version 3
// reusing original no firestore data version to create each widget for relxing sound and use the persistent audio player
// only asked gpt to have a main button to play and pause everything (no individual sound disable feature)
// no chnages to any other file
// result: data displayed correctly, only one sound can be selected and played at a time but uses the correct audioplayer with title,
// pausing a specific sound widget pauses every other widget also
// relaxing_sounds.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class RelaxingSoundsScreen extends StatefulWidget {
//   const RelaxingSoundsScreen({super.key});

//   @override
//   _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
// }

// class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
//   final RelaxingSoundController _controller =
//       Get.put(RelaxingSoundController());

//   @override
//   Widget build(BuildContext context) {
//     // Make the status bar transparent
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with fixed height
//           Container(
//             height: MediaQuery.of(context).size.height * 0.28,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/test1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top section with title, description, and image
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 16.0),
//                               child: Text(
//                                 'Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Relax Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Help for focus, relax or sleep. \nMix sounds together.',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 10), // Increased space between text and image
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25.0),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/relaxing/relaxing_sounds_4.png',
//                             height: 152, // Use original height if needed
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Sliders for different sounds
//                 Expanded(
//                   child: Obx(() {
//                     if (_controller.isLoading.value) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     return ListView.builder(
//                       padding:
//                           const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
//                       itemCount: _controller.relaxingSounds.length,
//                       itemBuilder: (context, index) {
//                         return buildSoundSlider(
//                           context,
//                           _controller.relaxingSounds[index],
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSoundSlider(BuildContext context, RelaxingSound sound) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 0, 23, 34),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   sound.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Provider.of<AudioPlayerState>(context).isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.indigo,
//                   ),
//                   onPressed: () {
//                     var audioPlayerState =
//                         Provider.of<AudioPlayerState>(context, listen: false);
//                     if (audioPlayerState.isPlaying) {
//                       audioPlayerState.pauseAudio();
//                     } else {
//                       audioPlayerState.setCurrentAudioTitle(sound.title);
//                       audioPlayerState.playAudio(sound.audioPath);
//                     }
//                   },
//                 ),
//               ],
//             ),
//             Slider(
//               value: 0.5,
//               onChanged: (value) {},
//               activeColor: Colors.indigo,
//               inactiveColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Version 4: Have 1 main button to play all relaxing sounds at same time
// modify persistent audio player to play multiple audio tracks but only for relaxing sounds
// result: new button that plays/pauses all relaxing sounds BUT not displayed in bottom persistent audio player (version 3 individual controls still work)
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class RelaxingSoundsScreen extends StatefulWidget {
//   const RelaxingSoundsScreen({super.key});

//   @override
//   _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
// }

// class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
//   final RelaxingSoundController _controller =
//       Get.put(RelaxingSoundController());

//   @override
//   Widget build(BuildContext context) {
//     // Make the status bar transparent
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with fixed height
//           Container(
//             height: MediaQuery.of(context).size.height * 0.28,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/test1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top section with title, description, and image
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 16.0),
//                               child: Text(
//                                 'Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Relax Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Help for focus, relax or sleep. \nMix sounds together.',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 10), // Increased space between text and image
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25.0),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/relaxing/relaxing_sounds_4.png',
//                             height: 152, // Use original height if needed
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Main button to play/pause all relaxing sounds
//                 ElevatedButton(
//                   onPressed: () {
//                     Provider.of<AudioPlayerState>(context, listen: false)
//                         .toggleAllRelaxingSounds(_controller.audioPaths);
//                   },
//                   child: Text(
//                     Provider.of<AudioPlayerState>(context)
//                             .isPlayingAllRelaxingSounds
//                         ? 'Pause All'
//                         : 'Play All',
//                   ),
//                 ),
//                 // Sliders for different sounds
//                 Expanded(
//                   child: Obx(() {
//                     if (_controller.isLoading.value) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     return ListView.builder(
//                       padding:
//                           const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
//                       itemCount: _controller.relaxingSounds.length,
//                       itemBuilder: (context, index) {
//                         return buildSoundSlider(
//                           context,
//                           _controller.relaxingSounds[index],
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSoundSlider(BuildContext context, RelaxingSound sound) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 0, 23, 34),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   sound.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Provider.of<AudioPlayerState>(context).isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     color: Colors.indigo,
//                   ),
//                   onPressed: () {
//                     var audioPlayerState =
//                         Provider.of<AudioPlayerState>(context, listen: false);
//                     if (audioPlayerState.isPlaying) {
//                       audioPlayerState.pauseAudio();
//                     } else {
//                       audioPlayerState.setCurrentAudioTitle(sound.title);
//                       audioPlayerState.playAudio(sound.audioPath);
//                     }
//                   },
//                 ),
//               ],
//             ),
//             Slider(
//               value: 0.5,
//               onChanged: (value) {},
//               activeColor: Colors.indigo,
//               inactiveColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// version 5
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/auth/auth_screen.dart';
// import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class RelaxingSoundsScreen extends StatefulWidget {
//   const RelaxingSoundsScreen({super.key});

//   @override
//   _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
// }

// class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
//   final RelaxingSoundController _controller =
//       Get.put(RelaxingSoundController());

//   void logout(BuildContext context) {
//     FirebaseAuth.instance.signOut();
//     Get.offAll(() => const AuthScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Make the status bar transparent
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with fixed height
//           Container(
//             height: MediaQuery.of(context).size.height * 0.28,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/test1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top section with title, description, and image
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 16.0),
//                               child: Text(
//                                 'Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Relax Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Help for focus, relax or sleep. \nMix sounds together.',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 10), // Increased space between text and image
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25.0),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/relaxing/relaxing_sounds_4.png',
//                             height: 152, // Use original height if needed
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Main button to play/pause all relaxing sounds
//                 ElevatedButton(
//                   onPressed: () {
//                     Provider.of<AudioPlayerState>(context, listen: false)
//                         .toggleAllRelaxingSounds(_controller.audioPaths);
//                   },
//                   child: Text(
//                     Provider.of<AudioPlayerState>(context)
//                             .isPlayingAllRelaxingSounds
//                         ? 'Pause All'
//                         : 'Play All',
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     logout(context);
//                   },
//                   child: Text("Logout"),
//                 ),

//                 // Sliders for different sounds
//                 Expanded(
//                   child: Obx(() {
//                     if (_controller.isLoading.value) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     return ListView.builder(
//                       padding:
//                           const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
//                       itemCount: _controller.relaxingSounds.length,
//                       itemBuilder: (context, index) {
//                         return buildSoundSlider(
//                           context,
//                           _controller.relaxingSounds[index],
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSoundSlider(BuildContext context, RelaxingSound sound) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 0, 23, 34),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   sound.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             Slider(
//               value: 0.5,
//               onChanged: (value) {},
//               activeColor: Colors.indigo,
//               inactiveColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// only play 1 at a time
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/auth/auth_screen.dart';
// import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class RelaxingSoundsScreen extends StatefulWidget {
//   const RelaxingSoundsScreen({super.key});

//   @override
//   _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
// }

// class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
//   final RelaxingSoundController _controller =
//       Get.put(RelaxingSoundController());

//   @override
//   Widget build(BuildContext context) {
//     // Make the status bar transparent
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with fixed height
//           Container(
//             height: MediaQuery.of(context).size.height * 0.28,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/test1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top section with title, description, and image
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 16.0),
//                               child: Text(
//                                 'Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Relax Sounds',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Padding(
//                               padding: EdgeInsets.only(left: 4.0),
//                               child: Text(
//                                 'Help for focus, relax or sleep. \nMix sounds together.',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                           width: 10), // Increased space between text and image
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25.0),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: Image.asset(
//                             'assets/images/relaxing/relaxing_sounds_4.png',
//                             height: 152, // Use original height if needed
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Sliders for different sounds
//                 Expanded(
//                   child: Obx(() {
//                     if (_controller.isLoading.value) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     return ListView.builder(
//                       padding:
//                           const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 70.0),
//                       itemCount: _controller.relaxingSounds.length,
//                       itemBuilder: (context, index) {
//                         return buildSoundSlider(
//                           context,
//                           _controller.relaxingSounds[index],
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget buildSoundSlider(BuildContext context, RelaxingSound sound) {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 5.0),
//   //     child: Container(
//   //       padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//   //       decoration: BoxDecoration(
//   //         color: const Color.fromARGB(255, 0, 23, 34),
//   //         borderRadius: BorderRadius.circular(10),
//   //       ),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               Text(
//   //                 sound.title,
//   //                 style: const TextStyle(
//   //                   color: Colors.white,
//   //                   fontSize: 14,
//   //                   fontWeight: FontWeight.bold,
//   //                 ),
//   //               ),
//   //               IconButton(
//   //                 icon: Icon(Icons.play_circle_fill, color: Colors.white),
//   //                 onPressed: () {
//   //                   Provider.of<AudioPlayerState>(context, listen: false)
//   //                       .playAudio(sound.audioPath);
//   //                 },
//   //               ),
//   //             ],
//   //           ),
//   //           Slider(
//   //             value: 0.5,
//   //             onChanged: (value) {},
//   //             activeColor: Colors.indigo,
//   //             inactiveColor: Colors.grey,
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget buildSoundSlider(BuildContext context, RelaxingSound sound) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 0, 23, 34),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   sound.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.play_circle_fill, color: Colors.white),
//                   onPressed: () {
//                     Provider.of<AudioPlayerState>(context, listen: false)
//                         .playAudio(sound.audioPath);
//                     Provider.of<AudioPlayerState>(context, listen: false)
//                         .setCurrentAudioTitle(sound.title);
//                   },
//                 ),
//               ],
//             ),
//             Slider(
//               value: 0.5,
//               onChanged: (value) {},
//               activeColor: Colors.indigo,
//               inactiveColor: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/auth/auth_screen.dart';
import 'package:mental_wellness_app/controllers/relaxing_sound_controller.dart';
import 'package:mental_wellness_app/widgets/sound_card.dart';

class RelaxingSoundsScreen extends StatefulWidget {
  const RelaxingSoundsScreen({super.key});

  @override
  _RelaxingSoundsScreenState createState() => _RelaxingSoundsScreenState();
}

class _RelaxingSoundsScreenState extends State<RelaxingSoundsScreen> {
  final RelaxingSoundController _controller =
      Get.put(RelaxingSoundController());

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    // Make the status bar transparent
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Stack(
        children: [
          // Background image with fixed height
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/relaxing_sounds_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top section with title, description, and image
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Sounds',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Relax Sounds',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Help for focus, relax or sleep.\nImmerse yourself in calming \nnatural sounds.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Increased space between text and image
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/relaxing/relaxing_sounds_4.png',
                            height: 164, // Use original height if needed
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sound cards
                Expanded(
                  child: Obx(() {
                    if (_controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio:
                              3 / 1.5, // Adjusted the aspect ratio
                        ),
                        itemCount: _controller.relaxingSounds.length,
                        itemBuilder: (context, index) {
                          return SoundCard(
                            sound: _controller.relaxingSounds[index],
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
