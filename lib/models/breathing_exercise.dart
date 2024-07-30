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
      imagePath: data['imagePath'] ?? 'assets/images/default_image.jpg',
      audioPath: data['audioPath'] ?? '',
    );
  }
}
