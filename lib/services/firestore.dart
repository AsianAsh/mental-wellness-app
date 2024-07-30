// import 'dart:convert';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/models/helpline.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:mental_wellness_app/models/sleep_music.dart';
// import 'package:mental_wellness_app/models/sleep_story.dart';
// import 'package:mental_wellness_app/widgets/achievement_dialog.dart';
// import 'package:mental_wellness_app/widgets/level_up_dialog.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Singleton pattern to ensure only one instance of FirestoreService is created
//   static final FirestoreService _instance = FirestoreService._internal();
//   factory FirestoreService() {
//     return _instance;
//   }
//   FirestoreService._internal();

//   User? get _currentUser => FirebaseAuth.instance.currentUser;

//   /// Method to get user details
//   Future<DocumentSnapshot<Map<String, dynamic>>> getMemberDetails() async {
//     User? currentUser = _currentUser; // current logged in user
//     if (currentUser != null) {
//       return await _firestore.collection("Members").doc(currentUser.uid).get();
//     } else {
//       throw Exception("Member not logged in");
//     }
//   }

//   /// Add member feedback message to Feedback collection in Firestore DB
//   Future<void> addFeedback(String feedback) async {
//     User? currentUser = _currentUser;
//     if (currentUser != null) {
//       await _firestore.collection('feedback').add({
//         'memberId': currentUser.uid,
//         'feedback': feedback,
//         'createdAt': Timestamp.now(),
//       });
//     }
//   }

//   /// Method to update member details in Firestore
//   Future<void> updateMemberDetails(Map<String, dynamic> updatedData) async {
//     User? currentUser = _currentUser;
//     if (currentUser != null) {
//       await _firestore
//           .collection("Members")
//           .doc(currentUser.uid)
//           .update(updatedData);
//     } else {
//       throw Exception("Member not logged in");
//     }
//   }

//   /// Method to fetch all available breathing exercises from Firestore
//   Future<List<BreathingExercise>> fetchBreathingExercises() async {
//     try {
//       QuerySnapshot querySnapshot =
//           await _firestore.collection('breathing_exercise').get();
//       return querySnapshot.docs.map((doc) {
//         return BreathingExercise.fromMap(
//             doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     } catch (e) {
//       print('Error fetching breathing exercises: $e');
//       return [];
//     }
//   }

//   // /// Method to fetch all available meditation exercises from Firestore
//   // Does same thing but better + adds id field
//   Future<List<MeditationExercise>> fetchMeditationExercises() async {
//     try {
//       QuerySnapshot querySnapshot =
//           await _firestore.collection('meditation_exercise').get();
//       return querySnapshot.docs.map((doc) {
//         return MeditationExercise.fromMap(
//             doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     } catch (e) {
//       print('Error fetching meditation exercises: $e');
//       return [];
//     }
//   }

//   /// Method to fetch all available sleep stories from Firestore
//   Future<List<SleepStory>> fetchSleepStories() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('sleep_story').get();
//     return querySnapshot.docs.map((doc) {
//       return SleepStory.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//     }).toList();
//   }

//   /// Method to fetch a specific sleep story by ID
//   Future<SleepStory?> getSleepStoryById(String id) async {
//     try {
//       DocumentSnapshot doc =
//           await _firestore.collection('sleep_story').doc(id).get();
//       if (doc.exists) {
//         return SleepStory.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching sleep story: $e');
//       return null;
//     }
//   }

//   /// Method to fetch all available sleep music from Firestore
//   Future<List<SleepMusic>> fetchSleepMusic() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('sleep_music').get();
//     return querySnapshot.docs.map((doc) {
//       return SleepMusic(
//         title: doc['title'],
//         audioPath: doc['audioPath'],
//         duration: doc['duration'],
//       );
//     }).toList();
//   }

//   /// Method to fetch all available relaxing background noises/sounds from Firestore
//   Future<List<RelaxingSound>> fetchRelaxingSounds() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('relaxing_sound').get();
//     return querySnapshot.docs.map((doc) {
//       return RelaxingSound(
//         title: doc['title'],
//         audioPath: doc['audioPath'],
//       );
//     }).toList();
//   }

//   // Create/update routine field in Member doc
//   Future<void> updateDailyRoutine() async {
//     User? currentUser = _currentUser;
//     if (currentUser != null) {
//       print('Current user tracked is: ${currentUser.email}');
//       DocumentReference memberRef =
//           _firestore.collection('Members').doc(currentUser.uid);

//       DocumentSnapshot memberSnapshot = await memberRef.get();
//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>? ?? {};

//       String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

//       bool allTasksCompleted = true;

//       if (memberData['routine'] == null ||
//           memberData['routine']['date'] != todayDate) {
//         if (memberData['routine'] != null) {
//           // Check if all tasks for the previous day are completed
//           List<dynamic> tasks = memberData['routine']['tasks'];
//           for (var task in tasks) {
//             if (!task['completed']) {
//               allTasksCompleted = false;
//               break;
//             }
//           }

//           if (!allTasksCompleted) {
//             // Reset daily streak to 0 if not all tasks are completed
//             await memberRef.update({'dailyStreak': 0});
//             print('Daily streak reset to 0');
//           }
//         }

//         print('Creating a new routine');
//         String newBreathingExerciseId =
//             await _getRandomDocumentId('breathing_exercise');
//         String newMeditationExerciseId =
//             await _getRandomDocumentId('meditation_exercise');
//         String newSleepStoryId = await _getRandomDocumentId('sleep_story');

//         print('Breathe id: $newBreathingExerciseId');
//         print('Meditation id: $newMeditationExerciseId');
//         print('Sleep Story id: $newSleepStoryId');
//         Map<String, dynamic> newRoutine = {
//           'date': todayDate,
//           'streakUpdated': false,
//           'tasks': [
//             {
//               'category': 'Breathe',
//               'completed': false,
//               'id': newBreathingExerciseId
//             },
//             {
//               'category': 'Meditation',
//               'completed': false,
//               'id': newMeditationExerciseId
//             },
//             {
//               'category': 'Sleep Story',
//               'completed': false,
//               'id': newSleepStoryId
//             },
//             {
//               'category': 'Mood Tracker',
//               'completed': false,
//             },
//           ]
//         };

