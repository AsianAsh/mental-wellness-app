// similar to detail_row.dart but for longer content
import 'package:flutter/material.dart';

class LongDetail extends StatelessWidget {
  final String title;
  final String value;

  const LongDetail({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
