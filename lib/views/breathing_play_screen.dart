// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';

// class BreathingPlayScreen extends StatefulWidget {
//   final BreathingExercise exercise;

//   const BreathingPlayScreen({required this.exercise, super.key});

//   @override
//   _BreathingPlayScreenState createState() => _BreathingPlayScreenState();
// }

// class _BreathingPlayScreenState extends State<BreathingPlayScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _sineAnimController;
//   late Animation<double> _sineAnimation;
//   bool isPlaying = false; // Track whether the animation is playing

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the animation controller and animation
//     _sineAnimController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//         CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

//     // Set the total duration from the exercise object
//     _totalDuration = Duration(seconds: widget.exercise.duration);

//     // Listen to audio player duration and position changes
//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _totalDuration = duration;
//       });
//     });

//     _audioPlayer.onPositionChanged.listen((Duration position) {
//       setState(() {
//         _currentDuration = position;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _sineAnimController.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() async {
//     setState(() {
//       if (isPlaying) {
//         _sineAnimController.stop();
//         _audioPlayer.pause();
//       } else {
//         _sineAnimController.repeat();
//         _audioPlayer.play(AssetSource(widget.exercise.audioPath));
//       }
//       isPlaying = !isPlaying;
//     });
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false, // Remove default back button
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               iconSize: 26,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           const SizedBox(height: 65), // Space for the transparent AppBar
//           // Duration and Flower Icon
//           Column(
//             children: [
//               Icon(
//                 Icons.spa_outlined,
//                 color: Colors.white70,
//                 size: 30,
//               ),
//               SizedBox(height: 5),
//               Text(
//                 widget.exercise.getDurationText(),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           // Title
//           Text(
//             widget.exercise.title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Text(
//             'Relax and Breathe deeply',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 30),
//           // Wave Animation
//           ClipRRect(
//             child: Container(
//               height: 150,
//               width: double.infinity,
//               child: SineWaveWidget(
//                 animation: _sineAnimation,
//               ),
//             ),
//           ),
//           const SizedBox(height: 100),
//           // Audio duration progress
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 43),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // start time
//                 Text(_formatDuration(_currentDuration)),
//                 // end time
//                 Text(_formatDuration(_totalDuration)),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                 thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
//               ),
//               child: Slider(
//                 min: 0,
//                 max: _totalDuration.inSeconds.toDouble(),
//                 value: _currentDuration.inSeconds.toDouble(),
//                 onChanged: (value) {
//                   setState(() {
//                     _audioPlayer.seek(Duration(seconds: value.toInt()));
//                   });
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Start button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _togglePlayPause,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16), // Add padding for the button
//                   backgroundColor: Colors.indigo, // Button color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         16), // Adjust the radius as needed
//                   ),
//                 ),
//                 child: Text(
//                   isPlaying ? 'Pause' : 'Start',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.indigo[800],
//     );
//   }
// }

// class SineWaveWidget extends StatelessWidget {
//   final Animation<double> animation;

//   const SineWaveWidget({required this.animation, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: SinePainter(animation),
//           child: Container(),
//         );
//       },
//     );
//   }
// }

// class SinePainter extends CustomPainter {
//   final Animation<double> _animation;

//   SinePainter(this._animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     //create a gradient paint
//     Paint gradientPaint = Paint()
//       ..shader = LinearGradient(colors: [
//         Colors.white70,
//         Colors.white70,
//       ], begin: Alignment.topRight, end: Alignment.bottomLeft)
//           .createShader(Rect.fromLTWH(10, 0, size.width, size.height))
//       ..strokeWidth = 5
//       ..style = PaintingStyle.stroke;

//     Path path = Path()..moveTo(0, size.height / 2);

//     for (int i = 0; i <= 45; i++) {
//       path.lineTo(
//         -size.width / 2 +
//             i *
//                 (size.width * 1.5) /
//                 30, // Adjusted x position to extend beyond the canvas
//         size.height / 2 +
//             sin(_animation.value + i * pi / 15) * 20, // y position oscillating
//       );
//     }

