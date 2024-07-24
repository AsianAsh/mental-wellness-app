// fix login issue (neverending loading indicator/prints previous user details)
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/counselling_request.dart';
import 'package:mental_wellness_app/models/helpline.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
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

  /// Method to get user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getMemberDetails() async {
    User? currentUser = _currentUser; // current logged in user
    if (currentUser != null) {
      return await _firestore.collection("Members").doc(currentUser.uid).get();
    } else {
      throw Exception("Member not logged in");
    }
  }

  /// Add member feedback message to Feedback collection in Firestore DB
  Future<void> addFeedback(String feedback) async {
    User? currentUser = _currentUser;
    if (currentUser != null) {
      await _firestore.collection('feedback').add({
        'memberId': currentUser.uid,
        'feedback': feedback,
        'createdAt': Timestamp.now(),
      });
    }
  }

  /// Method to update member details in Firestore
  Future<void> updateMemberDetails(Map<String, dynamic> updatedData) async {
    User? currentUser = _currentUser;
    if (currentUser != null) {
      await _firestore
          .collection("Members")
          .doc(currentUser.uid)
          .update(updatedData);
    } else {
      throw Exception("Member not logged in");
    }
  }

  // added id field for completion of task verification
  /// Method to fetch all available breathing exercises from Firestore
  //Does same thing but better
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

  // /// Method to fetch all available meditation exercises from Firestore
  // Does same thing but better + adds id field
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
    QuerySnapshot querySnapshot =
        await _firestore.collection('sleep_story').get();
    return querySnapshot.docs.map((doc) {
      return SleepStory.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
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
    QuerySnapshot querySnapshot =
        await _firestore.collection('sleep_music').get();
    return querySnapshot.docs.map((doc) {
      return SleepMusic(
        title: doc['title'],
        audioPath: doc['audioPath'],
        duration: doc['duration'],
      );
    }).toList();
  }

  /// Method to fetch all available relaxing background noises/sounds from Firestore
  Future<List<RelaxingSound>> fetchRelaxingSounds() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('relaxing_sound').get();
    return querySnapshot.docs.map((doc) {
      return RelaxingSound(
        title: doc['title'],
        audioPath: doc['audioPath'],
      );
    }).toList();
  }

  // With logic to create routine for new Member doc
  Future<void> updateDailyRoutine() async {
    User? currentUser = _currentUser;
    if (currentUser != null) {
      print('Current user tracked is: ${currentUser.email}');
      DocumentReference memberRef =
          _firestore.collection('Members').doc(currentUser.uid);

      DocumentSnapshot memberSnapshot = await memberRef.get();
      Map<String, dynamic> memberData =
          memberSnapshot.data() as Map<String, dynamic>? ?? {};

      String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

      bool allTasksCompleted = true;

      if (memberData['routine'] == null ||
          memberData['routine']['date'] != todayDate) {
        if (memberData['routine'] != null) {
          // Check if all tasks for the previous day are completed
          List<dynamic> tasks = memberData['routine']['tasks'];
          for (var task in tasks) {
            if (!task['completed']) {
              allTasksCompleted = false;
              break;
            }
          }

          if (!allTasksCompleted) {
            // Reset daily streak to 0 if not all tasks are completed
            await memberRef.update({'dailyStreak': 0});
            print('Daily streak reset to 0');
          }
        }

        print('Creating a new routine');
        String newBreathingExerciseId =
            await _getRandomDocumentId('breathing_exercise');
        String newMeditationExerciseId =
            await _getRandomDocumentId('meditation_exercise');
        String newSleepStoryId = await _getRandomDocumentId('sleep_story');

        print('Breathe id: $newBreathingExerciseId');
        print('Meditation id: $newMeditationExerciseId');
        print('Sleep Story id: $newSleepStoryId');
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
            {
              'category': 'Mood Tracker',
              'completed': false,
            },
          ]
        };

        await memberRef.update({'routine': newRoutine});
        print('Successfully added new routine: $newRoutine');
      }
    } else {
      throw Exception("User not logged in");
    }
  }

  Future<String> _getRandomDocumentId(String collectionName) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    Random random = Random();
    int randomIndex = random.nextInt(documents.length);
    return documents[randomIndex].id;
  }

  // Fetch a breathing exercise by its ID
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

  Future<void> updateTaskCompletion(String taskId, String category,
      bool completed, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(currentUser.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();

      if (memberSnapshot.exists) {
        Map<String, dynamic> memberData =
            memberSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> routine = memberData['routine'];
        List<dynamic> tasks = routine['tasks'];

        bool taskIsDailyTask = false;
        bool taskIsCompleted = false;

        for (var task in tasks) {
          if (task['category'] == category && task['id'] == taskId) {
            taskIsDailyTask = true;
            taskIsCompleted = task['completed'];
            task['completed'] = completed;
            break;
          }
        }

        await memberRef.update({'routine.tasks': tasks});

        await _checkAndUpdateDailyStreak(memberRef, routine, context);

        if (!context.mounted) return; // Check if the context is still mounted

        if (taskIsDailyTask && !taskIsCompleted && completed) {
          await awardPoints(100, context); // Award points for task completion
        }
      }
    }
  }

  Future<void> updateMoodTrackerCompletion(
      bool completed, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentReference memberRef =
          _firestore.collection('Members').doc(currentUser.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();

      if (memberSnapshot.exists) {
        Map<String, dynamic> memberData =
            memberSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> routine = memberData['routine'];
        List<dynamic> tasks = routine['tasks'];

        for (var task in tasks) {
          if (task['category'] == 'Mood Tracker') {
            task['completed'] = completed;
            break;
          }
        }

        await memberRef.update({'routine.tasks': tasks});

        await _checkAndUpdateDailyStreak(memberRef, routine, context);

        if (!context.mounted) return; // Check if the context is still mounted

        await awardPoints(100, context); // Award points for task completion
      }
    }
  }

  // Check if all tasks of the day were completed, if so, increment daily streak and award points
  Future<void> _checkAndUpdateDailyStreak(DocumentReference memberRef,
      Map<String, dynamic> routine, BuildContext context) async {
    bool allTasksCompleted = true;
    bool streakUpdated = routine['streakUpdated'] ?? false;

    for (var task in routine['tasks']) {
      print(
          'Checking task: ${task['category']}, completed: ${task['completed']}');
      if (!task['completed']) {
        allTasksCompleted = false;
      }
    }

    if (allTasksCompleted && !streakUpdated) {
      await memberRef.update({
        'dailyStreak': FieldValue.increment(1),
        'routine.streakUpdated': true,
      });
      print('All tasks completed. Daily streak incremented.');

      // Fetch updated daily streak
      DocumentSnapshot updatedSnapshot = await memberRef.get();
      int updatedDailyStreak = updatedSnapshot['dailyStreak'] ?? 0;

      // Award 200 points for completing all tasks with the new daily streak multiplier
      double multiplier = calculateMultiplier(updatedDailyStreak);
      int bonusPoints = (200 * multiplier).round();

      // Award points
      await awardPoints(bonusPoints, context);
      print('Awarded points due to completing all daily tasks: $bonusPoints');

      print('Bonus points awarded: $bonusPoints');

      // Check and award daily streak achievement
      await checkAndAwardAchievement('dailyStreak', context);
    } else {
      print('Not all tasks completed or streak already updated.');
    }
  }

  // Future<void> sendNudge(String friendId, String message, String icon) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser == null) return;

  //   try {
  //     // Fetch sender's full name from Firestore
  //     DocumentSnapshot senderSnapshot = await FirebaseFirestore.instance
  //         .collection('Members')
  //         .doc(currentUser.uid)
  //         .get();
  //     String senderName =
  //         "${senderSnapshot['firstName']} ${senderSnapshot['lastName']}";

  //     await FirebaseFirestore.instance
  //         .collection('Members')
  //         .doc(friendId)
  //         .collection('nudges')
  //         .add({
  //       'senderId': currentUser.uid,
  //       'senderName': senderName,
  //       'message': message,
  //       'icon': icon,
  //       'timestamp': FieldValue.serverTimestamp(),
  //       'read': false,
  //     });

  //     // Increment encouragingMessagesSent for the current user
  //     await _firestore.collection('Members').doc(currentUser.uid).update({
  //       'encouragingMessagesSent': FieldValue.increment(1),
  //     });

  //     Get.snackbar("Success", "Nudge sent successfully");
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to send nudge");
  //   }
  // }
  Future<void> sendNudge(String friendId, String message, String icon,
      BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      // Fetch sender's full name from Firestore
      DocumentSnapshot senderSnapshot =
          await _firestore.collection('Members').doc(currentUser.uid).get();
      String senderName =
          "${senderSnapshot['firstName']} ${senderSnapshot['lastName']}";

      await _firestore
          .collection('Members')
          .doc(friendId)
          .collection('nudges')
          .add({
        'senderId': currentUser.uid,
        'senderName': senderName,
        'message': message,
        'icon': icon,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
      });

      // Increment encouragingMessagesSent and check achievements
      await incrementFieldAndCheckAchievement(
          'encouragingMessagesSent', context);

      Get.snackbar(
        "Success",
        "Nudge sent successfully",
        backgroundColor: Colors.white60,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send nudge",
        backgroundColor: Colors.white60,
      );
    }
  }

  /// Counsellor related functions
  // Add submitted counselling request to Firestore
  // Future<void> createCounsellingRequest(CounsellingRequest request) async {
  //   await _firestore.collection('counselling_requests').add(request.toMap());
  // }

  // Future<void> createCounsellorDocument(UserCredential userCredential) async {
  //   if (userCredential != null && userCredential.user != null) {
  //     await _firestore
  //         .collection("Counsellors")
  //         .doc(userCredential.user!.uid)
  //         .set({
  //       // Add the relevant fields for counsellor
  //     });
  //   }
  // }

  Future<void> updateLastActive() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentReference memberDocRef =
          _firestore.collection('Members').doc(currentUser.uid);
      DocumentReference counselorDocRef =
          _firestore.collection('Counsellors').doc(currentUser.uid);

      DocumentSnapshot memberDocSnapshot = await memberDocRef.get();
      DocumentSnapshot counselorDocSnapshot = await counselorDocRef.get();

      if (memberDocSnapshot.exists) {
        print("update last active for member");
        await memberDocRef.update({
          'lastActive': Timestamp.now(),
        });
      } else if (counselorDocSnapshot.exists) {
        print("update last active for counsellor");
        await counselorDocRef.update({
          'lastActive': Timestamp.now(),
        });
      } else {
        print("Document does not exist for both Member and Counsellor.");
        // Do not create a new document here to avoid creating a member document mistakenly
      }
    }
  }

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
    if (userCredential != null && userCredential.user != null) {
      await _firestore
          .collection("counsellors")
          .doc(userCredential.user!.uid)
          .set({
        'counsellorId': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'title': title,
        'firstName': capitalize(firstName),
        'lastName': capitalize(lastName),
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

  String capitalize(String name) {
    return name.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return '';
      }
    }).join(' ');
  }

  Stream<DocumentSnapshot> getRoutineStream() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return _firestore.collection('Members').doc(currentUser.uid).snapshots();
    }
    throw Exception("Member not logged in");
  }

  Future<List<Map<String, dynamic>>> getActiveCounsellors() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('counsellors')
        .where('status', isEqualTo: 'active')
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  ///
  ///
  /// Function for updating member fields related to tracking achivements eligibility + point distribution
  ///
  ///
  Future<void> incrementFieldAndCheckAchievement(
      String category, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    DocumentReference memberRef =
        _firestore.collection('Members').doc(currentUser.uid);

    // Increment the specified field
    await memberRef.update({
      category: FieldValue.increment(1),
    });

    // Check and award achievements
    await checkAndAwardAchievement(category, context);
  }

  // Like incrementFieldAndCheckAchievement function but specifically for totalDailyNotes field
  Future<void> checkAndIncrementDailyNote(
      String note, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String todayDate = DateTime.now().toIso8601String().substring(0, 10);
      DocumentReference memberRef =
          _firestore.collection('Members').doc(currentUser.uid);
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

  // Function to check and award achievements
  // Future<void> checkAndAwardAchievement(
  //     String category, BuildContext context) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser == null) return;

  //   DocumentSnapshot memberSnapshot =
  //       await _firestore.collection('Members').doc(currentUser.uid).get();
  //   Map<String, dynamic>? memberData =
  //       memberSnapshot.data() as Map<String, dynamic>?;

  //   if (memberData == null) return;

  //   QuerySnapshot achievementsSnapshot = await _firestore
  //       .collection('achievements')
  //       .where('category', isEqualTo: category)
  //       .get();

  //   for (var achievement in achievementsSnapshot.docs) {
  //     Map<String, dynamic> achievementData =
  //         achievement.data() as Map<String, dynamic>;

  //     String achievementId = achievement.id;
  //     int threshold = achievementData['threshold'];
  //     int memberFieldValue = memberData[category] ?? 0;

  //     if (memberFieldValue >= threshold) {
  //       // Check if the achievement is already awarded
  //       QuerySnapshot memberAchievementsSnapshot = await _firestore
  //           .collection('Members')
  //           .doc(currentUser.uid)
  //           .collection('achievements')
  //           .where('achievementId', isEqualTo: achievementId)
  //           .get();

  //       if (memberAchievementsSnapshot.docs.isEmpty) {
  //         // Award the achievement
  //         await _firestore
  //             .collection('Members')
  //             .doc(currentUser.uid)
  //             .collection('achievements')
  //             .add({
  //           'achievementId': achievementId,
  //           'dateEarned': FieldValue.serverTimestamp(),
  //         });

  //         // Award points using the awardPoints function
  //         int points = achievementData['points'];
  //         await awardPoints(points, context);
  //       }
  //     }
  //   }
  // }

  // with achivement pop up
  Future<void> checkAndAwardAchievement(
      String category, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    DocumentSnapshot memberSnapshot =
        await _firestore.collection('Members').doc(currentUser.uid).get();
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
        // Check if the achievement is already awarded
        QuerySnapshot memberAchievementsSnapshot = await _firestore
            .collection('Members')
            .doc(currentUser.uid)
            .collection('achievements')
            .where('achievementId', isEqualTo: achievementId)
            .get();

        if (memberAchievementsSnapshot.docs.isEmpty) {
          // Award the achievement
          await _firestore
              .collection('Members')
              .doc(currentUser.uid)
              .collection('achievements')
              .add({
            'achievementId': achievementId,
            'dateEarned': FieldValue.serverTimestamp(),
          });

          // Award points using the awardPoints function
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

  // Award points and handle level progression
  Future<void> awardPoints(int points, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentReference memberRef =
          FirebaseFirestore.instance.collection('Members').doc(currentUser.uid);
      DocumentSnapshot memberSnapshot = await memberRef.get();
      Map<String, dynamic> memberData =
          memberSnapshot.data() as Map<String, dynamic>;

      int currentLevel = memberData['level'] ?? 1;
      int currentPoints = memberData['points'] ?? 0;
      int dailyStreak = memberData['dailyStreak'] ?? 0;

      // Calculate points with multiplier
      double multiplier = calculateMultiplier(dailyStreak);
      int totalPoints = (points * multiplier).round();

      // Add points to current points
      currentPoints += totalPoints;

      // Check if points are enough to level up
      int requiredPoints = calculateRequiredPoints(currentLevel);
      bool leveledUp = false;

      while (currentPoints >= requiredPoints) {
        currentPoints -= requiredPoints;
        currentLevel++;
        requiredPoints = calculateRequiredPoints(currentLevel);
        leveledUp = true;
      }

      // Update member's level and points
      await memberRef.update({
        'level': currentLevel,
        'points': currentPoints,
      });

      print('Points awarded: $totalPoints');
      print('New level: $currentLevel');
      print('Remaining points: $currentPoints');

      // Show level-up popup if leveled up
      if (leveledUp && context.mounted) {
        showLevelUpDialog(context, currentLevel);
      }
    } else {
      throw Exception("User not logged in");
    }
  }

  // Calculate multiplier based on daily streak
  double calculateMultiplier(int dailyStreak) {
    if (dailyStreak >= 10 && dailyStreak < 20) {
      return 1.10;
    } else if (dailyStreak >= 20 && dailyStreak < 30) {
      return 1.20;
    } else if (dailyStreak >= 30 && dailyStreak < 40) {
      return 1.30;
    } else if (dailyStreak >= 40 && dailyStreak < 50) {
      return 1.40;
    } else if (dailyStreak >= 50 && dailyStreak < 60) {
      return 1.50;
    } else if (dailyStreak >= 60 && dailyStreak < 70) {
      return 1.60;
    } else if (dailyStreak >= 70 && dailyStreak < 80) {
      return 1.70;
    } else if (dailyStreak >= 80 && dailyStreak < 90) {
      return 1.80;
    } else if (dailyStreak >= 90 && dailyStreak < 100) {
      return 1.90;
    } else if (dailyStreak >= 100) {
      return 2.00;
    }
    return 1.0;
  }

  // Calculate required points for a given level
  int calculateRequiredPoints(int level) {
    const basePoints = 100; // Base points required for level 1
    int points = (basePoints * pow(level, 1.05)).round();
    print('Legacy required points for level $level: $points');
    print(
        'Rounded required points for level $level: ${(points / 100).floor() * 100}');
    return (points / 100).floor() * 100;
  }

  void showLevelUpDialog(BuildContext context, int level) {
    showDialog(
      context: context,
      builder: (context) => LevelUpDialog(level: level),
    );
  }

  Future<Map<String, CountryHelpline>> loadHelplines() async {
    final jsonString = await rootBundle.loadString('assets/helplines.json');
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map(
        (country, data) => MapEntry(country, CountryHelpline.fromJson(data)));
  }
}
