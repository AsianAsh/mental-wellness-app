import 'package:flutter/material.dart';
import 'package:mental_wellness_app/views/profile_screen.dart';
import './random_words.dart';
import 'package:get/get.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          // Daily Task Title + Profile Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wellness Routine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Navigate to the ProfileScreen
                  Get.to(const ProfileScreen());
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              // Icon(
              //   Icons.person,
              //   color: Colors.white,
              // ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          // Random Words Page Button
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RandomWords()),
                  );
                },
                child: const Text('Go to Random Words'),
              ),
            ),
          ]),

          // Sized Box for space between components
          const SizedBox(
            height: 20,
          ),

          // Search bar
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(12),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Search',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Expanded(
            child: ListView(
              children: [
                RoutineSection(
                  title: 'Morning',
                  icon: Icons.wb_sunny,
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
                  icon: Icons.wb_cloudy,
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
                  icon: Icons.nightlight_round,
                  tasks: [
                    TaskCard(
                      icon: Icons.bedtime,
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
                fontSize: 24,
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
                        Column(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 80,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
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

class TaskCard extends StatelessWidget {
  final IconData icon;
  final String category;
  final String title;
  final String description;
  final String image;

  TaskCard({
    required this.icon,
    required this.category,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              image,
              width: 80,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
