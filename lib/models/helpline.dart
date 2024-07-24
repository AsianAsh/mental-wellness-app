class Helpline {
  final String description;
  final List<String> phones;

  Helpline({required this.description, required this.phones});

  factory Helpline.fromJson(Map<String, dynamic> json) {
    return Helpline(
      description: json['description'] as String,
      phones: List<String>.from(json['phones']),
    );
  }
}

class CountryHelpline {
  final String rawHtml;
  final List<Helpline> parsedBatches;

  CountryHelpline({required this.rawHtml, required this.parsedBatches});

  factory CountryHelpline.fromJson(Map<String, dynamic> json) {
    return CountryHelpline(
      rawHtml: json['raw_html'] as String,
      parsedBatches: (json['parsed_batches'] as List)
          .map((batch) => Helpline.fromJson(batch))
          .toList(),
    );
  }
}
