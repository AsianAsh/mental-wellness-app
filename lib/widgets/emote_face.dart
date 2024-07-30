import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {
  final String emoticonFace;

  const EmoticonFace({
    Key? key,
    required this.emoticonFace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          emoticonFace,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
