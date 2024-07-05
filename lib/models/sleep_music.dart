class SleepMusic {
  final String title;
  final int duration;
  final String audioPath;

  SleepMusic({
    required this.title,
    required this.duration,
    required this.audioPath,
  });

  String getMinSecDurationText() {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutes:$secondsStr';
  }
}
