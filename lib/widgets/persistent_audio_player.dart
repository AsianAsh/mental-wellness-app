// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             height: 70,
//             color: Colors.blueGrey,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(audioPlayerState.currentAudio ?? 'No audio'),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           onPressed: () {
//                             if (audioPlayerState.isPlaying) {
//                               audioPlayerState.pauseAudio();
//                             } else {
//                               audioPlayerState
//                                   .playAudio(audioPlayerState.currentAudio!);
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.close),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             height: 70,
//             decoration: BoxDecoration(
//               color: Colors.indigo[600],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               border: const Border(
//                 bottom: BorderSide(
//                   color: Colors.white12,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       audioPlayerState.currentAudio ?? 'No audio',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.timer_outlined,
//                               color: Colors.white),
//                           onPressed: () {
//                             // Timer action
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           iconSize: 30,
//                           color: Colors.white,
//                           onPressed: () {
//                             if (audioPlayerState.isPlaying) {
//                               audioPlayerState.pauseAudio();
//                             } else {
//                               audioPlayerState
//                                   .playAudio(audioPlayerState.currentAudio!);
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// after getting sleep_story data and modifying audio player to actually play audio including sleep stories
// persistent_audio_player.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:audioplayers/audioplayers.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         if (audioPlayerState.isPlaying) {
//           _audioPlayer.play(AssetSource(audioPlayerState.currentAudio!));
//         } else {
//           _audioPlayer.pause();
//         }

//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             height: 70,
//             // color: Colors.indigo[600],
//             decoration: BoxDecoration(
//               color: Colors.indigo[600],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               border: const Border(
//                 bottom: BorderSide(
//                   color: Colors.white12,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Display sleep story title
//                     Text(
//                       audioPlayerState.currentAudioTitle ?? 'No audio',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.timer_outlined,
//                               color: Colors.white),
//                           onPressed: () {
//                             // Timer action
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           iconSize: 30,
//                           color: Colors.white,
//                           onPressed: () {
//                             if (audioPlayerState.isPlaying) {
//                               audioPlayerState.pauseAudio();
//                             } else {
//                               audioPlayerState
//                                   .playAudio(audioPlayerState.currentAudio!);
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';
// import 'package:audioplayers/audioplayers.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         if (audioPlayerState.isPlaying) {
//           _audioPlayer.play(AssetSource(audioPlayerState.currentAudio!));
//         } else {
//           _audioPlayer.pause();
//         }

//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             height: 70,
//             // color: Colors.indigo[600],
//             decoration: BoxDecoration(
//               color: Colors.indigo[600],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               border: const Border(
//                 bottom: BorderSide(
//                   color: Colors.white12,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Display sleep story title
//                     Text(
//                       audioPlayerState.currentAudioTitle ?? 'No audio',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.timer_outlined,
//                               color: Colors.white),
//                           onPressed: () {
//                             // Timer action
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           iconSize: 30,
//                           color: Colors.white,
//                           onPressed: () {
//                             if (audioPlayerState.isPlaying) {
//                               audioPlayerState.pauseAudio();
//                             } else {
//                               audioPlayerState
//                                   .playAudio(audioPlayerState.currentAudio!);
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             height: 70,
//             // color: Colors.blueGrey,
//             decoration: BoxDecoration(
//               color: Colors.indigo[600],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               border: const Border(
//                 bottom: BorderSide(
//                   color: Colors.white12,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Text(
//                           audioPlayerState.currentAudioTitle ?? 'No audio',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.timer_outlined,
//                               color: Colors.white),
//                           onPressed: () {
//                             // Timer action
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           iconSize: 30,
//                           color: Colors.white,
//                           onPressed: () {
//                             if (audioPlayerState.isPlaying) {
//                               audioPlayerState.pauseAudio();
//                             } else {
//                               audioPlayerState.resumeAudio();
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// version 4
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             height: 70,
//             decoration: BoxDecoration(
//               color: Colors.indigo[600],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               border: const Border(
//                 bottom: BorderSide(
//                   color: Colors.white12,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Text(
//                           audioPlayerState.currentAudioTitle ?? 'No audio',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.timer_outlined,
//                               color: Colors.white),
//                           onPressed: () {
//                             // Timer action
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           iconSize: 30,
//                           color: Colors.white,
//                           onPressed: () {
//                             if (audioPlayerState.isPlaying) {
//                               audioPlayerState.pauseAudio();
//                             } else {
//                               audioPlayerState.resumeAudio();
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// version 5
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mental_wellness_app/state/audio_player_state.dart';

class PersistentAudioPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerState>(
      builder: (context, audioPlayerState, child) {
        return Visibility(
          visible: audioPlayerState.isVisible,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.indigo[600],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: const Border(
                bottom: BorderSide(
                  color: Colors.white12,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          audioPlayerState.currentAudioTitle ?? 'No audio',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // IconButton(
                        //   icon: const Icon(Icons.timer_outlined,
                        //       color: Colors.white),
                        //   onPressed: () {
                        //     // Timer action
                        //   },
                        // ),
                        IconButton(
                          icon: Icon(audioPlayerState.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {
                            if (audioPlayerState.isPlaying) {
                              audioPlayerState.pauseAudio();
                            } else {
                              audioPlayerState.resumeAudio();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            audioPlayerState.hidePlayer();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      audioPlayerState.hidePlayer();
                    }
                  },
                  child: Container(
                    height: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//version 6: bottom audioplayer UI can control relaixng sounds also
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mental_wellness_app/state/audio_player_state.dart';

// class PersistentAudioPlayer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AudioPlayerState>(
//       builder: (context, audioPlayerState, child) {
//         return Visibility(
//           visible: audioPlayerState.isVisible,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             height: 70,
//             decoration: BoxDecoration(
//               color: Colors.indigo[600],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               border: const Border(
//                 bottom: BorderSide(
//                   color: Colors.white12,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Text(
//                           audioPlayerState.currentAudioTitle ?? 'No audio',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.timer_outlined,
//                               color: Colors.white),
//                           onPressed: () {
//                             // Timer action
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(audioPlayerState.isPlaying ||
//                                   audioPlayerState.isPlayingAllRelaxingSounds
//                               ? Icons.pause
//                               : Icons.play_arrow),
//                           iconSize: 30,
//                           color: Colors.white,
//                           onPressed: () {
//                             audioPlayerState.toggleAudio();
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white),
//                           onPressed: () {
//                             audioPlayerState.hidePlayer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onVerticalDragEnd: (details) {
//                     if (details.primaryVelocity! > 0) {
//                       audioPlayerState.hidePlayer();
//                     }
//                   },
//                   child: Container(
//                     height: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
