// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/models/counselling_request.dart';
// import 'package:mental_wellness_app/services/firestore.dart';

// class RequestCounsellingScreen extends StatefulWidget {
//   const RequestCounsellingScreen({Key? key}) : super(key: key);

//   @override
//   _RequestCounsellingScreenState createState() =>
//       _RequestCounsellingScreenState();
// }

// class _RequestCounsellingScreenState extends State<RequestCounsellingScreen> {
//   final TextEditingController _reasonController = TextEditingController();
//   final FirestoreService _firestoreService = FirestoreService();
//   final _formKey = GlobalKey<FormState>();

//   Future<void> _submitRequest() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       User? currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser != null) {
//         CounsellingRequest request = CounsellingRequest(
//           memberId: currentUser.uid,
//           reason: _reasonController.text.trim(),
//           status: 'pending',
//           counsellorId: null,
//           requestDate: DateTime.now(),
//         );

//         await _firestoreService.createCounsellingRequest(request);

//         Get.snackbar('Success', 'Counselling request submitted successfully',
//             snackPosition: SnackPosition.BOTTOM);

//         _reasonController.clear();
//       } else {
//         Get.snackbar('Error', 'User not logged in',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Request Counselling'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Reason for Counselling',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: _reasonController,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter the reason for requesting counselling...',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Please enter a reason';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitRequest,
//                   child: Text('Submit Request'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
