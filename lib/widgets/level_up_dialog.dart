// import 'package:flutter/material.dart';

// class LevelUpDialog extends StatelessWidget {
//   final int newLevel;

//   const LevelUpDialog({Key? key, required this.newLevel}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   Widget contentBox(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 "Level Up!",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               Icon(
//                 Icons.stars,
//                 color: Colors.orange,
//                 size: 64,
//               ),
//               SizedBox(height: 16),
//               Text(
//                 "Congratulations! You've reached level $newLevel!",
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("OK", style: TextStyle(fontSize: 18)),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class LevelUpDialog extends StatelessWidget {
  final int level;

  const LevelUpDialog({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'LEVEL UP!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            // const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/level_up_medal.png',
                ), // Add your medal background image here
                // CircleAvatar(
                //   radius: 30,
                //   backgroundColor: Colors.orange,
                //   child: Text(
                //     '$level',
                //     style: const TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
            // const SizedBox(height: 20),
            Text(
              'LEVEL $level',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Congratulations!\nYou\'ve reached level $level now.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