//     path.lineTo(size.width, size.height / 2);

//     canvas.drawPath(path, gradientPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// pressing start button on breathing play screen will mark routine task as completed
// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class BreathingPlayScreen extends StatefulWidget {
//   final BreathingExercise exercise;

//   const BreathingPlayScreen({required this.exercise, super.key});

//   @override
//   _BreathingPlayScreenState createState() => _BreathingPlayScreenState();
// }

// class _BreathingPlayScreenState extends State<BreathingPlayScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _sineAnimController;
//   late Animation<double> _sineAnimation;
//   bool isPlaying = false; // Track whether the animation is playing

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the animation controller and animation
//     _sineAnimController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//         CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

//     // Set the total duration from the exercise object
//     _totalDuration = Duration(seconds: widget.exercise.duration);

//     // Listen to audio player duration and position changes
//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _totalDuration = duration;
//       });
//     });

//     _audioPlayer.onPositionChanged.listen((Duration position) {
//       setState(() {
//         _currentDuration = position;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _sineAnimController.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() async {
//     setState(() {
//       if (isPlaying) {
//         _sineAnimController.stop();
//         _audioPlayer.pause();
//       } else {
//         _sineAnimController.repeat();
//         _audioPlayer.play(AssetSource(widget.exercise.audioPath));
//         _markTaskAsCompleted();
//       }
//       isPlaying = !isPlaying;
//     });
//   }

//   void _markTaskAsCompleted() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference memberRef =
//           FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot memberSnapshot = await memberRef.get();

//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;
//       List<dynamic> tasks = memberData['routine']['tasks'];

//       for (var task in tasks) {
//         if (task['category'] == 'Breathe' &&
//             task['id'] == widget.exercise.id &&
//             !task['completed']) {
//           task['completed'] = true;
//           await memberRef.update({'routine.tasks': tasks});
//           break;
//         }
//       }

//       // Optionally update the count of completed breathing tasks
//       int newCount = (memberData['breathingsCompleted'] ?? 0) + 1;
//       await memberRef.update({'breathingsCompleted': newCount});
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false, // Remove default back button
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               iconSize: 26,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           const SizedBox(height: 65), // Space for the transparent AppBar
//           // Duration and Flower Icon
//           Column(
//             children: [
//               Icon(
//                 Icons.spa_outlined,
//                 color: Colors.white70,
//                 size: 30,
//               ),
//               SizedBox(height: 5),
//               Text(
//                 widget.exercise.getDurationText(),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           // Title
//           Text(
//             widget.exercise.title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Text(
//             'Relax and Breathe deeply',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 30),
//           // Wave Animation
//           ClipRRect(
//             child: Container(
//               height: 150,
//               width: double.infinity,
//               child: SineWaveWidget(
//                 animation: _sineAnimation,
//               ),
//             ),
//           ),
//           const SizedBox(height: 100),
//           // Audio duration progress
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 43),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // start time
//                 Text(_formatDuration(_currentDuration)),
//                 // end time
//                 Text(_formatDuration(_totalDuration)),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                 thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
//               ),
//               child: Slider(
//                 min: 0,
//                 max: _totalDuration.inSeconds.toDouble(),
//                 value: _currentDuration.inSeconds.toDouble(),
//                 onChanged: (value) {
//                   setState(() {
//                     _audioPlayer.seek(Duration(seconds: value.toInt()));
//                   });
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Start button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _togglePlayPause,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16), // Add padding for the button
//                   backgroundColor: Colors.indigo, // Button color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         16), // Adjust the radius as needed
//                   ),
//                 ),
//                 child: Text(
//                   isPlaying ? 'Pause' : 'Start',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.indigo[800],
//     );
//   }
// }

// class SineWaveWidget extends StatelessWidget {
//   final Animation<double> animation;

//   const SineWaveWidget({required this.animation, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: SinePainter(animation),
//           child: Container(),
//         );
//       },
//     );
//   }
// }

// class SinePainter extends CustomPainter {
//   final Animation<double> _animation;