//         await memberRef.update({'routine': newRoutine});
//         print('Successfully added new routine: $newRoutine');
//       }
//     } else {
//       throw Exception("User not logged in");
//     }
//   }

//   // select random document in provided collection argument
//   Future<String> _getRandomDocumentId(String collectionName) async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection(collectionName).get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     Random random = Random();
//     int randomIndex = random.nextInt(documents.length);
//     return documents[randomIndex].id;
//   }

//   // Fetch a breathing exercise document by its ID
//   Future<BreathingExercise?> getBreathingExerciseById(String id) async {
//     try {
//       DocumentSnapshot doc =
//           await _firestore.collection('breathing_exercise').doc(id).get();
//       if (doc.exists) {
//         return BreathingExercise.fromMap(
//             doc.data() as Map<String, dynamic>, doc.id);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching breathing exercise: $e');
//       return null;
//     }
//   }

//   // Fetch a meditation exercise document by its ID
//   Future<MeditationExercise?> getMeditationExerciseById(String id) async {
//     try {
//       DocumentSnapshot doc =
//           await _firestore.collection('meditation_exercise').doc(id).get();
//       if (doc.exists) {
//         return MeditationExercise.fromMap(
//             doc.data() as Map<String, dynamic>, doc.id);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching meditation exercise: $e');
//       return null;
//     }
//   }

//   // update Member document's routine map field based on which task category was completed
//   Future<void> updateTaskCompletion(String taskId, String category,
//       bool completed, BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference memberRef =
//           _firestore.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot memberSnapshot = await memberRef.get();

//       if (memberSnapshot.exists) {
//         Map<String, dynamic> memberData =
//             memberSnapshot.data() as Map<String, dynamic>;
//         Map<String, dynamic> routine = memberData['routine'];
//         List<dynamic> tasks = routine['tasks'];

//         bool taskIsDailyTask = false;
//         bool taskIsCompleted = false;

//         for (var task in tasks) {
//           if (task['category'] == category && task['id'] == taskId) {
//             taskIsDailyTask = true;
//             taskIsCompleted = task['completed'];
//             task['completed'] = completed;
//             break;
//           }
//         }

//         await memberRef.update({'routine.tasks': tasks});

//         await _checkAndUpdateDailyStreak(memberRef, routine, context);

//         if (!context.mounted) return; // Check if the context is still mounted

//         if (taskIsDailyTask && !taskIsCompleted && completed) {
//           await awardPoints(100, context); // Award points for task completion
//         }
//       }
//     }
//   }

//   // similar to updateTaskCompletion but specifically for Mood Tracker category
//   Future<void> updateMoodTrackerCompletion(
//       bool completed, BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference memberRef =
//           _firestore.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot memberSnapshot = await memberRef.get();

//       if (memberSnapshot.exists) {
//         Map<String, dynamic> memberData =
//             memberSnapshot.data() as Map<String, dynamic>;
//         Map<String, dynamic> routine = memberData['routine'];
//         List<dynamic> tasks = routine['tasks'];

//         for (var task in tasks) {
//           if (task['category'] == 'Mood Tracker') {
//             task['completed'] = completed;
//             break;
//           }
//         }

//         await memberRef.update({'routine.tasks': tasks});

//         await _checkAndUpdateDailyStreak(memberRef, routine, context);

//         if (!context.mounted) return; // Check if the context is still mounted

//         await awardPoints(100, context); // Award points for task completion
//       }
//     }
//   }

//   // Update lastActive field in either Members or counsellors document
//   Future<void> updateLastActive() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference memberDocRef =
//           _firestore.collection('Members').doc(currentUser.uid);
//       DocumentReference counselorDocRef =
//           _firestore.collection('Counsellors').doc(currentUser.uid);

//       DocumentSnapshot memberDocSnapshot = await memberDocRef.get();
//       DocumentSnapshot counselorDocSnapshot = await counselorDocRef.get();

//       if (memberDocSnapshot.exists) {
//         print("update last active for member");
//         await memberDocRef.update({
//           'lastActive': Timestamp.now(),
//         });
//       } else if (counselorDocSnapshot.exists) {
//         print("update last active for counsellor");
//         await counselorDocRef.update({
//           'lastActive': Timestamp.now(),
//         });
//       } else {
//         print("Document does not exist for both Member and Counsellor.");
//         // Do not create a new document here to avoid creating a member document mistakenly
//       }
//     }
//   }

//   // Create new document in counsellors collection
//   Future<void> createCounsellorDocument(
//     UserCredential userCredential,
//     String? title,
//     String firstName,
//     String lastName,
//     String bio,
//     String education,
//     String city,
//     String country,
//     List<String> languages,
//     int experienceYears,
//     String linkedin,
//     List<String> specializations,
//     String jobTitle,
//   ) async {
//     if (userCredential != null && userCredential.user != null) {
//       await _firestore
//           .collection("counsellors")
//           .doc(userCredential.user!.uid)
//           .set({
//         'counsellorId': userCredential.user!.uid,
//         'email': userCredential.user!.email,
//         'title': title,
//         'firstName': capitalize(firstName),
//         'lastName': capitalize(lastName),
//         'bio': bio,
//         'education': education,
//         'city': city,
//         'country': country,
//         'languages': languages,
//         'experienceYears': experienceYears,
//         'linkedin': linkedin,
//         'specializations': specializations,
//         'jobTitle': jobTitle,
//         'joinedAt': Timestamp.now(),
//         'profilePic': '',
//         'availability': {},
//         'status': 'active',
//       });
//     }
//   }

