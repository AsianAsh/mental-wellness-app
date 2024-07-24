// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/controllers/appointment_controller.dart';
// import 'package:mental_wellness_app/models/counsellor.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:mental_wellness_app/views/counselling_screen.dart'; // Ensure you have this import

// class CounsellorDetailScreen extends StatefulWidget {
//   final Counsellor counsellor;

//   CounsellorDetailScreen({required this.counsellor});

//   @override
//   _CounsellorDetailScreenState createState() => _CounsellorDetailScreenState();
// }

// class _CounsellorDetailScreenState extends State<CounsellorDetailScreen> {
//   final AppointmentController _appointmentController =
//       Get.put(AppointmentController());
//   String? _selectedDate;
//   String? _selectedSlot;
//   String? _reason;
//   List<String> _dates = [];
//   Map<String, List<String>> _availableSlots = {};
//   bool _isBookButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadAvailableAppointments();
//   }

//   void _loadAvailableAppointments() async {
//     List<QueryDocumentSnapshot> appointments = await _appointmentController
//         .fetchCounsellorAppointments(widget.counsellor.counsellorId);
//     Map<String, List<String>> tempAvailableSlots = {};
//     Set<String> tempDates = {};

//     DateTime currentDate = DateTime.now();
//     for (var doc in appointments) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       DateTime appointmentDate = (data['date'] as Timestamp).toDate();
//       String formattedDate = DateFormat('dd MMMM yyyy').format(appointmentDate);

//       if (data['status'] == 'open' && appointmentDate.isAfter(currentDate)) {
//         if (!tempAvailableSlots.containsKey(formattedDate)) {
//           tempAvailableSlots[formattedDate] = [];
//         }
//         tempAvailableSlots[formattedDate]!.add(DateFormat('hh:mm a')
//             .format((data['startTime'] as Timestamp).toDate()));
//         tempDates.add(formattedDate);
//       }
//     }

//     setState(() {
//       _availableSlots = tempAvailableSlots;
//       _dates = tempDates.toList()..sort();
//     });
//   }

//   void _bookAppointment() async {
//     if (_selectedDate != null && _selectedSlot != null && _reason != null) {
//       bool success = await _appointmentController.bookAppointment(
//           widget.counsellor.counsellorId,
//           _selectedDate!,
//           _selectedSlot!,
//           _reason!);
//       if (success) {
//         Get.snackbar('Success', 'Appointment booked successfully',
//             snackPosition: SnackPosition.BOTTOM);
//         Get.offAll(() => CounsellingScreen());
//       } else {
//         Get.snackbar('Error', 'No available appointment found',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } else {
//       Get.snackbar(
//           'Error', 'Please select a date, timeslot and provide a reason.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   void _updateBookButtonState() {
//     setState(() {
//       _isBookButtonEnabled =
//           _selectedSlot != null && _reason != null && _reason!.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String profilePic = widget.counsellor.profilePic.isNotEmpty
//         ? widget.counsellor.profilePic
//         : 'assets/images/default_profile.png';
//     String title = widget.counsellor.title;
//     String firstName = widget.counsellor.firstName;
//     String lastName = widget.counsellor.lastName;
//     String jobTitle = widget.counsellor.jobTitle;
//     String city = widget.counsellor.city;
//     String country = widget.counsellor.country;
//     String bio = widget.counsellor.bio;
//     String email = widget.counsellor.email;
//     String education = widget.counsellor.education;
//     List<String> languages = widget.counsellor.languages;
//     int experienceYears = widget.counsellor.experienceYears;
//     String linkedin = widget.counsellor.linkedin;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointment'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage(profilePic),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Center(
//                       child: Text(
//                         '$title. $firstName $lastName',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         jobTitle,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         '$city, $country',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Biography',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(bio),
//                     SizedBox(height: 10),
//                     ExpansionTile(
//                       title: Text(
//                         'Additional Information',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       tilePadding: EdgeInsets.symmetric(horizontal: 0.0),
//                       childrenPadding: EdgeInsets.symmetric(vertical: 0.0),
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.email, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Email: $email',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.school, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Education: $education',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.language, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Languages: ${languages.join(', ')}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.work, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Years of Experience: $experienceYears',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.link, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: InkWell(
//                                 onTap: () async {
//                                   final Uri linkedinUrl = Uri.parse(linkedin);
//                                   if (await canLaunchUrl(linkedinUrl)) {
//                                     await launchUrl(linkedinUrl);
//                                   } else {
//                                     throw 'Could not launch $linkedin';
//                                   }
//                                 },
//                                 child: Text(
//                                   'LinkedIn: $linkedin',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Available Time',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     DropdownButtonFormField<String>(
//                       hint: Text('Choose day'),
//                       value: _selectedDate,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       ),
//                       items: _dates.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedDate = newValue;
//                           _selectedSlot = null; // Reset selected slot
//                           _updateBookButtonState(); // Update button state
//                         });
//                       },
//                     ),
//                     if (_selectedDate != null)
//                       Center(
//                         child: Wrap(
//                           spacing: 8.0,
//                           runSpacing: 8.0,
//                           children: (_availableSlots[_selectedDate] ?? [])
//                               .map((slot) {
//                             return ChoiceChip(
//                               label: Text(slot),
//                               selected: _selectedSlot == slot,
//                               onSelected: (bool selected) {
//                                 setState(() {
//                                   _selectedSlot = selected ? slot : null;
//                                   _updateBookButtonState(); // Update button state
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     if (_selectedDate != null)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Reason',
//                           ),
//                           onChanged: (value) {
//                             _reason = value;
//                             _updateBookButtonState(); // Update button state
//                           },
//                           maxLines: 3,
//                         ),
//                       ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _isBookButtonEnabled ? _bookAppointment : null,
//                       child: Text('Book Appointment'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: _isBookButtonEnabled
//                             ? Colors.indigo[600]
//                             : Colors.grey, // Button color
//                         minimumSize:
//                             Size(double.infinity, 36), // Full width button
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// view counsellors details and book appintment
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/controllers/appointment_controller.dart';
// import 'package:mental_wellness_app/models/counsellor.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:mental_wellness_app/views/counselling_screen.dart';

