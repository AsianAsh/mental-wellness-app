// widgets/feedback_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/services/firestore.dart';

class FeedbackForm extends StatelessWidget {
  final TextEditingController _feedbackController = TextEditingController();

  FeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Make app better',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'What can we do to improve the ZenMate app?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Handle feedback submission
                String feedback = _feedbackController.text;
                if (feedback.isNotEmpty) {
                  // Process the feedback
                  await FirestoreService().addFeedback(feedback);
                  Get.snackbar(
                    'Thank you!',
                    'Your feedback has been submitted.',
                    backgroundColor: Colors.white60,
                  );
                  Navigator.pop(context);
                } else {
                  // Show a snack bar message if feedback is empty
                  Get.snackbar(
                    'Error',
                    'Feedback cannot be empty',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('SEND FEEDBACK'),
            ),
          ),
        ],
      ),
    );
  }
}