//   String capitalize(String name) {
//     return name.split(' ').map((word) {
//       if (word.isNotEmpty) {
//         return word[0].toUpperCase() + word.substring(1).toLowerCase();
//       } else {
//         return '';
//       }
//     }).join(' ');
//   }

//   // helps to constantly update daily routine contents when data changes
//   Stream<DocumentSnapshot> getRoutineStream() {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       return _firestore.collection('Members').doc(currentUser.uid).snapshots();
//     }
//     throw Exception("Member not logged in");
//   }

//   Future<List<Map<String, dynamic>>> getActiveCounsellors() async {
//     QuerySnapshot querySnapshot = await _firestore
//         .collection('counsellors')
//         .where('status', isEqualTo: 'active')
//         .get();

//     return querySnapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList();
//   }

//   // Get the helplines data
//   Future<Map<String, CountryHelpline>> loadHelplines() async {
//     final jsonString = await rootBundle.loadString('assets/helplines.json');
//     final Map<String, dynamic> jsonResponse = json.decode(jsonString);
//     return jsonResponse.map(
//         (country, data) => MapEntry(country, CountryHelpline.fromJson(data)));
//   }

//   Future<void> sendNudge(String friendId, String message, String icon,
//       BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     try {
//       // Fetch sender's full name from Firestore
//       DocumentSnapshot senderSnapshot =
//           await _firestore.collection('Members').doc(currentUser.uid).get();
//       String senderName =
//           "${senderSnapshot['firstName']} ${senderSnapshot['lastName']}";

//       await _firestore
//           .collection('Members')
//           .doc(friendId)
//           .collection('nudges')
//           .add({
//         'senderId': currentUser.uid,
//         'senderName': senderName,
//         'message': message,
//         'icon': icon,
//         'timestamp': FieldValue.serverTimestamp(),
//         'read': false,
//       });

//       // Increment encouragingMessagesSent and check achievements
//       await incrementFieldAndCheckAchievement(
//           'encouragingMessagesSent', context);

//       Get.snackbar(
//         "Success",
//         "Nudge sent successfully",
//         backgroundColor: Colors.white60,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to send nudge",
//         backgroundColor: Colors.white60,
//       );
//     }
//   }

//   // Check if all tasks in Member document's routine map field were completed, if so, increment daily streak and award points
//   Future<void> _checkAndUpdateDailyStreak(DocumentReference memberRef,
//       Map<String, dynamic> routine, BuildContext context) async {
//     bool allTasksCompleted = true;
//     bool streakUpdated = routine['streakUpdated'] ?? false;

//     for (var task in routine['tasks']) {
//       print(
//           'Checking task: ${task['category']}, completed: ${task['completed']}');
//       if (!task['completed']) {
//         allTasksCompleted = false;
//       }
//     }

//     if (allTasksCompleted && !streakUpdated) {
//       await memberRef.update({
//         'dailyStreak': FieldValue.increment(1),
//         'routine.streakUpdated': true,
//       });
//       print('All tasks completed. Daily streak incremented.');

//       // Fetch updated daily streak
//       DocumentSnapshot updatedSnapshot = await memberRef.get();
//       int updatedDailyStreak = updatedSnapshot['dailyStreak'] ?? 0;

//       // Award 200 points for completing all tasks with the new daily streak multiplier
//       double multiplier = calculateMultiplier(updatedDailyStreak);
//       int bonusPoints = (200 * multiplier).round();

//       // Award points
//       await awardPoints(bonusPoints, context);
//       print('Awarded points due to completing all daily tasks: $bonusPoints');

//       print('Bonus points awarded: $bonusPoints');

//       // Check and award daily streak achievement
//       await checkAndAwardAchievement('dailyStreak', context);
//     } else {
//       print('Not all tasks completed or streak already updated.');
//     }
//   }

//   ///
//   ///
//   /// The below functions for updating Members document fields related to tracking achivements eligibility + point distribution
//   ///
//   ///

//   // when an action is done, increment its respective counter field then check if the counter meets achivements eligibility
//   Future<void> incrementFieldAndCheckAchievement(
//       String category, BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     DocumentReference memberRef =
//         _firestore.collection('Members').doc(currentUser.uid);

//     // Increment the specified field
//     await memberRef.update({
//       category: FieldValue.increment(1),
//     });

//     // Check and award achievements
//     await checkAndAwardAchievement(category, context);
//   }

//   // Like incrementFieldAndCheckAchievement function but specifically for totalDailyNotes field
//   Future<void> checkAndIncrementDailyNote(
//       String note, BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       String todayDate = DateTime.now().toIso8601String().substring(0, 10);
//       DocumentReference memberRef =
//           _firestore.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot memberSnapshot = await memberRef.get();

//       if (memberSnapshot.exists) {
//         Map<String, dynamic> memberData =
//             memberSnapshot.data() as Map<String, dynamic>;
//         String lastNoteDate = memberData['lastNoteDate'] ?? '';

//         if (lastNoteDate != todayDate && note.isNotEmpty) {
//           await memberRef.update({
//             'totalDailyNotes': FieldValue.increment(1),
//             'lastNoteDate': todayDate,
//           });

//           await checkAndAwardAchievement('totalDailyNotes', context);
//         }
//       }
//     }
//   }

//   // Function to check award eligiblity and award it
//   Future<void> checkAndAwardAchievement(
//       String category, BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) return;

//     DocumentSnapshot memberSnapshot =
//         await _firestore.collection('Members').doc(currentUser.uid).get();
//     Map<String, dynamic>? memberData =
//         memberSnapshot.data() as Map<String, dynamic>?;

//     if (memberData == null) return;

//     QuerySnapshot achievementsSnapshot = await _firestore
//         .collection('achievements')
//         .where('category', isEqualTo: category)
//         .get();

//     for (var achievement in achievementsSnapshot.docs) {
//       Map<String, dynamic> achievementData =
//           achievement.data() as Map<String, dynamic>;

//       String achievementId = achievement.id;
//       int threshold = achievementData['threshold'];
//       int memberFieldValue = memberData[category] ?? 0;

