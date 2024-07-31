import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextAlign textAlign = TextAlign.justify; // text alignment

    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo, // Distinct app bar color
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to ZenMate!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'These terms and conditions outline the rules and regulations for the use of ZenMate, a mental wellness management application. By accessing this app, we assume you accept these terms and conditions. Do not continue to use ZenMate if you do not agree to take all of the terms and conditions stated on this page.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'Purpose',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'ZenMate is designed to provide mental wellness management through engaging gameplay mechanics and evidence-based interventions. Our goal is to help users achieve better mental health and well-being.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'User Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'By using ZenMate, you consent to the collection and use of the following types of data:\n\n'
                '• Email address.\n'
                '• Bio.\n'
                '• Country.\n'
                '• Current level and total points earned.\n'
                '• Daily streak information.\n'
                '• Account creation and last active timestamps.\n'
                '• First and last name.\n'
                '• Profile picture URL.\n'
                '• List of friends.\n'
                '• Earned achievements.\n'
                '• Count of completed meditation exercises.\n'
                '• Count of completed breathing exercises.\n'
                '• Count of completed sound exercises.\n'
                '• Number of friends added.\n'
                '• Number of encouraging messages sent.\n'
                '• Total daily notes.\n'
                '• Total mood entries.\n'
                '• Appointment details, including counsellor information, date, time, reason, and summary.\n\n'
                'The data collected is used to enhance the user experience, track progress, and provide personalized feedback and recommendations. We prioritize the security and confidentiality of your data.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'User Obligations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'By using ZenMate, you agree to the following obligations:\n\n'
                '• Provide accurate and complete information during the registration process.\n'
                '• Keep your account information secure and confidential.\n'
                '• Use ZenMate in a manner consistent with all applicable laws and regulations.\n'
                '• Respect the privacy and personal information of other users.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'Age Restrictions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'ZenMate is designed for users aged 13 and above. If you are under 13, you are not permitted to use ZenMate.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'In-App Interactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'Users can view each other\'s profile information, including bio, level, and achievements. However, sharing information to social media platforms is not permitted.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'If you have any questions or concerns about these terms, please contact us at zenmate.support@gmail.com.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'Changes to Terms',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'We reserve the right to update these terms and conditions at any time. Any changes will be posted on this page, and it is your responsibility to review these terms periodically.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'Termination',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'We may terminate or suspend access to ZenMate immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the terms.',
                textAlign: textAlign,
              ),
              const SizedBox(height: 20),
              const Text(
                'Governing Law',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 10),
              const Text(
                'These terms shall be governed and construed in accordance with the laws of the jurisdiction in which ZenMate operates, without regard to its conflict of law provisions.',
                textAlign: textAlign,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
