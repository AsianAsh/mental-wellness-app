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

// class BreathingExercise {
//   final String title;
//   final int duration;
//   final String imagePath;
//   final String audioPath;

//   BreathingExercise({
//     required this.title,
//     required this.duration,
//     required this.imagePath,
//     required this.audioPath,
//   });

//   String getDurationText() {
//     return '${duration ~/ 60} min';
//   }

//   factory BreathingExercise.fromMap(Map<String, dynamic> data) {
//     return BreathingExercise(
//       title: data['title'] ?? 'Untitled',
//       imagePath: data['imagePath'] ?? 'assets/images/default.jpg',
//       audioPath: data['audioPath'] ?? '',
//       duration: data['duration'] ?? 0,
//     );
//   }
// }

// added id field for completion checking
class BreathingExercise {
  final String id;
  final String title;
  final int duration;
  final String imagePath;
  final String audioPath;

  BreathingExercise({
    required this.id,
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.audioPath,
  });

  String getDurationText() {
    return '${duration ~/ 60} min';
  }

  factory BreathingExercise.fromMap(Map<String, dynamic> data, String id) {
    return BreathingExercise(
      id: id,
      title: data['title'] ?? 'Untitled',
      duration: data['duration'] ?? 0,
      imagePath: data['imagePath'] ?? 'assets/images/default.jpg',
      audioPath: data['audioPath'] ?? '',
    );
  }
}
