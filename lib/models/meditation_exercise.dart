class MeditationExercise {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String audioPath;
  final int duration;

  MeditationExercise({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.audioPath,
    required this.duration,
  });

  String getDurationText() {
    return '${duration ~/ 60} min';
  }

  factory MeditationExercise.fromMap(Map<String, dynamic> data, String id) {
    return MeditationExercise(
      id: id,
      title: data['title'] ?? 'Untitled',
      description: data['description'] ?? 'No description',
      imagePath: data['imagePath'] ?? 'assets/images/default.jpg',
      audioPath: data['audioPath'] ?? '',
      duration: data['duration'] ?? 0,
    );
  }
}
