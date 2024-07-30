import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/widgets/sine_wave_widget.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                thumbColor: Colors.white,
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                overlayColor: Colors.white.withAlpha(32),
                trackHeight: 4.0,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.indigo[800],
                ),
              ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_currentDuration),
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  _formatDuration(_totalDuration),
                  style: TextStyle(color: Colors.white70),
                ),
              ],
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
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isPlaying ? 'Pause' : 'Start',
                  style: TextStyle(
                      color: Colors.indigo[800],
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
