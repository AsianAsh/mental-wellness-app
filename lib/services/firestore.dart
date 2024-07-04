import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_wellness_app/models/breathing_exercise.dart';
import 'package:mental_wellness_app/models/meditation_exercise.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  // Singleton pattern to ensure only one instance of FirestoreService is created
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() {
    return _instance;
  }
  FirestoreService._internal();

  /// Method to get user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getMemberDetails() async {
    User? currentUser =
        FirebaseAuth.instance.currentUser; // current logged in user
    if (currentUser != null) {
      return await _firestore.collection("Members").doc(currentUser.uid).get();
    } else {
      throw Exception("Member not logged in");
    }
  }

  /// Method to update lastActive field for the current logged in user/member
  Future<void> updateLastActive() async {
    // Commented due to run app freeze issue
    // User? currentUser = FirebaseAuth.instance.currentUser;
    // if (currentUser != null) {
    //   await _firestore.collection('Members').doc(currentUser.uid).update({
    //     'lastActive': Timestamp.now(),
    //   });
    // }

    User? currentUser = FirebaseAuth.instance.currentUser;
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
    if (_currentUser != null) {
      await _firestore.collection('Feedback').add({
        'memberId': _currentUser.uid,
        'feedback': feedback,
        'createdAt': Timestamp.now(),
      });
    }
  }

  /// Method to update member details in Firestore
  Future<void> updateMemberDetails(Map<String, dynamic> updatedData) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await _firestore
          .collection("Members")
          .doc(currentUser.uid)
          .update(updatedData);
    } else {
      throw Exception("Member not logged in");
    }
  }

  /// Method to fetch all available breathing exercises from Firestore
  /// data is mapped according to breathing exercise model
  Future<List<BreathingExercise>> fetchBreathingExercises() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('breathing_exercise').get();
    return querySnapshot.docs.map((doc) {
      return BreathingExercise(
        title: doc['title'],
        duration: doc['duration'],
        imagePath: doc['imagePath'],
        audioPath: doc['audioPath'],
      );
    }).toList();
  }

  /// Method to fetch all available meditation exercises from Firestore
  /// data is mapped according to meditation exercise model
  Future<List<MeditationExercise>> fetchMeditationExercises() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('meditation_exercise').get();
    List<MeditationExercise> exercises = [];
    for (var doc in querySnapshot.docs) {
      try {
        print('Fetched doc: ${doc.id}');
        exercises.add(MeditationExercise(
          title: doc['title'] ?? 'Untitled',
          description: doc['description'] ?? 'No description',
          imagePath: doc['imagePath'] ?? 'assets/images/default.jpg',
          audioPath: doc['audioPath'] ?? '',
          duration: doc['duration'] ?? '0',
        ));
      } catch (e) {
        print('Error parsing document ${doc.id}: $e');
      }
    }
    return exercises;
  }
}
