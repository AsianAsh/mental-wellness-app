import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/widgets/sine_wave_widget.dart';

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

    _sineAnimController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _sineAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(parent: _sineAnimController, curve: Curves.linear));

    _totalDuration = Duration(seconds: widget.meditation.duration);

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

    _audioPlayer.play(AssetSource(widget.meditation.audioPath));
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
          const SizedBox(height: 42),
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
