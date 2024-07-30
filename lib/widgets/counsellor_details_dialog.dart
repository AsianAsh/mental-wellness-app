import 'package:flutter/material.dart';
import 'package:mental_wellness_app/widgets/detail_row.dart';
import 'package:url_launcher/url_launcher.dart';

class CounsellorDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> counsellorDetails;

  const CounsellorDetailsDialog({required this.counsellorDetails});

  @override
  Widget build(BuildContext context) {
    String profilePic = counsellorDetails['profilePic'].isNotEmpty
        ? counsellorDetails['profilePic']
        : 'assets/images/default_profile.png';
    String title = counsellorDetails['title'];
    String firstName = counsellorDetails['firstName'];
    String lastName = counsellorDetails['lastName'];
    String jobTitle = counsellorDetails['jobTitle'];
    String city = counsellorDetails['city'];
    String country = counsellorDetails['country'];
    String bio = counsellorDetails['bio'];
    String email = counsellorDetails['email'];
    String education = counsellorDetails['education'];
    List<String> languages = List<String>.from(counsellorDetails['languages']);
    int experienceYears = counsellorDetails['experienceYears'];
    String linkedin = counsellorDetails['linkedin'];

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      profilePic != 'assets/images/default_profile.png'
                          ? NetworkImage(profilePic)
                          : AssetImage(profilePic) as ImageProvider,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '$title. $firstName $lastName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$city, $country',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Biography',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(bio),
              SizedBox(height: 10),
              Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              DetailRow(title: 'Email:', value: email),
              DetailRow(title: 'Education:', value: education),
              DetailRow(title: 'Languages:', value: languages.join(', ')),
              DetailRow(
                  title: 'Years of Experience:', value: '$experienceYears'),
              DetailRow(
                title: 'LinkedIn:',
                value: 'View LinkedIn Profile',
                onTap: () async {
                  final Uri linkedinUrl = Uri.parse(addHttpIfNeeded(linkedin));
                  try {
                    await launchUrl(linkedinUrl);
                  } catch (e) {
                    throw 'Could not launch $linkedin';
                  }
                },
                isLink: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String addHttpIfNeeded(String url) {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    return 'https://$url';
  }
  return url;
}