//   SinePainter(this._animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     //create a gradient paint
//     Paint gradientPaint = Paint()
//       ..shader = LinearGradient(colors: [
//         Colors.white70,
//         Colors.white70,
//       ], begin: Alignment.topRight, end: Alignment.bottomLeft)
//           .createShader(Rect.fromLTWH(10, 0, size.width, size.height))
//       ..strokeWidth = 5
//       ..style = PaintingStyle.stroke;

//     Path path = Path()..moveTo(0, size.height / 2);

//     for (int i = 0; i <= 45; i++) {
//       path.lineTo(
//         -size.width / 2 +
//             i *
//                 (size.width * 1.5) /
//                 30, // Adjusted x position to extend beyond the canvas
//         size.height / 2 +
//             sin(_animation.value + i * pi / 15) * 20, // y position oscillating
//       );
//     }

//     path.lineTo(size.width, size.height / 2);

//     canvas.drawPath(path, gradientPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// check taskcard widget immeidately when completed is true
// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class BreathingPlayScreen extends StatefulWidget {
//   final BreathingExercise exercise;
//   final VoidCallback onComplete;

//   const BreathingPlayScreen(
//       {required this.exercise, required this.onComplete, super.key});

//   @override
//   _BreathingPlayScreenState createState() => _BreathingPlayScreenState();
// }

// class _BreathingPlayScreenState extends State<BreathingPlayScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _sineAnimController;
//   late Animation<double> _sineAnimation;
//   bool isPlaying = false;

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;

//   @override
//   void initState() {
//     super.initState();

//     _sineAnimController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//         CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

//     _totalDuration = Duration(seconds: widget.exercise.duration);

//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _totalDuration = duration;
//       });
//     });

//     _audioPlayer.onPositionChanged.listen((Duration position) {
//       setState(() {
//         _currentDuration = position;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _sineAnimController.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() async {
//     setState(() {
//       if (isPlaying) {
//         _sineAnimController.stop();
//         _audioPlayer.pause();
//       } else {
//         _sineAnimController.repeat();
//         _audioPlayer.play(AssetSource(widget.exercise.audioPath));
//         widget.onComplete();
//       }
//       isPlaying = !isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               iconSize: 26,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           const SizedBox(height: 65),
//           Column(
//             children: [
//               Icon(Icons.spa_outlined, color: Colors.white70, size: 30),
//               SizedBox(height: 5),
//               Text(
//                 widget.exercise.getDurationText(),
//                 style: TextStyle(color: Colors.white, fontSize: 10),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           Text(
//             widget.exercise.title,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const Text(
//             'Relax and Breathe deeply',
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           const SizedBox(height: 30),
//           ClipRRect(
//             child: Container(
//               height: 150,
//               width: double.infinity,
//               child: SineWaveWidget(animation: _sineAnimation),
//             ),
//           ),
//           const SizedBox(height: 100),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 43),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(_formatDuration(_currentDuration)),
//                 Text(_formatDuration(_totalDuration)),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                   thumbShape:
//                       const RoundSliderThumbShape(enabledThumbRadius: 0)),
//               child: Slider(
//                 min: 0,
//                 max: _totalDuration.inSeconds.toDouble(),
//                 value: _currentDuration.inSeconds.toDouble(),
//                 onChanged: (value) {
//                   setState(() {
//                     _audioPlayer.seek(Duration(seconds: value.toInt()));
//                   });
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _togglePlayPause,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16),
//                   backgroundColor: Colors.indigo,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: Text(
//                   isPlaying ? 'Pause' : 'Start',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.indigo[800],
//     );
//   }

//   void _markTaskAsCompleted() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference memberRef =
//           FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot memberSnapshot = await memberRef.get();

//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;
//       List<dynamic> tasks = memberData['routine']['tasks'];

//       for (var task in tasks) {
//         if (task['category'] == 'Breathe' &&
//             task['id'] == widget.exercise.id &&
//             !task['completed']) {
//           task['completed'] = true;
//           await memberRef.update({'routine.tasks': tasks});
//           break;
//         }
//       }

