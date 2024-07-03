// class BreathingExercise {
//   final String title;
//   final String duration;
//   final String imagePath;
//   final String audioPath;

//   const BreathingExercise({
//     required this.title,
//     required this.duration,
//     required this.imagePath,
//     required this.audioPath,
//   });
// }

class BreathingExercise {
  final String title;
  final int duration;
  final String imagePath;
  final String audioPath;

  BreathingExercise({
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.audioPath,
  });

  String getDurationText() {
    return '${duration ~/ 60} min';
  }
}
