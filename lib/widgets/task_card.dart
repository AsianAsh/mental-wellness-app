// widgets/task_card.dart
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final IconData icon;
  final String category;
  final String title;
  final String description;
  final String image;
  final ValueNotifier<bool> isCompleted;
  final VoidCallback? onTap;

  TaskCard({
    required this.icon,
    required this.category,
    required this.title,
    required this.description,
    required this.image,
    required this.isCompleted,
    this.onTap,
  });

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isCompleted,
      builder: (context, isCompleted, child) {
        bool isMoodTracker = widget.category == 'Mood Tracker';
        return GestureDetector(
          onTap: isMoodTracker || !isCompleted ? widget.onTap : null,
          child: Opacity(
            opacity: isMoodTracker ? 1.0 : (isCompleted ? 0.5 : 1.0),
            child: Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: null,
                  shape: CircleBorder(),
                  checkColor: Colors.white,
                  activeColor: Colors.indigo[600],
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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
                                  Icon(widget.icon,
                                      color: Colors.white, size: 22),
                                  const SizedBox(width: 8),
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
                              const SizedBox(height: 10),
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
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(widget.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
