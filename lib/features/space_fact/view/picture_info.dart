import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PictureInfo extends StatelessWidget {
  final String copyright;
  final String description;
  final String hdUrl;
  final String title;
  final String url;

  const PictureInfo({
    super.key,
    required this.copyright,
    required this.description,
    required this.hdUrl,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.png'),
                  image: NetworkImage(url),
                ),
                onTap: () {
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
                        maxScale: PhotoViewComputedScale.covered * 3,
                        controller: PhotoViewController(),
                        tightMode: true,
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'AclonicaRegular',
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: Column(
              children: [
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(),
                ),
                if (copyright != '')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          'Photo copyright: ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          copyright.replaceAll('\n', ''),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
