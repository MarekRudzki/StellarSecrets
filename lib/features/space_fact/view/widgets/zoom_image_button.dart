// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:photo_view/photo_view.dart';

class ZoomImageButton extends StatelessWidget {
  final String url;

  const ZoomImageButton({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: IconButton(
          icon: const Icon(
            Icons.search,
            size: 28,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 2),
                backgroundColor: Colors.black,
                child: PhotoView(
                  basePosition: Alignment.topCenter,
                  imageProvider: NetworkImage(
                    url,
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 6,
                  controller: PhotoViewController(),
                  tightMode: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
