import 'package:flutter/material.dart';

class FactTitle extends StatelessWidget {
  final String title;

  const FactTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21,
        fontFamily: 'AclonicaRegular',
        shadows: [
          Shadow(
            blurRadius: 6.0,
            offset: Offset(
              0.0,
              5.0,
            ),
          ),
          Shadow(
            blurRadius: 6.0,
            offset: Offset(
              5.0,
              0.0,
            ),
          ),
        ],
      ),
    );
  }
}
