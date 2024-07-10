import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // To set device orientation
import 'package:mental_wellness_app/auth/auth_screen.dart';
import 'package:mental_wellness_app/services/firestore.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import './persistent_bottom_bar_scaffold.dart';
//import 'package:mental-wellness-app/persistent_bottom_bar_scaffold.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Update logged in member's lastActive field when app starts
  // await FirestoreService().updateLastActive();
  // Set device orientation to be portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(const MyApp());
    if (FirebaseAuth.instance.currentUser != null) {
      await FirestoreService().updateDailyRoutine();
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // manage state of audio player across different screens
      providers: [
        // provides AudioPlayerState instance to the entire application
        ChangeNotifierProvider(create: (_) => AudioPlayerState()),
        // other providers here if needed
      ],
      child: GetMaterialApp(
          theme: ThemeData(
            primaryColor: Colors.indigo[700],
            scaffoldBackgroundColor:
                Colors.indigo[800], // Default bg color for all screens
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.indigo[600],

              titleTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 18.0),
              centerTitle: true, // Centering the title in the AppBar
              iconTheme: const IconThemeData(
                  color: Colors.white), // Ensures AppBar uses primary color
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const AuthScreen()),
    );
    // routes:
    // {}
    // ;
  }
}
