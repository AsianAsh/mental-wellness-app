// widgets/routine_section.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_app/widgets/task_card.dart';

class RoutineSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<TaskCard> tasks;

  RoutineSection({
    required this.title,
    required this.icon,
    required this.tasks,
  });

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
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
