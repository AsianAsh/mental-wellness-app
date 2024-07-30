// displaying counsellor/member details in an appointment
import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final VoidCallback? onTap;
  final bool isLink;

  const DetailRow({
    required this.title,
    required this.value,
    this.valueColor,
    this.onTap,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: onTap != null
                  ? TextButton(
                      onPressed: onTap,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: valueColor ?? Colors.blue,
                          decoration: isLink ? TextDecoration.underline : null,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: valueColor ?? Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.right,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
