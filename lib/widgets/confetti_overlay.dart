import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ConfettiOverlay extends StatefulWidget {
  final Widget child;

  const ConfettiOverlay({Key? key, required this.child}) : super(key: key);

  @override
  _ConfettiOverlayState createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> {
  final _controller = ConfettiController(duration: const Duration(seconds: 20));

  @override
  void initState() {
    super.initState();
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirection: pi / 2,
            emissionFrequency: 0.02, // Reduced emission frequency
            numberOfParticles: 15, // Reduced number of particles
            blastDirectionality:
                BlastDirectionality.explosive, // Spread out in all directions
            gravity: 0.05, // Reduced gravity for slower falling confetti
            colors: const [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
            ],
          ),
        ),
      ],
    );
  }
}
