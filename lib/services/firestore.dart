// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:mental_wellness_app/models/breathing_exercise.dart';
// import 'package:mental_wellness_app/models/meditation_exercise.dart';
// import 'package:mental_wellness_app/models/relaxing_sound.dart';
// import 'package:mental_wellness_app/models/sleep_music.dart';
// import 'package:mental_wellness_app/models/sleep_story.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final User? _currentUser = FirebaseAuth.instance.currentUser;

//   // Singleton pattern to ensure only one instance of FirestoreService is created
//   static final FirestoreService _instance = FirestoreService._internal();
//   factory FirestoreService() {
//     return _instance;
//   }
//   FirestoreService._internal();

//   /// Method to get user details
//   Future<DocumentSnapshot<Map<String, dynamic>>> getMemberDetails() async {
//     User? currentUser =
//         FirebaseAuth.instance.currentUser; // current logged in user
//     if (currentUser != null) {
//       return await _firestore.collection("Members").doc(currentUser.uid).get();
//     } else {
//       throw Exception("Member not logged in");
//     }
//   }

//   /// Method to update lastActive field for the current logged in user/member
//   Future<void> updateLastActive() async {
//     // Commented due to run app freeze issue
//     // User? currentUser = FirebaseAuth.instance.currentUser;
//     // if (currentUser != null) {
//     //   await _firestore.collection('Members').doc(currentUser.uid).update({
//     //     'lastActive': Timestamp.now(),
//     //   });
//     // }

//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentReference docRef =
//           _firestore.collection('Members').doc(currentUser.uid);
//       DocumentSnapshot docSnapshot = await docRef.get();

//       if (docSnapshot.exists) {
//         await docRef.update({
//           'lastActive': Timestamp.now(),
//         });
//       } else {
//         print("Document does not exist. Creating new document...");
//         await docRef.set({
//           'memberId': currentUser.uid,
//           'email': currentUser.email,
//           'lastActive': Timestamp.now(),
//           // Add other default fields as necessary
//         });
//       }
//     }
//   }

//   /// Add member feedback message to Feedback collection in Firestore DB
//   Future<void> addFeedback(String feedback) async {
//     if (_currentUser != null) {
//       await _firestore.collection('feedback').add({
//         'memberId': _currentUser.uid,
//         'feedback': feedback,
//         'createdAt': Timestamp.now(),
//       });
//     }
//   }

//   /// Method to update member details in Firestore
//   Future<void> updateMemberDetails(Map<String, dynamic> updatedData) async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
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
//   /// data is mapped according to breathing exercise model
//   Future<List<BreathingExercise>> fetchBreathingExercises() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('breathing_exercise').get();
//     return querySnapshot.docs.map((doc) {
//       return BreathingExercise(
//         title: doc['title'],
//         duration: doc['duration'],
//         imagePath: doc['imagePath'],
//         audioPath: doc['audioPath'],
//       );
//     }).toList();
//   }

//   /// Method to fetch all available meditation exercises from Firestore
//   /// data is mapped according to meditation exercise model
//   Future<List<MeditationExercise>> fetchMeditationExercises() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('meditation_exercise').get();
//     List<MeditationExercise> exercises = [];
//     for (var doc in querySnapshot.docs) {
//       try {
//         print('Fetched doc: ${doc.id}');
//         exercises.add(MeditationExercise(
//           title: doc['title'] ?? 'Untitled',
//           description: doc['description'] ?? 'No description',
//           imagePath: doc['imagePath'] ?? 'assets/images/default.jpg',
//           audioPath: doc['audioPath'] ?? '',
//           duration: doc['duration'] ?? '0',
//         ));
//       } catch (e) {
//         print('Error parsing document ${doc.id}: $e');
//       }
//     }
//     return exercises;
//   }

//   /// Method to fetch all available sleep stories from Firestore
//   Future<List<SleepStory>> fetchSleepStories() async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection('sleep_story').get();
//     return querySnapshot.docs.map((doc) {
//       return SleepStory(
//         title: doc['title'],
//         imagePath: doc['imagePath'],
//         audioPath: doc['audioPath'],
//         duration: doc['duration'],
//       );
//     }).toList();
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

//   // Takes current user's daily routine field (has daily tasks) and updates/refreshes it if needed
//   // Future<void> updateDailyRoutine() async {
//   //   if (_currentUser != null) {
//   //     print('Current user is: ${_currentUser.email}');
//   //     DocumentReference memberRef =
//   //         _firestore.collection('Members').doc(_currentUser.uid);

//   //     DocumentSnapshot memberSnapshot = await memberRef.get();
//   //     Map<String, dynamic> memberData =
//   //         memberSnapshot.data() as Map<String, dynamic>;

//   //     String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

//   //     print('Before checking member routine field');

//   //     if (memberData['routine'] == null) {
//   //       print('Member routine field is null');
//   //     }

//   //     if (memberData['routine'] != null) {
//   //       print('Member routine field is NOT null');
//   //     }