// class CounsellorDetailScreen extends StatefulWidget {
//   final Counsellor counsellor;

//   CounsellorDetailScreen({required this.counsellor});

//   @override
//   _CounsellorDetailScreenState createState() => _CounsellorDetailScreenState();
// }

// class _CounsellorDetailScreenState extends State<CounsellorDetailScreen> {
//   final AppointmentController _appointmentController =
//       Get.put(AppointmentController());
//   String? _selectedDate;
//   String? _selectedSlot;
//   String? _reason;
//   List<String> _dates = [];
//   Map<String, List<String>> _availableSlots = {};
//   bool _isBookButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadAvailableAppointments();
//   }

//   void _loadAvailableAppointments() async {
//     List<QueryDocumentSnapshot> appointments = await _appointmentController
//         .fetchCounsellorAppointments(widget.counsellor.counsellorId);
//     Map<String, List<String>> tempAvailableSlots = {};
//     Set<String> tempDates = {};

//     DateTime currentDate = DateTime.now();
//     for (var doc in appointments) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       DateTime appointmentDate = (data['date'] as Timestamp).toDate();
//       String formattedDate = DateFormat('dd MMMM yyyy').format(appointmentDate);

//       if (data['status'] == 'open' && appointmentDate.isAfter(currentDate)) {
//         if (!tempAvailableSlots.containsKey(formattedDate)) {
//           tempAvailableSlots[formattedDate] = [];
//         }
//         tempAvailableSlots[formattedDate]!.add(DateFormat('hh:mm a')
//             .format((data['startTime'] as Timestamp).toDate()));
//         tempDates.add(formattedDate);
//       }
//     }

//     setState(() {
//       _availableSlots = tempAvailableSlots;
//       _dates = tempDates.toList()..sort();
//     });
//   }

//   void _bookAppointment() async {
//     if (_selectedDate != null && _selectedSlot != null && _reason != null) {
//       bool success = await _appointmentController.bookAppointment(
//           widget.counsellor.counsellorId,
//           _selectedDate!,
//           _selectedSlot!,
//           _reason!);
//       if (success) {
//         Get.snackbar(
//           'Success',
//           'Appointment booked successfully',
//           backgroundColor: Colors.white60,
//         );
//         if (mounted)
//           Navigator.pop(context); // Navigate back to CounsellingScreen
//       } else {
//         Get.snackbar(
//           'Error',
//           'No available appointment found',
//           backgroundColor: Colors.white60,
//         );
//       }
//     } else {
//       Get.snackbar(
//         'Error',
//         'Please select a date, timeslot and provide a reason.',
//         backgroundColor: Colors.white60,
//       );
//     }
//   }

