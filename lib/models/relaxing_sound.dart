class RelaxingSound {
  final String title;
  final String audioPath;

  RelaxingSound({
    required this.title,
    required this.audioPath,
  });

  factory RelaxingSound.fromMap(Map<String, dynamic> data) {
    return RelaxingSound(
      title: data['title'] ?? 'Untitled',
      audioPath: data['audioPath'] ?? '',
    );
  }
}
