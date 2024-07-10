class SleepStory {
  final String id;
  final String title;
  final int duration;
  final String imagePath;
  final String audioPath;

  SleepStory({
    required this.id,
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.audioPath,
  });

  String getDurationText() {
    return '${duration ~/ 60} min';
  }

  factory SleepStory.fromMap(Map<String, dynamic> data, String id) {
    return SleepStory(
      id: id,
      title: data['title'],
      duration: data['duration'],
      imagePath: data['imagePath'],
      audioPath: data['audioPath'],
    );
  }
}