//   //     if (memberData['routine'] == null ||
//   //         memberData['routine']['date'] != todayDate) {
//   //       String newBreathingExerciseId =
//   //           await _getRandomDocumentId('breathing_exercise');
//   //       String newSleepStoryId = await _getRandomDocumentId('sleep_story');

//   //       Map<String, dynamic> newRoutine = {
//   //         'date': todayDate,
//   //         'tasks': [
//   //           {
//   //             'category': 'Breathe',
//   //             'completed': false,
//   //             'id': newBreathingExerciseId
//   //           },
//   //           {
//   //             'category': 'Sleep Story',
//   //             'completed': false,
//   //             'id': newSleepStoryId
//   //           },
//   //           {
//   //             'category': 'Mood Tracker',
//   //             'completed': false,
//   //           },
//   //         ]
//   //       };

//   //       await memberRef.update({'routine': newRoutine});
//   //     }
//   //   } else {
//   //     throw Exception("User not logged in");
//   //   }
//   // }
//   Future<void> updateDailyRoutine() async {
//     if (_currentUser != null) {
//       print('Current user tracked is: ${_currentUser.email}');
//       DocumentReference memberRef =
//           _firestore.collection('Members').doc(_currentUser.uid);

//       DocumentSnapshot memberSnapshot = await memberRef.get();
//       Map<String, dynamic> memberData =
//           memberSnapshot.data() as Map<String, dynamic>;

//       String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

//       if (memberData['routine'] == null) {
//         print('Members routine field is null');
//       }

//       if (memberData['routine'] != null) {
//         print('Members routine field is NOT null');
//       }

//       if (memberData['routine'] == null ||
//           memberData['routine']['date'] != todayDate) {
//         String newBreathingExerciseId =
//             await _getRandomDocumentId('breathing_exercise');
//         String newSleepStoryId = await _getRandomDocumentId('sleep_story');

//         Map<String, dynamic> newRoutine = {
//           'date': todayDate,
//           'tasks': [
//             {
//               'category': 'Breathe',
//               'completed': false,
//               'id': newBreathingExerciseId
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
//       }
//     } else {
//       throw Exception("User not logged in");
//     }
//   }

//   Future<String> _getRandomDocumentId(String collectionName) async {
//     QuerySnapshot querySnapshot =
//         await _firestore.collection(collectionName).get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     Random random = Random();
//     int randomIndex = random.nextInt(documents.length);
//     return documents[randomIndex].id;
//   }

//   // For selecting random document from collections for tasks in daily routine.
//   // Example: Daily routine is refreshed and this is called to select a
//   //          meditation exercise as the new routine task.
//   // Future<String> _getRandomDocumentId(String collectionName) async {
//   //   QuerySnapshot querySnapshot =
//   //       await _firestore.collection(collectionName).get();
//   //   List<DocumentSnapshot> documents = querySnapshot.docs;
//   //   Random random = Random();
//   //   int randomIndex = random.nextInt(documents.length);
//   //   return documents[randomIndex].id;
//   // }
// }

