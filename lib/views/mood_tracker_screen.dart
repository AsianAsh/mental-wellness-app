import 'package:flutter/material.dart';
import 'package:mental_wellness_app/util/emote_face.dart';
import 'package:intl/intl.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  bool isAddingNote = false;
  TextEditingController _noteController = TextEditingController();
  bool isNoteFilled = false;

  // TextField to write note (pops up when Add Note button is tapped)
  void _showAddNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.indigo[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _noteController,
                  onChanged: (text) {
                    setState(() {
                      isNoteFilled = text.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Write here your thoughts and emotions',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.indigo[400],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Handle note submission
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Check-in Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cloud, color: Colors.purple[300]),
                      SizedBox(width: 8),
                      Text(
                        "Today's check-in",
                        style: TextStyle(
                          color: Colors.purple[300],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'How you feeling today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Time to reflect on your day',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20),
                  SafeArea(
                    child: Column(
                      children: [
                        // Mood of the day Options
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // bad
                            Column(
                              children: [
                                EmoticonFace(emoticonFace: '😒'),
                                SizedBox(height: 5),
                                Text('Bad',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),

                            // fine
                            Column(
                              children: [
                                EmoticonFace(emoticonFace: '😐'),
                                SizedBox(height: 5),
                                Text('Fine',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),

                            // good
                            Column(
                              children: [
                                EmoticonFace(emoticonFace: '😀'),
                                SizedBox(height: 5),
                                Text('Good',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),

                            // excellent
                            Column(
                              children: [
                                EmoticonFace(emoticonFace: '😎'),
                                SizedBox(height: 5),
                                Text('Fantastic',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showAddNoteBottomSheet(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16), // Adjust the radius as needed
                          ),
                        ),
                        child: Text(isNoteFilled ? 'Edit Note' : 'Add Note'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Tracker History Card
            SizedBox(height: 20),

            // Tracker History Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label:
                            Text('Week', style: TextStyle(color: Colors.white)),
                        selected: true,
                        backgroundColor: Colors.indigo,
                        selectedColor: Colors.purple,
                        onSelected: (bool selected) {},
                      ),
                      ChoiceChip(
                        label: Text('Month',
                            style: TextStyle(color: Colors.white)),
                        selected: false,
                        backgroundColor: Colors.indigo,
                        onSelected: (bool selected) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Last 7 check-ins',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(7, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: index == 0 ? Colors.blue : Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Check-ins Left Card
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock, color: Colors.white, size: 40),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '6 check-ins left',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Track your moods a bit longer to unlock the mood score',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
