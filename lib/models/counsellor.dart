// models/counsellor.dart
class Counsellor {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String city;
  final String country;
  final String profilePic;
  final List<String> specializations;
  final String bio;
  final String email;
  final String education;
  final List<String> languages;
  final String linkedin;
  final int experienceYears;
  final String counsellorId;

  Counsellor({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.city,
    required this.country,
    required this.profilePic,
    required this.specializations,
    required this.bio,
    required this.email,
    required this.education,
    required this.languages,
    required this.linkedin,
    required this.experienceYears,
    required this.counsellorId,
  });

  factory Counsellor.fromMap(Map<String, dynamic> data) {
    return Counsellor(
      title: data['title'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      city: data['city'] ?? '',
      country: data['country'] ?? '',
      profilePic: data['profilePic'] ?? 'assets/images/default_profile.png',
      specializations: List<String>.from(data['specializations'] ?? []),
      bio: data['bio'] ?? '',
      email: data['email'] ?? '',
      education: data['education'] ?? '',
      languages: List<String>.from(data['languages'] ?? []),
      linkedin: data['linkedin'] ?? '',
      experienceYears: data['experienceYears'] ?? 0,
      counsellorId: data['counsellorId'] ?? '',
    );
  }
}