// fix login issue (neverending loading indicator/prints previous user details)
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';
import 'package:mental_wellness_app/models/relaxing_sound.dart';
import 'package:mental_wellness_app/models/sleep_music.dart';
import 'package:mental_wellness_app/models/sleep_story.dart';
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

  /// Method to update lastActive field for the current logged in user/member
  Future<void> updateLastActive() async {
    User? currentUser = _currentUser;
    if (currentUser != null) {
      DocumentReference docRef =
          _firestore.collection('Members').doc(currentUser.uid);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'lastActive': Timestamp.now(),
        });
      } else {
        print("Document does not exist. Creating new document...");
        await docRef.set({
          'memberId': currentUser.uid,
          'email': currentUser.email,
          'lastActive': Timestamp.now(),
          // Add other default fields as necessary
        });
      }
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

  /// Method to update daily routine
  //Check if all tasks from previous day was completed, if not, reset daily streak to 0
  Future<void> updateDailyRoutine() async {
    User? currentUser = _currentUser;
    if (currentUser != null) {
      print('Current user tracked is: ${currentUser.email}');
      DocumentReference memberRef =
          _firestore.collection('Members').doc(currentUser.uid);

      DocumentSnapshot memberSnapshot = await memberRef.get();
      Map<String, dynamic> memberData =
          memberSnapshot.data() as Map<String, dynamic>;

      String todayDate = DateFormat('d MMMM yyyy').format(DateTime.now());

      if (memberData['routine'] == null) {
        print('Members routine field is null');
      }

      if (memberData['routine'] != null) {
        print('Members routine field is NOT null');
      }

      bool allTasksCompleted = true;
      if (memberData['routine'] != null &&
          memberData['routine']['date'] != todayDate) {
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

  // /// both updateTask functions modified to check if all task completed and increment daily streak
  // Future<void> updateTaskCompletion(
  //     String taskId, String category, bool completed) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     DocumentReference memberRef =
  //         _firestore.collection('Members').doc(currentUser.uid);
  //     DocumentSnapshot memberSnapshot = await memberRef.get();

  //     if (memberSnapshot.exists) {
  //       Map<String, dynamic> memberData =
  //           memberSnapshot.data() as Map<String, dynamic>;
  //       Map<String, dynamic> routine = memberData['routine'];
  //       List<dynamic> tasks = routine['tasks'];

  //       for (var task in tasks) {
  //         if (task['category'] == category && task['id'] == taskId) {
  //           task['completed'] = completed;
  //           break;
  //         }
  //       }

  //       await memberRef.update({'routine.tasks': tasks});

  //       await _checkAndUpdateDailyStreak(memberRef, routine);

  //       await awardPoints(100); // Award points for task completion
  //     }
  //   }
  // }

  // Future<void> updateMoodTrackerCompletion(bool completed) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     DocumentReference memberRef =
  //         _firestore.collection('Members').doc(currentUser.uid);
  //     DocumentSnapshot memberSnapshot = await memberRef.get();

  //     if (memberSnapshot.exists) {
  //       Map<String, dynamic> memberData =
  //           memberSnapshot.data() as Map<String, dynamic>;
  //       Map<String, dynamic> routine = memberData['routine'];
  //       List<dynamic> tasks = routine['tasks'];

  //       for (var task in tasks) {
  //         if (task['category'] == 'Mood Tracker') {
  //           task['completed'] = completed;
  //           break;
  //         }
  //       }

  //       await memberRef.update({'routine.tasks': tasks});

  //       await _checkAndUpdateDailyStreak(memberRef, routine);

  //       await awardPoints(100); // Award points for task completion
  //     }
  //   }
  // }

  // Future<void> _checkAndUpdateDailyStreak(
  //     DocumentReference memberRef, Map<String, dynamic> routine) async {
  //   bool allTasksCompleted = true;
  //   bool streakUpdated = routine['streakUpdated'] ?? false;

  //   for (var task in routine['tasks']) {
  //     print(
  //         'Checking task: ${task['category']}, completed: ${task['completed']}');
  //     if (!task['completed']) {
  //       allTasksCompleted = false;
  //     }
  //   }

  //   if (allTasksCompleted && !streakUpdated) {
  //     await memberRef.update({
  //       'dailyStreak': FieldValue.increment(1),
  //       'routine.streakUpdated': true,
  //     });
  //     print('All tasks completed. Daily streak incremented.');

  //     // Fetch updated daily streak
  //     DocumentSnapshot updatedSnapshot = await memberRef.get();
  //     int updatedDailyStreak = updatedSnapshot['dailyStreak'] ?? 0;

  //     // Award 200 points for completing all tasks with the new daily streak multiplier
  //     double multiplier = calculateMultiplier(updatedDailyStreak);
  //     int bonusPoints = (200 * multiplier).round();
  //     await awardPoints(bonusPoints);

  //     print('Bonus points awarded: $bonusPoints');
  //   } else {
  //     print('Not all tasks completed or streak already updated.');
  //   }
  // }

  // Add argument o of context due to Level up dialog
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

        for (var task in tasks) {
          if (task['category'] == category && task['id'] == taskId) {
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

      if (!context.mounted) return; // Check if the context is still mounted

      await awardPoints(bonusPoints, context);

      print('Bonus points awarded: $bonusPoints');
    } else {
      print('Not all tasks completed or streak already updated.');
    }
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

  // Award points and handle level progression
  // Future<void> awardPoints(int points) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     DocumentReference memberRef =
  //         _firestore.collection('Members').doc(currentUser.uid);
  //     DocumentSnapshot memberSnapshot = await memberRef.get();
  //     Map<String, dynamic> memberData =
  //         memberSnapshot.data() as Map<String, dynamic>;

  //     int currentLevel = memberData['level'] ?? 1;
  //     int currentPoints = memberData['points'] ?? 0;
  //     int dailyStreak = memberData['dailyStreak'] ?? 0;

  //     // Calculate points with multiplier
  //     double multiplier = calculateMultiplier(dailyStreak);
  //     int totalPoints = (points * multiplier).round();

  //     // Add points to current points
  //     currentPoints += totalPoints;

  //     // Check if points are enough to level up
  //     int requiredPoints = calculateRequiredPoints(currentLevel);
  //     while (currentPoints >= requiredPoints) {
  //       currentPoints -= requiredPoints;
  //       currentLevel++;
  //       requiredPoints = calculateRequiredPoints(currentLevel);
  //     }

  //     // Update member's level and points
  //     await memberRef.update({
  //       'level': currentLevel,
  //       'points': currentPoints,
  //     });

  //     print('Points awarded: $totalPoints');
  //     print('New level: $currentLevel');
  //     print('Remaining points: $currentPoints');
  //   } else {
  //     throw Exception("User not logged in");
  //   }
  // }

  // Added level up pop up
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
      if (leveledUp) {
        showLevelUpDialog(context, currentLevel);
      }
    } else {
      throw Exception("User not logged in");
    }
  }

  void showLevelUpDialog(BuildContext context, int level) {
    showDialog(
      context: context,
      builder: (context) => LevelUpDialog(level: level),
    );
  }
}
