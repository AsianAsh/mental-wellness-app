// import 'dart:math';
// import 'package:flutter/material.dart';

// class MeditationPlayScreen extends StatelessWidget {
//   const MeditationPlayScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           const SizedBox(height: 42), // Space for the transparent AppBar
//           // Duration and Flower Icon
//           Column(
//             children: [
//               Icon(
//                 Icons.spa_outlined,
//                 color: Colors.white70,
//                 size: 20,
//               ),
//               SizedBox(height: 5),
//               Text(
//                 '5 MIN',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           // Title
//           const Text(
//             'Cooking',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Vocal only',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 30),
//           // Wave Animation Placeholder
//           Container(
//             height: 150,
//             width: double.infinity,
//             // child: CustomPaint(
//             //   painter: WavePainter(0),
//             // ),
//           ),
//           const SizedBox(height: 30),
//           // Duration Slider and Time
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Slider(
//                   value: 0.2,
//                   onChanged: (value) {},
//                   activeColor: Colors.blue,
//                   inactiveColor: Colors.grey,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       '0:02',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       '4:59',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),
//           // Playback Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.replay_10_rounded),
//                 iconSize: 40,
//                 color: Colors.white,
//                 onPressed: () {},
//               ),
//               const SizedBox(width: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   // Play/Pause functionality here
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(), backgroundColor: Colors.blue,
//                   padding: EdgeInsets.all(24), // Button color
//                 ),
//                 child: Icon(
//                   Icons.play_arrow,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(width: 30),
//               IconButton(
//                 icon: const Icon(Icons.forward_10_rounded),
//                 iconSize: 40,
//                 color: Colors.white,
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//       backgroundColor: Colors.indigo[800],
//     );
//   }
// }

// With wave animation
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class MeditationPlayScreen extends StatefulWidget {
//   const MeditationPlayScreen({super.key});

//   @override
//   _MeditationPlayScreenState createState() => _MeditationPlayScreenState();
// }

// class _MeditationPlayScreenState extends State<MeditationPlayScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _sineAnimController;
//   late Animation<double> _sineAnimation;
//   bool isPlaying = true; // Track whether the animation is playing

//   @override
//   void initState() {
//     _sineAnimController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));

//     _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//         CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

//     _sineAnimController.forward();
//     _sineAnimController.repeat();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _sineAnimController.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (isPlaying) {
//         _sineAnimController.stop();
//       } else {
//         _sineAnimController.repeat();
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
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Column(
//         children: [
//           const SizedBox(height: 42), // Space for the transparent AppBar
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
//                 '5 MIN',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           // Title
//           const Text(
//             'Cooking',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Vocal only',
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
//           const SizedBox(height: 30),
//           // Duration Slider and Time
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Slider(
//                   value: 0.2,
//                   onChanged: (value) {},
//                   activeColor: Colors.blue,
//                   inactiveColor: Colors.grey,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       '0:02',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       '4:59',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),
//           // Playback Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.fast_rewind),
//                 iconSize: 40,
//                 color: Colors.white,
//                 onPressed: () {},
//               ),
//               const SizedBox(width: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     if (_sineAnimController.isAnimating) {
//                       _sineAnimController.stop();
//                     } else {
//                       _sineAnimController.repeat();
//                     }
//                     isPlaying = !isPlaying; // Toggle the isPlaying state
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(), backgroundColor: Colors.blue,
//                   padding: EdgeInsets.all(24), // Button color
//                 ),
//                 child: Icon(
//                   _sineAnimController.isAnimating
//                       ? Icons.pause
//                       : Icons.play_arrow,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(width: 30),
//               IconButton(
//                 icon: Icon(Icons.fast_forward),
//                 iconSize: 40,
//                 color: Colors.white,
//                 onPressed: () {},
//               ),
//             ],
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
//         // Colors.blue,
//         // Colors.redAccent,
//         // Colors.blue[200]!,
//         // Colors.blue[100]!,
//         // Colors.green[500]!,
//         // Colors.red[50]!,
//         // Colors.blue[100]!,
//         // Colors.blue[200]!,
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

// with actual meditation data and audio player
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';

class MeditationPlayScreen extends StatefulWidget {
  final MeditationExercise meditation;

  const MeditationPlayScreen({required this.meditation, super.key});

  @override
  _MeditationPlayScreenState createState() => _MeditationPlayScreenState();
}

class _MeditationPlayScreenState extends State<MeditationPlayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _sineAnimController;
  late Animation<double> _sineAnimation;
  bool isPlaying = true; // Track whether the animation is playing

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _sineAnimController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

    // Set the total duration from the exercise object
    _totalDuration = Duration(seconds: widget.meditation.duration);

    // Listen to audio player duration and position changes
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

    // Preload the audio file and set the total duration
    // _audioPlayer.setSourceUrl(widget.meditation.audioPath).then((_) {
    //   _audioPlayer.getDuration().then((duration) {
    //     setState(() {
    //       _totalDuration = duration!;
    //     });
    //   });
    // });

    // _audioPlayer.onPositionChanged.listen((Duration position) {
    //   setState(() {
    //     _currentDuration = position;
    //   });
    // });

    // Play audio clip on screen load
    _audioPlayer.play(AssetSource(widget.meditation.audioPath));
    // Start the sine wave animation on screen load
    _sineAnimController.forward();
    _sineAnimController.repeat();
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
        _audioPlayer.play(AssetSource(widget.meditation.audioPath));
      }
      isPlaying = !isPlaying;
    });
  }

  void _rewind10Seconds() {
    final newPosition = _currentDuration.inSeconds - 10;
    _audioPlayer.seek(Duration(seconds: max(0, newPosition)));
  }

  void _forward10Seconds() {
    final newPosition = _currentDuration.inSeconds + 10;
    _audioPlayer
        .seek(Duration(seconds: min(_totalDuration.inSeconds, newPosition)));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          const SizedBox(height: 42), // Space for the transparent AppBar
          // Duration and Flower Icon
          Column(
            children: [
              Icon(
                Icons.spa_outlined,
                color: Colors.white70,
                size: 30,
              ),
              SizedBox(height: 5),
              Text(
                widget.meditation.getDurationText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Title
          Text(
            widget.meditation.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vocal only',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          // Wave Animation
          ClipRRect(
            child: Container(
              height: 150,
              width: double.infinity,
              child: SineWaveWidget(
                animation: _sineAnimation,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Duration Slider and Time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Slider(
                  min: 0,
                  max: _totalDuration.inSeconds.toDouble(),
                  value: _currentDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_currentDuration),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _formatDuration(_totalDuration),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Playback Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.replay_10_rounded),
                iconSize: 40,
                color: Colors.white,
                onPressed: _rewind10Seconds,
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: _togglePlayPause,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(24), // Button color
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.forward_10_rounded),
                iconSize: 40,
                color: Colors.white,
                onPressed: _forward10Seconds,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.indigo[800],
    );
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
    // Create a gradient paint
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
        -size.width / 2 +
            i *
                (size.width * 1.5) /
                30, // Adjusted x position to extend beyond the canvas
        size.height / 2 +
            sin(_animation.value + i * pi / 15) * 20, // y position oscillating
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