//       if (memberFieldValue >= threshold) {
//         // Check if the achievement is already awarded
//         QuerySnapshot memberAchievementsSnapshot = await _firestore
//             .collection('Members')
//             .doc(currentUser.uid)
//             .collection('achievements')
//             .where('achievementId', isEqualTo: achievementId)
//             .get();

//         if (memberAchievementsSnapshot.docs.isEmpty) {
//           // Award the achievement
//           await _firestore
//               .collection('Members')
//               .doc(currentUser.uid)
//               .collection('achievements')
//               .add({
//             'achievementId': achievementId,
//             'dateEarned': FieldValue.serverTimestamp(),
//           });

//           // Award points using the awardPoints function
//           int points = achievementData['points'];
//           await awardPoints(points, context);

//           // Show achievement dialog
//           if (context.mounted) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AchievementDialog(
//                   name: achievementData['name'],
//                   description: achievementData['description'],
//                   points: points,
//                   imagePath: achievementData['imagePath'],
//                 );
//               },
//             );
//           }
//         }
//       }
//     }
//   }

//   // Award points and handle level progression
//   Future<void> awardPoints(int points, BuildContext context) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference memberRef =
//           FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot memberSnapshot = await memberRef.get();
//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;

//       int currentLevel = memberData['level'] ?? 1;
//       int currentPoints = memberData['points'] ?? 0;
//       int dailyStreak = memberData['dailyStreak'] ?? 0;

//       // Calculate points with multiplier
//       double multiplier = calculateMultiplier(dailyStreak);
//       int totalPoints = (points * multiplier).round();

//       // Add points to current points
//       currentPoints += totalPoints;

//       // Check if points are enough to level up
//       int requiredPoints = calculateRequiredPoints(currentLevel);
//       bool leveledUp = false;

//       while (currentPoints >= requiredPoints) {
//         currentPoints -= requiredPoints;
//         currentLevel++;
//         requiredPoints = calculateRequiredPoints(currentLevel);
//         leveledUp = true;
//       }

//       // Update member's level and points
//       await memberRef.update({
//         'level': currentLevel,
//         'points': currentPoints,
//       });

//       print('Points awarded: $totalPoints');
//       print('New level: $currentLevel');
//       print('Remaining points: $currentPoints');

//       // Show level-up popup if leveled up
//       if (leveledUp && context.mounted) {
//         showLevelUpDialog(context, currentLevel);
//       }
//     } else {
//       throw Exception("User not logged in");
//     }
//   }

//   // Calculate multiplier based on daily streak
//   double calculateMultiplier(int dailyStreak) {
//     if (dailyStreak >= 10 && dailyStreak < 20) {
//       return 1.10;
//     } else if (dailyStreak >= 20 && dailyStreak < 30) {
//       return 1.20;
//     } else if (dailyStreak >= 30 && dailyStreak < 40) {
//       return 1.30;
//     } else if (dailyStreak >= 40 && dailyStreak < 50) {
//       return 1.40;
//     } else if (dailyStreak >= 50 && dailyStreak < 60) {
//       return 1.50;
//     } else if (dailyStreak >= 60 && dailyStreak < 70) {
//       return 1.60;
//     } else if (dailyStreak >= 70 && dailyStreak < 80) {
//       return 1.70;
//     } else if (dailyStreak >= 80 && dailyStreak < 90) {
//       return 1.80;
//     } else if (dailyStreak >= 90 && dailyStreak < 100) {
//       return 1.90;
//     } else if (dailyStreak >= 100) {
//       return 2.00;
//     }
//     return 1.0;
//   }

//   // Calculate required points for a given level
//   int calculateRequiredPoints(int level) {
//     const basePoints = 100; // Base points required for level 1
//     int points = (basePoints * pow(level, 1.05)).round();
//     print('Legacy required points for level $level: $points');
//     print(
//         'Rounded required points for level $level: ${(points / 100).floor() * 100}');
//     return (points / 100).floor() * 100;
//   }

//   // call dialog pop up to inform member of level up
//   void showLevelUpDialog(BuildContext context, int level) {
//     showDialog(
//       context: context,
//       builder: (context) => LevelUpDialog(level: level),
//     );
//   }
// }

