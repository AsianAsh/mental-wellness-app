class MeditationExercise {
  final String title;
  final String description;
  final String imagePath;
  final String audioPath;
  final int duration;

  const MeditationExercise({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.audioPath,
    required this.duration,
  });

  String getDurationText() {
    return '${duration ~/ 60} min';
  }
}