//   void _updateBookButtonState() {
//     setState(() {
//       _isBookButtonEnabled =
//           _selectedSlot != null && _reason != null && _reason!.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String profilePic = widget.counsellor.profilePic.isNotEmpty
//         ? widget.counsellor.profilePic
//         : 'assets/images/default_profile.png';
//     String title = widget.counsellor.title;
//     String firstName = widget.counsellor.firstName;
//     String lastName = widget.counsellor.lastName;
//     String jobTitle = widget.counsellor.jobTitle;
//     String city = widget.counsellor.city;
//     String country = widget.counsellor.country;
//     String bio = widget.counsellor.bio;
//     String email = widget.counsellor.email;
//     String education = widget.counsellor.education;
//     List<String> languages = widget.counsellor.languages;
//     int experienceYears = widget.counsellor.experienceYears;
//     String linkedin = widget.counsellor.linkedin;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointment'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage:
//                             profilePic != 'assets/images/default_profile.png'
//                                 ? NetworkImage(profilePic)
//                                 : AssetImage(profilePic) as ImageProvider,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Center(
//                       child: Text(
//                         '$title. $firstName $lastName',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         jobTitle,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         '$city, $country',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Biography',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(bio),
//                     SizedBox(height: 10),
//                     ExpansionTile(
//                       title: Text(
//                         'Additional Information',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       tilePadding: EdgeInsets.symmetric(horizontal: 0.0),
//                       childrenPadding: EdgeInsets.symmetric(vertical: 0.0),
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.email, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Email: $email',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.school, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Education: $education',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.language, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Languages: ${languages.join(', ')}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.work, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: Text(
//                                 'Years of Experience: $experienceYears',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(Icons.link, color: Colors.grey[700]),
//                             SizedBox(width: 10),
//                             Flexible(
//                               child: InkWell(
//                                 onTap: () async {
//                                   final Uri linkedinUrl = Uri.parse(linkedin);
//                                   if (await canLaunchUrl(linkedinUrl)) {
//                                     await launchUrl(linkedinUrl);
//                                   } else {
//                                     throw 'Could not launch $linkedin';
//                                   }
//                                 },
//                                 child: Text(
//                                   'LinkedIn: $linkedin',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Available Time',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     DropdownButtonFormField<String>(
//                       hint: Text('Choose day'),
//                       value: _selectedDate,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       ),
//                       items: _dates.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedDate = newValue;
//                           _selectedSlot = null; // Reset selected slot
//                           _updateBookButtonState(); // Update button state
//                         });
//                       },
//                     ),
//                     if (_selectedDate != null)
//                       Center(
//                         child: Wrap(
//                           spacing: 8.0,
//                           runSpacing: 8.0,
//                           children: (_availableSlots[_selectedDate] ?? [])
//                               .map((slot) {
//                             return ChoiceChip(
//                               label: Text(slot),
//                               selected: _selectedSlot == slot,
//                               onSelected: (bool selected) {
//                                 setState(() {
//                                   _selectedSlot = selected ? slot : null;
//                                   _updateBookButtonState(); // Update button state
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     if (_selectedDate != null)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Reason',
//                           ),
//                           onChanged: (value) {
//                             _reason = value;
//                             _updateBookButtonState(); // Update button state
//                           },
//                           maxLines: 3,
//                         ),
//                       ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _isBookButtonEnabled ? _bookAppointment : null,
//                       child: Text('Book Appointment'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: _isBookButtonEnabled
//                             ? Colors.indigo[600]
//                             : Colors.grey, // Button color
//                         minimumSize:
//                             Size(double.infinity, 36), // Full width button
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// modifed details display
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/controllers/appointment_controller.dart';
import 'package:mental_wellness_app/models/counsellor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mental_wellness_app/views/counselling_screen.dart';

class CounsellorDetailScreen extends StatefulWidget {
  final Counsellor counsellor;

  CounsellorDetailScreen({required this.counsellor});

  @override
  _CounsellorDetailScreenState createState() => _CounsellorDetailScreenState();
}

class _CounsellorDetailScreenState extends State<CounsellorDetailScreen> {
  final AppointmentController _appointmentController =
      Get.put(AppointmentController());
  String? _selectedDate;
  String? _selectedSlot;
  String? _reason;
  List<String> _dates = [];
  Map<String, List<String>> _availableSlots = {};
  bool _isBookButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableAppointments();
  }

  void _loadAvailableAppointments() async {
    List<QueryDocumentSnapshot> appointments = await _appointmentController
        .fetchCounsellorAppointments(widget.counsellor.counsellorId);
    Map<String, List<String>> tempAvailableSlots = {};
    Set<String> tempDates = {};

    DateTime currentDate = DateTime.now();
    for (var doc in appointments) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DateTime appointmentDate = (data['date'] as Timestamp).toDate();
      String formattedDate = DateFormat('dd MMMM yyyy').format(appointmentDate);

      if (data['status'] == 'open' && appointmentDate.isAfter(currentDate)) {
        if (!tempAvailableSlots.containsKey(formattedDate)) {
          tempAvailableSlots[formattedDate] = [];
        }
        tempAvailableSlots[formattedDate]!.add(DateFormat('hh:mm a')
            .format((data['startTime'] as Timestamp).toDate()));
        tempDates.add(formattedDate);
      }
    }

    setState(() {
      _availableSlots = tempAvailableSlots;
      _dates = tempDates.toList()..sort();
    });
  }

  void _bookAppointment() async {
    if (_selectedDate != null && _selectedSlot != null && _reason != null) {
      bool success = await _appointmentController.bookAppointment(
          widget.counsellor.counsellorId,
          _selectedDate!,
          _selectedSlot!,
          _reason!);
      if (success) {
        Get.snackbar(
          'Success',
          'Appointment booked successfully',
          backgroundColor: Colors.white60,
        );
        if (mounted)
          Navigator.pop(context); // Navigate back to CounsellingScreen
      } else {
        Get.snackbar(
          'Error',
          'No available appointment found',
          backgroundColor: Colors.white60,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please select a date, timeslot and provide a reason.',
        backgroundColor: Colors.white60,
      );
    }
  }

  void _updateBookButtonState() {
    setState(() {
      _isBookButtonEnabled =
          _selectedSlot != null && _reason != null && _reason!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    String profilePic = widget.counsellor.profilePic.isNotEmpty
        ? widget.counsellor.profilePic
        : 'assets/images/default_profile.png';
    String title = widget.counsellor.title;
    String firstName = widget.counsellor.firstName;
    String lastName = widget.counsellor.lastName;
    String jobTitle = widget.counsellor.jobTitle;
    String city = widget.counsellor.city;
    String country = widget.counsellor.country;
    String bio = widget.counsellor.bio;
    String email = widget.counsellor.email;
    String education = widget.counsellor.education;
    List<String> languages = widget.counsellor.languages;
    int experienceYears = widget.counsellor.experienceYears;
    String linkedin = widget.counsellor.linkedin;

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
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
                    ExpansionTile(
                      title: Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      tilePadding: EdgeInsets.symmetric(horizontal: 0.0),
                      childrenPadding: EdgeInsets.symmetric(vertical: 0.0),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.email, color: Colors.grey[700]),
                            SizedBox(width: 10),
                            Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                email,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.school, color: Colors.grey[700]),
                            SizedBox(width: 10),
                            Text(
                              'Education:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                education,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.language, color: Colors.grey[700]),
                            SizedBox(width: 10),
                            Text(
                              'Languages:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                languages.join(', '),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.work, color: Colors.grey[700]),
                            SizedBox(width: 10),
                            Text(
                              'Years of Experience:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '$experienceYears',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.link, color: Colors.grey[700]),
                            SizedBox(width: 10),
                            Text(
                              'LinkedIn:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  final Uri linkedinUrl =
                                      Uri.parse(_addHttpIfNeeded(linkedin));
                                  try {
                                    await launchUrl(linkedinUrl);
                                  } catch (e) {
                                    throw 'Could not launch $linkedin';
                                  }
                                },
                                child: Text(
                                  'View LinkedIn Profile',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Available Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      hint: Text('Choose day'),
                      value: _selectedDate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _dates.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDate = newValue;
                          _selectedSlot = null; // Reset selected slot
                          _updateBookButtonState(); // Update button state
                        });
                      },
                    ),
                    if (_selectedDate != null)
                      Center(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: (_availableSlots[_selectedDate] ?? [])
                              .map((slot) {
                            return ChoiceChip(
                              label: Text(slot),
                              selected: _selectedSlot == slot,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedSlot = selected ? slot : null;
                                  _updateBookButtonState(); // Update button state
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    if (_selectedDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Reason',
                          ),
                          onChanged: (value) {
                            _reason = value;
                            _updateBookButtonState(); // Update button state
                          },
                          maxLines: 3,
                        ),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isBookButtonEnabled ? _bookAppointment : null,
                      child: Text('Book Appointment'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: _isBookButtonEnabled
                            ? Colors.indigo[600]
                            : Colors.grey, // Button color
                        minimumSize:
                            Size(double.infinity, 36), // Full width button
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _addHttpIfNeeded(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }
}
