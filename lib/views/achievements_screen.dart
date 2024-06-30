import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: Colors.indigo, // Distinct app bar color
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              AchievementCard(
                icon: Icons.book,
                title: 'Finishing a Book',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              AchievementCard(
                icon: Icons.add,
                title: 'Adding a Book',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              AchievementCard(
                icon: Icons.rate_review,
                title: 'Giving a Review',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              AchievementCard(
                icon: Icons.star,
                title: 'First Reader',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              AchievementCard(
                icon: Icons.bookmark,
                title: 'Pages Read',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              AchievementCard(
                icon: Icons.star_rate,
                title: 'Star Rating',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              AchievementCard(
                icon: Icons.list,
                title: 'Finishing Influence List',
                description:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
              ),
              // Add more AchievementCard widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AchievementCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            HexagonIcon(
              icon: icon,
              size: 50,
              color: Colors.indigo,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HexagonIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const HexagonIcon({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: HexagonPainter(color: color),
        ),
        Icon(
          icon,
          size: size * 0.6, // Adjust the icon size to fit inside the hexagon
          color: Colors.white,
        ),
      ],
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    final double width = size.width;
    final double height = size.height;

    path.moveTo(width * 0.5, 0);
    path.lineTo(width, height * 0.25);
    path.lineTo(width, height * 0.75);
    path.lineTo(width * 0.5, height);
    path.lineTo(0, height * 0.75);
    path.lineTo(0, height * 0.25);
    path.close();

    canvas.drawPath(path, paint);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;
    paint.color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
