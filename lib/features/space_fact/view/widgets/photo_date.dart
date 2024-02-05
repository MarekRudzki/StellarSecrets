// Flutter imports:
import 'package:flutter/material.dart';

class PhotoDate extends StatelessWidget {
  final String date;

  const PhotoDate({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Text(
            'Photo date: ',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            date,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