//       // Optionally update the count of completed breathing tasks
//       int newCount = (memberData['breathingsCompleted'] ?? 0) + 1;
//       await memberRef.update({'breathingsCompleted': newCount});
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }

// class SineWaveWidget extends StatelessWidget {
//   final Animation<double> animation;

//   const SineWaveWidget({required this.animation, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: SinePainter(animation),
//           child: Container(),
//         );
//       },
//     );
//   }
// }

// class SinePainter extends CustomPainter {
//   final Animation<double> _animation;

//   SinePainter(this._animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     //create a gradient paint
//     Paint gradientPaint = Paint()
//       ..shader = LinearGradient(colors: [
//         Colors.white70,
//         Colors.white70,
//       ], begin: Alignment.topRight, end: Alignment.bottomLeft)
//           .createShader(Rect.fromLTWH(10, 0, size.width, size.height))
//       ..strokeWidth = 5
//       ..style = PaintingStyle.stroke;

//     Path path = Path()..moveTo(0, size.height / 2);

//     for (int i = 0; i <= 45; i++) {
//       path.lineTo(
//         -size.width / 2 +
//             i *
//                 (size.width * 1.5) /
//                 30, // Adjusted x position to extend beyond the canvas
//         size.height / 2 +
//             sin(_animation.value + i * pi / 15) * 20, // y position oscillating
//       );
//     }

//     path.lineTo(size.width, size.height / 2);

//     canvas.drawPath(path, gradientPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// affected by: standardize breathingexercise to follow MVC
// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/services/firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class BreathingPlayScreen extends StatefulWidget {
//   final BreathingExercise exercise;
//   final VoidCallback onComplete;

//   const BreathingPlayScreen(
//       {required this.exercise, required this.onComplete, super.key});

//   @override
//   _BreathingPlayScreenState createState() => _BreathingPlayScreenState();
// }

// class _BreathingPlayScreenState extends State<BreathingPlayScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _sineAnimController;
//   late Animation<double> _sineAnimation;
//   bool isPlaying = false;

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;

//   @override
//   void initState() {
//     super.initState();

//     _sineAnimController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//         CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

//     _totalDuration = Duration(seconds: widget.exercise.duration);

//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _totalDuration = duration;
//       });
//     });

//     _audioPlayer.onPositionChanged.listen((Duration position) {
//       setState(() {
//         _currentDuration = position;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _sineAnimController.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() async {
//     setState(() {
//       if (isPlaying) {
//         _sineAnimController.stop();
//         _audioPlayer.pause();
//       } else {
//         _sineAnimController.repeat();
//         _audioPlayer.play(AssetSource(widget.exercise.audioPath));
//         widget.onComplete();
//       }
//       isPlaying = !isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               iconSize: 26,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           const SizedBox(height: 65),
//           Column(
//             children: [
//               Icon(Icons.spa_outlined, color: Colors.white70, size: 30),
//               SizedBox(height: 5),
//               Text(
//                 widget.exercise.getDurationText(),
//                 style: TextStyle(color: Colors.white, fontSize: 10),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           Text(
//             widget.exercise.title,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const Text(
//             'Relax and Breathe deeply',
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           const SizedBox(height: 30),
//           ClipRRect(
//             child: Container(
//               height: 150,
//               width: double.infinity,
//               child: SineWaveWidget(animation: _sineAnimation),
//             ),
//           ),
//           const SizedBox(height: 100),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 43),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(_formatDuration(_currentDuration)),
//                 Text(_formatDuration(_totalDuration)),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                   thumbShape:
//                       const RoundSliderThumbShape(enabledThumbRadius: 0)),
//               child: Slider(
//                 min: 0,
//                 max: _totalDuration.inSeconds.toDouble(),
//                 value: _currentDuration.inSeconds.toDouble(),
//                 onChanged: (value) {
//                   setState(() {
//                     _audioPlayer.seek(Duration(seconds: value.toInt()));
//                   });
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _togglePlayPause,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.all(16),
//                   backgroundColor: Colors.indigo,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: Text(
//                   isPlaying ? 'Pause' : 'Start',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.indigo[800],
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }

// class SineWaveWidget extends StatelessWidget {
//   final Animation<double> animation;

//   const SineWaveWidget({required this.animation, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: SinePainter(animation),
//           child: Container(),
//         );
//       },
//     );
//   }
// }

// class SinePainter extends CustomPainter {
//   final Animation<double> _animation;

//   SinePainter(this._animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint gradientPaint = Paint()
//       ..shader = LinearGradient(colors: [
//         Colors.white70,
//         Colors.white70,
//       ], begin: Alignment.topRight, end: Alignment.bottomLeft)
//           .createShader(Rect.fromLTWH(10, 0, size.width, size.height))
//       ..strokeWidth = 5
//       ..style = PaintingStyle.stroke;

//     Path path = Path()..moveTo(0, size.height / 2);

//     for (int i = 0; i <= 45; i++) {
//       path.lineTo(
//         -size.width / 2 + i * (size.width * 1.5) / 30,
//         size.height / 2 + sin(_animation.value + i * pi / 15) * 20,
//       );
//     }

//     path.lineTo(size.width, size.height / 2);

//     canvas.drawPath(path, gradientPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// add increment and flag to check increment breathingsCompleted field only once
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class BreathingPlayScreen extends StatefulWidget {
  final BreathingExercise exercise;
  final VoidCallback onComplete;

  const BreathingPlayScreen({
    required this.exercise,
    required this.onComplete,
    super.key,
  });

  @override
  _BreathingPlayScreenState createState() => _BreathingPlayScreenState();
}

class _BreathingPlayScreenState extends State<BreathingPlayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _sineAnimController;
  late Animation<double> _sineAnimation;
  bool isPlaying = false;
  bool hasIncremented = false; // Flag to ensure increment only happens once

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    _sineAnimController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

    _totalDuration = Duration(seconds: widget.exercise.duration);

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentDuration = position;
      });
    });
  }

  @override
  void dispose() {
    _sineAnimController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    setState(() {
      if (isPlaying) {
        _sineAnimController.stop();
        _audioPlayer.pause();
      } else {
        _sineAnimController.repeat();
        _audioPlayer.play(AssetSource(widget.exercise.audioPath));

        if (!hasIncremented) {
          FirestoreService().incrementFieldAndCheckAchievement(
              'breathingsCompleted', context);
          hasIncremented = true; // Set the flag to true
          widget.onComplete();
        }
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.close),
              iconSize: 26,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          const SizedBox(height: 65),
          Column(
            children: [
              Icon(Icons.spa_outlined, color: Colors.white70, size: 30),
              SizedBox(height: 5),
              Text(
                widget.exercise.getDurationText(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            widget.exercise.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Relax and Breathe deeply',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            child: Container(
              height: 150,
              width: double.infinity,
              child: SineWaveWidget(animation: _sineAnimation),
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_currentDuration)),
                Text(_formatDuration(_totalDuration)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0)),
              child: Slider(
                min: 0,
                max: _totalDuration.inSeconds.toDouble(),
                value: _currentDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _audioPlayer.seek(Duration(seconds: value.toInt()));
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _togglePlayPause,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isPlaying ? 'Pause' : 'Start',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.indigo[800],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class SineWaveWidget extends StatelessWidget {
  final Animation<double> animation;

  const SineWaveWidget({required this.animation, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SinePainter(animation),
          child: Container(),
        );
      },
    );
  }
}

class SinePainter extends CustomPainter {
  final Animation<double> _animation;

  SinePainter(this._animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint gradientPaint = Paint()
      ..shader = LinearGradient(colors: [
        Colors.white70,
        Colors.white70,
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)
          .createShader(Rect.fromLTWH(10, 0, size.width, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Path path = Path()..moveTo(0, size.height / 2);

    for (int i = 0; i <= 45; i++) {
      path.lineTo(
        -size.width / 2 + i * (size.width * 1.5) / 30,
        size.height / 2 + sin(_animation.value + i * pi / 15) * 20,
      );
    }

    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
