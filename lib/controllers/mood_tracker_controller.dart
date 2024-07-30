import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/widgets/emote_face.dart';

class MoodTrackerController extends ChangeNotifier {
  bool isAddingNote = false;
  TextEditingController noteController = TextEditingController();
  bool isNoteFilled = false;
  String? selectedMood;
  String? selectedMoodText;
  List<Map<String, dynamic>> moodEntries = [];
  List<Map<String, dynamic>> allMoodEntries = [];
  final FirestoreService _firestoreService = FirestoreService();
  int remainingCheckIns = 7; // Default to 7
  double moodScorePercentage = 0.0;
  Color moodScoreColor = Colors.grey;
  bool isWeeklyView = true; // Default view is weekly

  final List<Map<String, String>> moods = [
    {'emoticon': '😒', 'text': 'Bad'},
    {'emoticon': '😐', 'text': 'Fine'},
    {'emoticon': '😀', 'text': 'Good'},
    {'emoticon': '😎', 'text': 'Fantastic'}
  ];

  void initState() {
    _loadMoodEntryForToday();
    _fetchAllMoodEntries();
    _fetchMoodEntries();
  }

  Future<void> _loadMoodEntryForToday() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot moodEntrySnapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .where('date',
              isEqualTo: DateTime.now().toIso8601String().substring(0, 10))
          .get();

      if (moodEntrySnapshot.docs.isNotEmpty) {
        var moodEntry =
            moodEntrySnapshot.docs.first.data() as Map<String, dynamic>;
        selectedMood = moodEntry['mood'];
        selectedMoodText = _getMoodText(moodEntry['mood']);
        noteController.text = moodEntry['note'];
        isNoteFilled = moodEntry['note'].isNotEmpty;
        notifyListeners();
      }
    }
  }

  String _getMoodText(String emoticon) {
    return moods.firstWhere((mood) => mood['emoticon'] == emoticon)['text']!;
  }

  Future<void> _fetchAllMoodEntries() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .orderBy('date', descending: true)
          .get();

      allMoodEntries = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      _calculateMoodScorePercentage();
      notifyListeners();
    }
  }

  Future<void> _fetchMoodEntries() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      int limit = isWeeklyView ? 7 : 30;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .orderBy('date', descending: true)
          .limit(limit)
          .get();

      moodEntries = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      remainingCheckIns = 7 - moodEntries.length;
      notifyListeners();
    }
  }

  void _calculateMoodScorePercentage() {
    int totalScore = 0;
    for (var entry in allMoodEntries) {
      totalScore += _getMoodScore(entry['mood']);
    }
    if (allMoodEntries.isNotEmpty) {
      double averageScore = totalScore / allMoodEntries.length;
      moodScorePercentage = (averageScore / 4.0) * 100;
      moodScoreColor = _getMoodScoreColor(moodScorePercentage);
    } else {
      moodScorePercentage = 0;
      moodScoreColor = Colors.grey;
    }
  }

  int _getMoodScore(String emoticon) {
    switch (emoticon) {
      case '😒':
        return 1;
      case '😐':
        return 2;
      case '😀':
        return 3;
      case '😎':
        return 4;
      default:
        return 0;
    }
  }

  Color _getMoodScoreColor(double score) {
    if (score >= 75) {
      return Colors.green;
    } else if (score >= 50) {
      return Colors.yellow;
    } else if (score >= 25) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Future<void> _saveMoodEntry(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && selectedMood != null) {
      String date = DateTime.now().toIso8601String().substring(0, 10);
      DocumentReference moodEntryRef = FirebaseFirestore.instance
          .collection('Members')
          .doc(currentUser.uid)
          .collection('mood_entries')
          .doc(date);

      DocumentSnapshot moodEntrySnapshot = await moodEntryRef.get();

      if (!moodEntrySnapshot.exists) {
        await moodEntryRef.set({
          'date': date,
          'mood': selectedMood,
          'note': noteController.text,
        });
        await _firestoreService.incrementFieldAndCheckAchievement(
            'totalMoodEntries', context);
      } else {
        await moodEntryRef.update({
          'mood': selectedMood,
          'note': noteController.text,
        });
      }
      await _firestoreService.checkAndIncrementDailyNote(
          noteController.text, context);

      await _firestoreService.updateMoodTrackerCompletion(true, context);
      await _fetchMoodEntries(); // Re-fetch the mood entries after saving
      await _fetchAllMoodEntries(); // Re-fetch all mood entries for score calculation
    }
  }

  void selectMood(String emoticon, String text, BuildContext context) {
    selectedMood = emoticon;
    selectedMoodText = text;
    _saveMoodEntry(context); // Save mood entry when a mood is selected
    notifyListeners();
  }

  void showAddNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.indigo[600],
      shape: const RoundedRectangleBorder(
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: noteController,
                  onChanged: (text) {
                    isNoteFilled = text.isNotEmpty;
                    notifyListeners();
                  },
                  decoration: InputDecoration(
                    hintText: 'Write here your thoughts and emotions',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.indigo[400],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        _saveMoodEntry(
                            context); // Save mood entry when note is added
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showMoodSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.indigo[600],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Changing your mood?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: moods.map((mood) {
                  return GestureDetector(
                    onTap: () {
                      selectMood(mood['emoticon']!, mood['text']!, context);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        EmoticonFace(emoticonFace: mood['emoticon']!),
                        const SizedBox(height: 5),
                        Text(
                          mood['text']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void showMoodDetailsModal(
      BuildContext context, Map<String, dynamic> moodEntry) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.indigo[600],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your mood on ${DateFormat.yMMMMd().format(DateTime.parse(moodEntry['date']))}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                moodEntry['mood'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              if (moodEntry['note'] != null && moodEntry['note'].isNotEmpty)
                Text(
                  moodEntry['note'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case '😒':
        return Colors.red;
      case '😐':
        return Colors.orange;
      case '😀':
        return Colors.green;
      case '😎':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void setView(bool isWeekly) {
    isWeeklyView = isWeekly;
    _fetchMoodEntries();
  }
}
