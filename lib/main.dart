import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // To set device orientation
import 'package:mental_wellness_app/views/login_screen.dart';
import './home_page.dart';
import 'package:get/get.dart';
// import './persistent_bottom_bar_scaffold.dart';
//import 'package:mental-wellness-app/persistent_bottom_bar_scaffold.dart';

void main() {
  // Set device orientation to be portrait only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo[700],
          scaffoldBackgroundColor:
              Colors.indigo[800], // Default bg color for all screens
          // textTheme: TextTheme(
          //   bodyLarge: TextStyle(color: Colors.white),
          //   bodyMedium: TextStyle(color: Colors.white),
          //   bodySmall: TextStyle(color: Colors.white),
          //   headline3: TextStyle(color: Colors.white),
          //   headline4: TextStyle(color: Colors.white),
          //   headline5: TextStyle(color: Colors.white),
          //   headline6: TextStyle(color: Colors.white),
          // ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo[600],

            titleTextStyle:
                const TextStyle(color: Colors.black, fontSize: 18.0),
            centerTitle: true, // Centering the title in the AppBar
            iconTheme: const IconThemeData(
                color: Colors.white), // Ensures AppBar uses primary color
          ),
          // textTheme: TextTheme(
          //   bodyText1: TextStyle(color: Colors.white), // Default text color
          //   bodyText2: TextStyle(color: Colors.white), // Default text color
          // ),
          // iconTheme: IconThemeData(
          //   color: Colors.white, // Default icon color
          // ),
        ),
        // home: const HomePage());
        home: LoginScreen());
    // routes:
    // {}
    // ;
  }
}
