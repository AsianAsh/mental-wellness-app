import 'dart:math';
import 'package:flutter/material.dart';

class SineWaveWidget extends StatelessWidget {
  final Animation<double> animation;

  const SineWaveWidget({required this.animation, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SinePainter(animation),
          child: Container(),
        );
      },
    );
  }
}

class SinePainter extends CustomPainter {
  final Animation<double> _animation;

  SinePainter(this._animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint gradientPaint = Paint()
      ..shader = LinearGradient(colors: [
        Colors.white70,
        Colors.white70,
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)
          .createShader(Rect.fromLTWH(10, 0, size.width, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Path path = Path()..moveTo(0, size.height / 2);

    for (int i = 0; i <= 45; i++) {
      path.lineTo(
        -size.width / 2 + i * (size.width * 1.5) / 30,
        size.height / 2 + sin(_animation.value + i * pi / 15) * 20,
      );
    }

    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
