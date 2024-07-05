class SleepStory {
  final String title;
  final int duration;
  final String imagePath;
  final String audioPath;

  SleepStory({
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.audioPath,
  });

  String getDurationText() {
    return '${duration ~/ 60} min';
  }
}
