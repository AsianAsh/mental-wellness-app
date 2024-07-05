import 'package:flutter/material.dart';
import 'package:mental_wellness_app/views/mood_tracker_screen.dart';
import 'package:mental_wellness_app/views/profile_screen.dart';
import 'package:get/get.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
  }

  void _preloadImages() {
    // List of image assets to preload
    const List<String> imageAssets = [
      'assets/images/relaxing/relaxing_sounds_1.png',
    ];

    for (String imagePath in imageAssets) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // Daily Task Title + Profile Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Routine',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.whatshot,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '20',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  // Navigate to the ProfileScreen
                  Get.to(ProfileScreen());
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Expanded(
            child: ListView(
              children: [
                RoutineSection(
                  title: 'Morning',
                  icon: Icons.sunny_snowing,
                  tasks: [
                    TaskCard(
                      icon: Icons.brightness_5,
                      category: 'Breath',
                      title: 'Irritation',
                      description: '3 min meditation',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                    ),
                    TaskCard(
                      icon: Icons.article,
                      category: 'Articles',
                      title: '12 Habits of Happy Women',
                      description: '2 min read',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                    ),
                  ],
                ),
                RoutineSection(
                  title: 'Day',
                  icon: Icons.sunny,
                  tasks: [
                    TaskCard(
                      icon: Icons.school,
                      category: 'Course',
                      title: 'Anxiety',
                      description: 'Create a sense of balance and peace',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                    ),
                    TaskCard(
                      icon: Icons.self_improvement,
                      category: 'Meditation',
                      title: 'Showering',
                      description: '',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                    ),
                  ],
                ),
                RoutineSection(
                  title: 'Evening',
                  icon: Icons.nights_stay,
                  tasks: [
                    TaskCard(
                      icon: Icons.nights_stay,
                      category: 'Sleep Story',
                      title: 'Calm Sleep',
                      description: '5 min story',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                    ),
                    TaskCard(
                      icon: Icons.music_note,
                      category: 'Sleep Sound',
                      title: 'Ocean Waves',
                      description: '10 min sound',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                    ),
                    TaskCard(
                      icon: Icons.sentiment_satisfied_alt,
                      category: 'Mood Tracking',
                      title: 'Mood Tracker',
                      description: 'Track your mood',
                      image: 'assets/images/relaxing/relaxing_sounds_1.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoodTrackerScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class RoutineSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<TaskCard> tasks;

  RoutineSection(
      {required this.title, required this.icon, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: tasks
              .map((task) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: task),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class TaskCard extends StatefulWidget {
  final IconData icon;
  final String category;
  final String title;
  final String description;
  final String image;
  final VoidCallback? onTap; // Optional onTap callback

  TaskCard({
    required this.icon,
    required this.category,
    required this.title,
    required this.description,
    required this.image,
    this.onTap,
  });

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Handle tap
      child: Row(
        children: [
          // Circular Checkbox
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
            shape: CircleBorder(), // Make the checkbox circular
            checkColor: Colors.white,
            activeColor: Colors.indigo[600], // Checkbox color when checked
            materialTapTargetSize: MaterialTapTargetSize
                .shrinkWrap, // Remove extra padding around checkbox
          ),
          // Task Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.indigo[600],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(widget.icon, color: Colors.white, size: 22),
                            const SizedBox(
                                width: 8), // Add spacing between icon and text
                            Text(
                              widget.category,
                              style: TextStyle(
                                color: Colors.indigo[100],
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height:
                                10), // Add some spacing between category row and title
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.blue[100],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                    child: Image.asset(
                      widget.image,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
