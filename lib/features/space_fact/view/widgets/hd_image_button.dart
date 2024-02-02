import 'package:flutter/material.dart';

class HDImageButton extends StatelessWidget {
  final bool isImageHD;
  final VoidCallback onPressed;

  const HDImageButton({
    super.key,
    required this.isImageHD,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 70.0,
      right: 10.0,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: IconButton(
          icon: Icon(
            Icons.hd_outlined,
            size: 28,
            color: isImageHD ? Colors.green : Colors.grey,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
