import 'package:flutter/material.dart';

class PhotoCopyright extends StatelessWidget {
  final String copyright;

  const PhotoCopyright({
    super.key,
    required this.copyright,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Text(
            'Photo copyright: ',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              copyright.replaceAll('\n', ''),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
