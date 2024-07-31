import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextAlign textAlign = TextAlign.justify;

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.white,
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for ZenMate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'At ZenMate, accessible from our mobile application, one of our main priorities is the privacy of our users. This Privacy Policy document contains types of information that is collected and recorded by ZenMate and how we use it.',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'ZenMate collects various types of personal data to enhance the user experience, track progress, and provide personalized feedback and recommendations. The data collected includes:\n\n'
                '• Unique user identifier\n'
                '• Email address\n'
                '• Bio\n'
                '• Country\n'
                '• Current level and total points earned\n'
                '• Daily streak information\n'
                '• Account creation and last active timestamps\n'
                '• First and last name\n'
                '• Profile picture URL\n'
                '• List of friends\n'
                '• Earned achievements\n'
                '• Count of completed meditation exercises\n'
                '• Count of completed breathing exercises\n'
                '• Count of completed sound exercises\n'
                '• Number of friends added\n'
                '• Number of encouraging messages sent\n'
                '• Total daily notes\n'
                '• Total mood entries\n'
                '• Appointment details, including counsellor information, date, time, reason, and summary\n',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'How We Use Your Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'ZenMate uses the collected information in various ways, including to:\n\n'
                '• Provide, operate, and maintain our application\n'
                '• Improve, personalize, and expand our application\n'
                '• Understand and analyze how you use our application\n'
                '• Develop new products, services, features, and functionalities\n'
                '• Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the application, and for marketing and promotional purposes\n'
                '• Process your transactions and manage your orders\n'
                '• Send you emails\n'
                '• Find and prevent fraud\n'
                '• Monitor and analyze usage and trends to improve your experience with the application\n',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'How We Protect Your Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'We implement a variety of security measures to maintain the safety of your personal information when you enter, submit, or access your personal information. These security measures include, but are not limited to:\n\n'
                '• Secure Socket Layer (SSL) technology to ensure that your information is fully encrypted and sent across the Internet securely\n'
                '• Regular malware scanning\n'
                '• Secure storage of personal information\n'
                '• Limited access to personal information by authorized personnel only\n',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'Sharing Your Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'We do not sell, trade, or otherwise transfer to outside parties your Personally Identifiable Information unless we provide users with advance notice. This does not include website hosting partners and other parties who assist us in operating our application, conducting our business, or serving our users, so long as those parties agree to keep this information confidential. We may also release information when it\'s release is appropriate to comply with the law, enforce our site policies, or protect ours or others\' rights, property or safety.',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'Your Consent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'By using our application, you consent to our privacy policy.',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'Changes to Our Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'If we decide to change our privacy policy, we will post those changes on this page. Policy changes will apply only to information collected after the date of the change.',
                textAlign: textAlign,
              ),
              SizedBox(height: 20),
              Text(
                'Contacting Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: textAlign,
              ),
              SizedBox(height: 10),
              Text(
                'If there are any questions regarding this privacy policy you may contact us using the information below.\n\n'
                'Email: zenmate.support@gmail.com',
                textAlign: textAlign,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
