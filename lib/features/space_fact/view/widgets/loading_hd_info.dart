import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class LoadingHDInfo extends StatelessWidget {
  const LoadingHDInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Loading HD image',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
            ),
            const SizedBox(width: 4),
            SizedBox(
              height: 15,
              child: JumpingDots(
                color: Colors.white,
                verticalOffset: -8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