import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/helpline.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/models/received_nudge.dart';
import 'package:mental_wellness_app/models/relaxing_sound.dart';
import 'package:mental_wellness_app/models/sleep_music.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
import 'package:mental_wellness_app/widgets/achievement_dialog.dart';
import 'package:mental_wellness_app/widgets/level_up_dialog.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton pattern to ensure only one instance of FirestoreService is created
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() {
    return _instance;
  }
  FirestoreService._internal();

  User? get _currentUser => FirebaseAuth.instance.currentUser;

  /// List of encouraging messages
  final List<String> encouragingMessages = [
    "Keep up the good work!",
    "Nice one!",
    "You're doing great!",
    "Awesome job!",
    "Fantastic effort!",
    "Keep it up!",
    "You're on fire!",
    "Well done!",
    "Great job!",
    "Excellent work!",
  ];

  /// Select a random encouraging message
  String getRandomEncouragingMessage() {
    final random = Random();
    return encouragingMessages[random.nextInt(encouragingMessages.length)];
  }

  String _capitalize(String name) {
    return name.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return '';
      }
    }).join(' ');
  }

  Future<void> createMemberDocument(
      UserCredential? userCredential, String firstName, String lastName) async {
    if (userCredential != null && userCredential.user != null) {
      await _firestore.collection("Members").doc(userCredential.user!.uid).set({
        'memberId': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'firstName': _capitalize(firstName),
        'lastName': _capitalize(lastName),
        'profilePic': '',
        'bio': '',
        'country': '',
        'level': 1,
        'points': 0,
        'dailyStreak': 0,
        'meditationsCompleted': 0,
        'breathingsCompleted': 0,
        'soundsCompleted': 0,
        'friendsAdded': 0,
        'encouragingMessagesSent': 0,
        'totalDailyNotes': 0,
        'totalMoodEntries': 0,
        'createdAt': Timestamp.now(),
        'lastActive': Timestamp.now(),
      });
    }
  }

  /// Method to get user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getMemberDetails() async {
    if (_currentUser != null) {
      return await _firestore
          .collection("Members")
          .doc(_currentUser!.uid)
          .get();
    } else {
      throw Exception("Member not logged in");
    }
  }

  Future<void> deleteAccount(String memberId, BuildContext context) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Remove references from friends subcollection
    QuerySnapshot friendsSnapshot = await FirebaseFirestore.instance
        .collection('Members')
        .doc(memberId)
        .collection('friends')
        .get();

    for (QueryDocumentSnapshot friendDoc in friendsSnapshot.docs) {
      String friendId = friendDoc.id;
      // Delete the member reference from each friend's friends subcollection
      batch.delete(FirebaseFirestore.instance
          .collection('Members')
          .doc(friendId)
          .collection('friends')
          .doc(memberId));

      // Delete the nudge documents sent by the member in each friend's nudges subcollection
      QuerySnapshot nudgesSnapshot = await FirebaseFirestore.instance
          .collection('Members')
          .doc(friendId)
          .collection('nudges')
          .where('senderId', isEqualTo: memberId)
          .get();

      for (QueryDocumentSnapshot nudgeDoc in nudgesSnapshot.docs) {
        batch.delete(nudgeDoc.reference);
      }
    }

    // Remove references from counsellors' appointments
    QuerySnapshot counsellorsSnapshot =
        await FirebaseFirestore.instance.collection('counsellors').get();

    for (QueryDocumentSnapshot counsellorDoc in counsellorsSnapshot.docs) {
      QuerySnapshot appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('counsellors')
          .doc(counsellorDoc.id)
          .collection('appointments')
          .where('bookedBy', isEqualTo: memberId)
          .get();

      for (QueryDocumentSnapshot appointmentDoc in appointmentsSnapshot.docs) {
        batch.delete(FirebaseFirestore.instance
            .collection('counsellors')
            .doc(counsellorDoc.id)
            .collection('appointments')
            .doc(appointmentDoc.id));
      }
    }

    // Remove references from feedback collection
    QuerySnapshot feedbackSnapshot = await FirebaseFirestore.instance
        .collection('feedback')
        .where('memberId', isEqualTo: memberId)
        .get();

    for (QueryDocumentSnapshot feedbackDoc in feedbackSnapshot.docs) {
      batch.delete(feedbackDoc.reference);
    }

    // Remove references from friend_requests collection
    QuerySnapshot friendRequestsSnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('receiverId', isEqualTo: memberId)
        .get();

    for (QueryDocumentSnapshot requestDoc in friendRequestsSnapshot.docs) {
      batch.delete(requestDoc.reference);
    }

    friendRequestsSnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('senderId', isEqualTo: memberId)
        .get();

    for (QueryDocumentSnapshot requestDoc in friendRequestsSnapshot.docs) {
      batch.delete(requestDoc.reference);
    }

    // Delete member document
    batch
        .delete(FirebaseFirestore.instance.collection('Members').doc(memberId));

    // Commit batch
    await batch.commit();
  }

  /// Add member feedback message to Feedback collection in Firestore DB
  Future<void> addFeedback(String feedback) async {
    if (_currentUser != null) {
      await _firestore.collection('feedback').add({
        'memberId': _currentUser!.uid,
        'feedback': feedback,
        'createdAt': Timestamp.now(),
      });
    }
  }

  /// Method to update member details in Firestore
  Future<void> updateMemberDetails(Map<String, dynamic> updatedData) async {
    if (_currentUser != null) {
      await _firestore
          .collection("Members")
          .doc(_currentUser!.uid)
          .update(updatedData);
    } else {
      throw Exception("Member not logged in");
    }
  }

  /// Method to fetch all available breathing exercises from Firestore
  Future<List<BreathingExercise>> fetchBreathingExercises() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('breathing_exercise').get();
      return querySnapshot.docs.map((doc) {
        return BreathingExercise.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching breathing exercises: $e');
      return [];
    }
  }

  /// Method to fetch all available meditation exercises from Firestore
  Future<List<MeditationExercise>> fetchMeditationExercises() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('meditation_exercise').get();
      return querySnapshot.docs.map((doc) {
        return MeditationExercise.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching meditation exercises: $e');
      return [];
    }
  }

  /// Method to fetch all available sleep stories from Firestore
  Future<List<SleepStory>> fetchSleepStories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('sleep_story').get();
      return querySnapshot.docs.map((doc) {
        return SleepStory.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching sleep stories: $e');
      return [];
    }
  }

  /// Method to fetch a specific sleep story by ID
  Future<SleepStory?> getSleepStoryById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('sleep_story').doc(id).get();
      if (doc.exists) {
        return SleepStory.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching sleep story: $e');
      return null;
    }
  }

  /// Method to fetch all available sleep music from Firestore
  Future<List<SleepMusic>> fetchSleepMusic() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('sleep_music').get();
      return querySnapshot.docs.map((doc) {
        return SleepMusic.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching sleep music: $e');
      return [];
    }
  }

  /// Method to fetch all available relaxing background noises/sounds from Firestore
  Future<List<RelaxingSound>> fetchRelaxingSounds() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('relaxing_sound').get();
      return querySnapshot.docs.map((doc) {
        return RelaxingSound.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching relaxing sounds: $e');
      return [];
    }
  }

  /// Method to get a random document ID from a collection
  Future<String> _getRandomDocumentId(String collectionName) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      Random random = Random();
      int randomIndex = random.nextInt(documents.length);
      return documents[randomIndex].id;
    } catch (e) {
      print('Error getting random document ID: $e');
      return '';
    }
  }

  /// Method to update daily routine
  Future<void> updateDailyRoutine() async {
    if (_currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(_currentUser!.uid);

      DocumentSnapshot memberSnapshot = await memberRef.get();
      Map<String, dynamic> memberData =
          memberSnapshot.data() as Map<String, dynamic>? ?? {};

      String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

      bool allTasksCompleted = true;

      if (memberData['routine'] == null ||
          memberData['routine']['date'] != todayDate) {
        if (memberData['routine'] != null) {
          List<dynamic> tasks = memberData['routine']['tasks'];
          for (var task in tasks) {
            if (!task['completed']) {
              allTasksCompleted = false;
              break;
            }
          }

          if (!allTasksCompleted) {
            await memberRef.update({'dailyStreak': 0});
            print('Daily streak reset to 0');
          }
        }

        String newBreathingExerciseId =
            await _getRandomDocumentId('breathing_exercise');
        String newMeditationExerciseId =
            await _getRandomDocumentId('meditation_exercise');
        String newSleepStoryId = await _getRandomDocumentId('sleep_story');

        Map<String, dynamic> newRoutine = {
          'date': todayDate,
          'streakUpdated': false,
          'tasks': [
            {
              'category': 'Breathe',
              'completed': false,
              'id': newBreathingExerciseId
            },
            {
              'category': 'Meditation',
              'completed': false,
              'id': newMeditationExerciseId
            },
            {
              'category': 'Sleep Story',
              'completed': false,
              'id': newSleepStoryId
            },
            {'category': 'Mood Tracker', 'completed': false},
          ],
        };

        await memberRef.update({'routine': newRoutine});
        print('Successfully added new routine: $newRoutine');
      }
    } else {
      throw Exception("User not logged in");
    }
  }

  /// Fetch a breathing exercise document by its ID
  Future<BreathingExercise?> getBreathingExerciseById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('breathing_exercise').doc(id).get();
      if (doc.exists) {
        return BreathingExercise.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching breathing exercise: $e');
      return null;
    }
  }

  /// Fetch a meditation exercise document by its ID
  Future<MeditationExercise?> getMeditationExerciseById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('meditation_exercise').doc(id).get();
      if (doc.exists) {
        return MeditationExercise.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching meditation exercise: $e');
      return null;
    }
  }

  /// Update task completion status
  Future<void> updateTaskCompletion(String taskId, String category,
      bool completed, BuildContext context) async {
    if (_currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(_currentUser!.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();

      if (memberSnapshot.exists) {
        Map<String, dynamic> memberData =
            memberSnapshot.data() as Map<String, dynamic>;
        List<dynamic> tasks = memberData['routine']['tasks'];

        for (var task in tasks) {
          if (task['category'] == category && task['id'] == taskId) {
            task['completed'] = completed;
            break;
          }
        }

        await memberRef.update({'routine.tasks': tasks});

        await _checkAndUpdateDailyStreak(
            memberRef, memberData['routine'], context);

        if (!context.mounted) return;

        if (completed) {
          await awardPoints(100, context); // Award points for task completion
        }
      }
    }
  }

  /// Update Mood Tracker task completion status
  Future<void> updateMoodTrackerCompletion(
      bool completed, BuildContext context) async {
    if (_currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(_currentUser!.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();

      if (memberSnapshot.exists) {
        Map<String, dynamic> memberData =
            memberSnapshot.data() as Map<String, dynamic>;
        List<dynamic> tasks = memberData['routine']['tasks'];

        for (var task in tasks) {
          if (task['category'] == 'Mood Tracker') {
            task['completed'] = completed;
            break;
          }
        }

        await memberRef.update({'routine.tasks': tasks});

        await _checkAndUpdateDailyStreak(
            memberRef, memberData['routine'], context);

        if (!context.mounted) return;

        await awardPoints(100, context); // Award points for task completion
      }
    }
  }

  /// Update lastActive field in either Members or Counsellors document
  Future<void> updateLastActive() async {
    if (_currentUser != null) {
      DocumentReference memberDocRef =
          _firestore.collection('Members').doc(_currentUser!.uid);
      DocumentReference counselorDocRef =
          _firestore.collection('Counsellors').doc(_currentUser!.uid);

      DocumentSnapshot memberDocSnapshot = await memberDocRef.get();
      DocumentSnapshot counselorDocSnapshot = await counselorDocRef.get();

      if (memberDocSnapshot.exists) {
        await memberDocRef.update({
          'lastActive': Timestamp.now(),
        });
      } else if (counselorDocSnapshot.exists) {
        await counselorDocRef.update({
          'lastActive': Timestamp.now(),
        });
      }
    }
  }

  /// Create new document in Counsellors collection
  Future<void> createCounsellorDocument(
    UserCredential userCredential,
    String? title,
    String firstName,
    String lastName,
    String bio,
    String education,
    String city,
    String country,
    List<String> languages,
    int experienceYears,
    String linkedin,
    List<String> specializations,
    String jobTitle,
  ) async {
    if (userCredential.user != null) {
      await _firestore
          .collection("counsellors")
          .doc(userCredential.user!.uid)
          .set({
        'counsellorId': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'title': title,
        'firstName': _capitalize(firstName),
        'lastName': _capitalize(lastName),
        'bio': bio,
        'education': education,
        'city': city,
        'country': country,
        'languages': languages,
        'experienceYears': experienceYears,
        'linkedin': linkedin,
        'specializations': specializations,
        'jobTitle': jobTitle,
        'joinedAt': Timestamp.now(),
        'profilePic': '',
        'availability': {},
        'status': 'active',
      });
    }
  }

  /// Stream to get routine updates
  Stream<DocumentSnapshot> getRoutineStream() {
    if (_currentUser != null) {
      return _firestore
          .collection('Members')
          .doc(_currentUser!.uid)
          .snapshots();
    }
    throw Exception("Member not logged in");
  }

  /// Get active counsellors
  Future<List<Map<String, dynamic>>> getActiveCounsellors() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('counsellors')
          .where('status', isEqualTo: 'active')
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching active counsellors: $e');
      return [];
    }
  }

  /// Load helplines from JSON
  Future<Map<String, CountryHelpline>> loadHelplines() async {
    try {
      final jsonString = await rootBundle.loadString('assets/helplines.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map(
          (country, data) => MapEntry(country, CountryHelpline.fromJson(data)));
    } catch (e) {
      print('Error loading helplines: $e');
      return {};
    }
  }

  /// Send a nudge
  Future<void> sendNudge(String friendId, String message, String icon,
      BuildContext context) async {
    if (_currentUser != null) {
      try {
        DocumentSnapshot senderSnapshot =
            await _firestore.collection('Members').doc(_currentUser!.uid).get();
        String senderName =
            "${senderSnapshot['firstName']} ${senderSnapshot['lastName']}";

        await _firestore
            .collection('Members')
            .doc(friendId)
            .collection('nudges')
            .add({
          'senderId': _currentUser!.uid,
          'senderName': senderName,
          'message': message,
          'icon': icon,
          'timestamp': FieldValue.serverTimestamp(),
          'read': false,
        });

        await incrementFieldAndCheckAchievement(
            'encouragingMessagesSent', context);

        // Show success message
        Get.snackbar(
          "Success",
          "Nudge sent successfully",
          backgroundColor: Colors.white60,
        );
      } catch (e) {
        // Show error message
        Get.snackbar(
          "Error",
          "Failed to send nudge",
          backgroundColor: Colors.white60,
        );
      }
    }
  }

  // Fetch nudges
  Stream<List<Nudge>> getNudges() {
    final user = _currentUser;
    if (user == null) {
      return Stream.empty();
    }

    return _firestore
        .collection('Members')
        .doc(user.uid)
        .collection('nudges')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Nudge.fromDocument(doc)).toList());
  }

  // Mark nudges as read
  Future<void> markNudgesAsRead() async {
    final user = _currentUser;
    if (user == null) return;

    final nudgeSnapshot = await _firestore
        .collection('Members')
        .doc(user.uid)
        .collection('nudges')
        .where('read', isEqualTo: false)
        .get();

    final batch = _firestore.batch();
    for (var doc in nudgeSnapshot.docs) {
      batch.update(doc.reference, {'read': true});
    }

    await batch.commit();
  }

  // Delete a specific nudge
  Future<void> deleteNudge(String nudgeId) async {
    final user = _currentUser;
    if (user == null) return;

    await _firestore
        .collection('Members')
        .doc(user.uid)
        .collection('nudges')
        .doc(nudgeId)
        .delete();
  }

  /// Check and update daily streak
  Future<void> _checkAndUpdateDailyStreak(DocumentReference memberRef,
      Map<String, dynamic> routine, BuildContext context) async {
    bool allTasksCompleted = true;
    bool streakUpdated = routine['streakUpdated'] ?? false;

    for (var task in routine['tasks']) {
      if (!task['completed']) {
        allTasksCompleted = false;
        break;
      }
    }

    if (allTasksCompleted && !streakUpdated) {
      await memberRef.update({
        'dailyStreak': FieldValue.increment(1),
        'routine.streakUpdated': true,
      });

      DocumentSnapshot updatedSnapshot = await memberRef.get();
      int updatedDailyStreak = updatedSnapshot['dailyStreak'] ?? 0;

      double multiplier = _calculateMultiplier(updatedDailyStreak);
      int bonusPoints = (200 * multiplier).round();

      await awardPoints(bonusPoints, context);

      await checkAndAwardAchievement('dailyStreak', context);

      // Show encouraging snackbar
      String randomMessage = getRandomEncouragingMessage();
      Get.snackbar(
        "Routine Completed!",
        "Your streak has increased! $randomMessage",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    }
  }

  /// Increment field and check achievement
  Future<void> incrementFieldAndCheckAchievement(
      String category, BuildContext context) async {
    if (_currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(_currentUser!.uid);

      await memberRef.update({
        category: FieldValue.increment(1),
      });

      await checkAndAwardAchievement(category, context);
    }
  }

  /// Check and increment daily note
  Future<void> checkAndIncrementDailyNote(
      String note, BuildContext context) async {
    if (_currentUser != null) {
      String todayDate = DateTime.now().toIso8601String().substring(0, 10);
      DocumentReference memberRef =
          _firestore.collection('Members').doc(_currentUser!.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();

      if (memberSnapshot.exists) {
        Map<String, dynamic> memberData =
            memberSnapshot.data() as Map<String, dynamic>;
        String lastNoteDate = memberData['lastNoteDate'] ?? '';

        if (lastNoteDate != todayDate && note.isNotEmpty) {
          await memberRef.update({
            'totalDailyNotes': FieldValue.increment(1),
            'lastNoteDate': todayDate,
          });

          await checkAndAwardAchievement('totalDailyNotes', context);
        }
      }
    }
  }

  /// Check and award achievement
  Future<void> checkAndAwardAchievement(
      String category, BuildContext context) async {
    if (_currentUser != null) {
      DocumentSnapshot memberSnapshot =
          await _firestore.collection('Members').doc(_currentUser!.uid).get();
      Map<String, dynamic>? memberData =
          memberSnapshot.data() as Map<String, dynamic>?;

      if (memberData == null) return;

      QuerySnapshot achievementsSnapshot = await _firestore
          .collection('achievements')
          .where('category', isEqualTo: category)
          .get();

      for (var achievement in achievementsSnapshot.docs) {
        Map<String, dynamic> achievementData =
            achievement.data() as Map<String, dynamic>;

        String achievementId = achievement.id;
        int threshold = achievementData['threshold'];
        int memberFieldValue = memberData[category] ?? 0;

        if (memberFieldValue >= threshold) {
          QuerySnapshot memberAchievementsSnapshot = await _firestore
              .collection('Members')
              .doc(_currentUser!.uid)
              .collection('achievements')
              .where('achievementId', isEqualTo: achievementId)
              .get();

          if (memberAchievementsSnapshot.docs.isEmpty) {
            await _firestore
                .collection('Members')
                .doc(_currentUser!.uid)
                .collection('achievements')
                .add({
              'achievementId': achievementId,
              'dateEarned': FieldValue.serverTimestamp(),
            });

            int points = achievementData['points'];
            await awardPoints(points, context);

            // Show achievement dialog
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AchievementDialog(
                    name: achievementData['name'],
                    description: achievementData['description'],
                    points: points,
                    imagePath: achievementData['imagePath'],
                  );
                },
              );
            }
          }
        }
      }
    }
  }

  /// Award points and handle level progression
  Future<void> awardPoints(int points, BuildContext context) async {
    if (_currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(_currentUser!.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();
      Map<String, dynamic> memberData =
          memberSnapshot.data() as Map<String, dynamic>;

      int currentLevel = memberData['level'] ?? 1;
      int currentPoints = memberData['points'] ?? 0;
      int dailyStreak = memberData['dailyStreak'] ?? 0;

      double multiplier = _calculateMultiplier(dailyStreak);
      int totalPoints = (points * multiplier).round();

      currentPoints += totalPoints;

      int requiredPoints = calculateRequiredPoints(currentLevel);
      bool leveledUp = false;

      while (currentPoints >= requiredPoints) {
        currentPoints -= requiredPoints;
        currentLevel++;
        requiredPoints = calculateRequiredPoints(currentLevel);
        leveledUp = true;
      }

      await memberRef.update({
        'level': currentLevel,
        'points': currentPoints,
      });

      if (leveledUp && context.mounted) {
        // Show level-up dialog
        showLevelUpDialog(context, currentLevel);
      }
    } else {
      throw Exception("User not logged in");
    }
  }

  double _calculateMultiplier(int dailyStreak) {
    if (dailyStreak >= 100) return 2.00;
    if (dailyStreak >= 90) return 1.90;
    if (dailyStreak >= 80) return 1.80;
    if (dailyStreak >= 70) return 1.70;
    if (dailyStreak >= 60) return 1.60;
    if (dailyStreak >= 50) return 1.50;
    if (dailyStreak >= 40) return 1.40;
    if (dailyStreak >= 30) return 1.30;
    if (dailyStreak >= 20) return 1.20;
    if (dailyStreak >= 10) return 1.10;
    return 1.0;
  }

  int calculateRequiredPoints(int level) {
    const basePoints = 100; // Base points required for level 1
    int points = (basePoints * pow(level, 1.05)).round();
    return (points / 100).floor() * 100;
  }

  // call dialog pop up to inform member of level up
  void showLevelUpDialog(BuildContext context, int level) {
    showDialog(
      context: context,
      builder: (context) => LevelUpDialog(level: level),
    );
  }

  Future<List<Map<String, String>>> getEarnedAchievements() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);

    QuerySnapshot achievementsSnapshot =
        await userDoc.collection('achievements').get();

    List<Map<String, String>> earnedAchievements = [];

    for (var doc in achievementsSnapshot.docs) {
      String achievementId = doc['achievementId'];
      DocumentSnapshot achievementDoc = await FirebaseFirestore.instance
          .collection('achievements')
          .doc(achievementId)
          .get();

      if (achievementDoc.exists) {
        earnedAchievements.add({
          'imagePath': achievementDoc['imagePath'],
          'name': achievementDoc['name'],
          'description': achievementDoc['description'],
        });
      }
    }

    return earnedAchievements;
  }

  // Add Friend Functions
  Future<bool> checkUserExistsByEmail(String email) async {
    QuerySnapshot userQuery = await _firestore
        .collection('Members')
        .where('email', isEqualTo: email)
        .get();
    return userQuery.docs.isNotEmpty;
  }

  Future<bool> checkAlreadyFriends(String currentUserId, String email) async {
    QuerySnapshot userQuery = await _firestore
        .collection('Members')
        .where('email', isEqualTo: email)
        .get();
    if (userQuery.docs.isEmpty) return false;

    String receiverId = userQuery.docs.first.id;
    QuerySnapshot friendSnapshot = await _firestore
        .collection('Members')
        .doc(currentUserId)
        .collection('friends')
        .where('friendId', isEqualTo: receiverId)
        .get();
    return friendSnapshot.docs.isNotEmpty;
  }

  Future<bool> checkPendingFriendRequest(
      String currentUserId, String email) async {
    QuerySnapshot userQuery = await _firestore
        .collection('Members')
        .where('email', isEqualTo: email)
        .get();
    if (userQuery.docs.isEmpty) return false;

    String receiverId = userQuery.docs.first.id;
    QuerySnapshot requestQuery = await _firestore
        .collection('friend_requests')
        .where('senderId', isEqualTo: currentUserId)
        .where('receiverId', isEqualTo: receiverId)
        .where('status', isEqualTo: 'pending')
        .get();
    return requestQuery.docs.isNotEmpty;
  }

  Future<bool> checkReceivedFriendRequest(
      String currentUserId, String email) async {
    QuerySnapshot userQuery = await _firestore
        .collection('Members')
        .where('email', isEqualTo: email)
        .get();
    if (userQuery.docs.isEmpty) return false;

    String receiverId = userQuery.docs.first.id;
    QuerySnapshot requestQuery = await _firestore
        .collection('friend_requests')
        .where('senderId', isEqualTo: receiverId)
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'pending')
        .get();
    return requestQuery.docs.isNotEmpty;
  }

  Future<void> sendFriendRequest(String senderId, String email) async {
    QuerySnapshot userQuery = await _firestore
        .collection('Members')
        .where('email', isEqualTo: email)
        .get();
    if (userQuery.docs.isEmpty) return;

    String receiverId = userQuery.docs.first.id;
    await _firestore.collection('friend_requests').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'status': 'pending',
      'sentAt': Timestamp.now(),
    });
  }
}
