import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';

class BreathingListProvider extends ChangeNotifier {
  // list of breathing exercise
  final List<BreathingExercise> _playlist = [
    BreathingExercise(
        title: "Anger",
        duration: 507,
        imagePath: "assets/images/breathing/anger.png",
        audioPath: "assets/audio/breathing/anger.mp3"),
    BreathingExercise(
        title: "Anxiety",
        duration: 343,
        imagePath: "assets/images/breathing/anxiety.png",
        audioPath: "assets/audio/breathing/anxiety.mp3"),
  ];

  int? _currentBreathingExerciseIndex = 0;

  /// GETTERS
  List<BreathingExercise> get playlist => _playlist;
  int? get currentBreathingExerciseIndex => _currentBreathingExerciseIndex;

  /// SETTERS
  set currentBreathingExerciseIndex(int? newIndex) {
    // update
    _currentBreathingExerciseIndex = newIndex;

    // update UI
    notifyListeners();
  }
}
