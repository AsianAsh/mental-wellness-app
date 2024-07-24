// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:get/get.dart';
// import 'package:mental_wellness_app/controllers/appointment_controller.dart';

// class SetAppointmentsScreen extends StatefulWidget {
//   @override
//   _SetAppointmentsScreenState createState() => _SetAppointmentsScreenState();
// }

// class _SetAppointmentsScreenState extends State<SetAppointmentsScreen> {
//   final AppointmentController _appointmentController =
//       Get.put(AppointmentController());
//   DateTime _selectedDay = DateTime.now();
//   DateTime _focusedDay = DateTime.now();
//   Map<DateTime, List<String>> _selectedSlots = {};
//   final List<String> _timeSlots = [
//     '10:00 AM',
//     '10:30 AM',
//     '11:00 AM',
//     '11:30 AM',
//     '12:00 PM',
//     '12:30 PM',
//     '01:00 PM',
//     '01:30 PM',
//     '02:00 PM',
//     '02:30 PM',
//     '03:00 PM',
//     '03:30 PM',
//     '04:00 PM',
//     '04:30 PM',
//     '05:00 PM',
//     '05:30 PM',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadExistingAppointments();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _onDaySelected(_selectedDay, _focusedDay);
//     });
//   }

//   void _loadExistingAppointments() async {
//     Map<DateTime, List<String>> fetchedSlots =
//         await _appointmentController.fetchAppointments();
//     setState(() {
//       _selectedSlots = fetchedSlots;
//     });
//     print("Full Selected Slots: $_selectedSlots");
//   }

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     setState(() {
//       _selectedDay = _stripTime(selectedDay);
//       _focusedDay = _stripTime(focusedDay);
//       if (_selectedSlots[_selectedDay] == null) {
//         _selectedSlots[_selectedDay] = [];
//       }
//       print("Full Selected Slots: $_selectedSlots");
//     });
//   }

//   void _onSlotSelected(String slot) {
//     setState(() {
//       if (_selectedSlots[_selectedDay]!.contains(slot)) {
//         _selectedSlots[_selectedDay]!.remove(slot);
//       } else {
//         _selectedSlots[_selectedDay]!.add(slot);
//       }
//       print(
//           "Selected Slots for $_selectedDay: ${_selectedSlots[_selectedDay]}");
//       print("Full Selected Slots: $_selectedSlots");
//     });
//   }

//   void _saveAppointments() async {
//     await _appointmentController.saveAppointments(_selectedSlots);
//     Get.back();
//   }

//   DateTime _stripTime(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Appointments'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TableCalendar(
//               focusedDay: _focusedDay,
//               firstDay: DateTime.utc(2024, 1, 1),
//               lastDay: DateTime.utc(2030, 1, 1),
//               availableCalendarFormats: const {
//                 CalendarFormat.month: 'Month',
//               },
//               enabledDayPredicate: (date) {
//                 return date.isAfter(DateTime.now().subtract(Duration(days: 1)));
//               },
//               selectedDayPredicate: (day) {
//                 return isSameDay(_selectedDay, day);
//               },
//               onDaySelected: _onDaySelected,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Slots Available', style: TextStyle(fontSize: 16)),
//             ),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: _timeSlots.map((slot) {
//                 return ChoiceChip(
//                   label: Text(slot),
//                   selected:
//                       _selectedSlots[_selectedDay]?.contains(slot) ?? false,
//                   onSelected: (_) => _onSlotSelected(slot),
//                 );
//               }).toList(),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: _saveAppointments,
//                 child: Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.indigo[600], // Button color
//                   minimumSize: Size(double.infinity, 36), // Full width button
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// cant delete appointment docs where timeslots have been booked (staus field is "booked")
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/appointment_controller.dart';

class SetAppointmentsScreen extends StatefulWidget {
  @override
  _SetAppointmentsScreenState createState() => _SetAppointmentsScreenState();
}

class _SetAppointmentsScreenState extends State<SetAppointmentsScreen> {
  final AppointmentController _appointmentController =
      Get.put(AppointmentController());
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, Map<String, String>> _selectedSlots = {};
  final List<String> _timeSlots = [
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
  ];

  @override
  void initState() {
    super.initState();
    _loadExistingAppointments();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onDaySelected(_selectedDay, _focusedDay);
    });
  }

  void _loadExistingAppointments() async {
    Map<DateTime, Map<String, String>> fetchedSlots =
        await _appointmentController.fetchAppointments();
    setState(() {
      _selectedSlots = fetchedSlots;
    });
    print("Full Selected Slots: $_selectedSlots");
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = _stripTime(selectedDay);
      _focusedDay = _stripTime(focusedDay);
      if (_selectedSlots[_selectedDay] == null) {
        _selectedSlots[_selectedDay] = {};
      }
      print("Full Selected Slots: $_selectedSlots");
    });
  }

  void _onSlotSelected(String slot) {
    setState(() {
      if (_selectedSlots[_selectedDay]!.containsKey(slot) &&
          _selectedSlots[_selectedDay]![slot] == 'booked') {
        return; // Cannot unselect booked slots
      }

      if (_selectedSlots[_selectedDay]!.containsKey(slot)) {
        _selectedSlots[_selectedDay]!.remove(slot);
      } else {
        _selectedSlots[_selectedDay]![slot] = 'open';
      }

      print(
          "Selected Slots for $_selectedDay: ${_selectedSlots[_selectedDay]}");
      print("Full Selected Slots: $_selectedSlots");
    });
  }

  void _saveAppointments() async {
    await _appointmentController.saveAppointments(_selectedSlots);
    Get.back();
  }

  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Appointments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 1, 1),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              enabledDayPredicate: (date) {
                return date.isAfter(DateTime.now().subtract(Duration(days: 1)));
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Slots Available', style: TextStyle(fontSize: 16)),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _timeSlots.map((slot) {
                bool isBooked =
                    _selectedSlots[_selectedDay]?.containsKey(slot) ?? false;
                return ChoiceChip(
                  label: Text(slot),
                  selected: isBooked &&
                          _selectedSlots[_selectedDay]![slot] == 'booked'
                      ? true
                      : _selectedSlots[_selectedDay]?.containsKey(slot) ??
                          false,
                  onSelected: isBooked &&
                          _selectedSlots[_selectedDay]![slot] == 'booked'
                      ? null
                      : (_) => _onSlotSelected(slot),
                  selectedColor: isBooked &&
                          _selectedSlots[_selectedDay]![slot] == 'booked'
                      ? Colors.grey
                      : null,
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _saveAppointments,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo[600], // Button color
                  minimumSize: Size(double.infinity, 36), // Full width button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
