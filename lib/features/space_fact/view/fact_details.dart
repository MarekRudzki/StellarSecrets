import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:ui' as ui;

class FactDetails extends HookWidget {
  final String copyright;
  final String date;
  final String description;
  final String hdUrl;
  final String title;
  final String url;

  const FactDetails({
    super.key,
    required this.copyright,
    required this.date,
    required this.description,
    required this.hdUrl,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final isImageHD = useState(false);
    final isImageHDLoading = useState(false);

    final Image image = Image.network(isImageHD.value ? hdUrl : url);
    final completer = Completer<ui.Image>();
    image.image
        .resolve(ImageConfiguration.empty)
        .addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
      completer.complete(info.image);
      if (isImageHD.value) {
        isImageHDLoading.value = false;
      }
    }));

    return FutureBuilder<ui.Image>(
      future: completer.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage(
                        'assets/loading.png',
                      ),
                      image: NetworkImage(
                        isImageHD.value ? hdUrl : url,
                      ),
                    ),
                    Positioned(
                      bottom: 70.0,
                      right: 10.0,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: IconButton(
                          icon: Icon(
                            Icons.hd_outlined,
                            size: 28,
                            color: isImageHD.value ? Colors.green : Colors.grey,
                          ),
                          onPressed: () {
                            isImageHD.value = !isImageHD.value;
                            isImageHDLoading.value = isImageHD.value;
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
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
                                insetPadding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                backgroundColor: Colors.black,
                                child: PhotoView(
                                  basePosition: Alignment.topCenter,
                                  imageProvider: NetworkImage(
                                    url,
                                  ),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.covered * 4,
                                  controller: PhotoViewController(),
                                  tightMode: true,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // if (isImageHDLoading.value)
                    //   const Positioned(
                    //     top: 80.0,
                    //     right: 50.0,
                    //     child: Text(
                    //       'Loading HD image',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18,
                    //         fontFamily: 'AclonicaRegular',
                    //         shadows: [
                    //           Shadow(
                    //             blurRadius: 6.0,
                    //             offset: Offset(
                    //               0.0,
                    //               5.0,
                    //             ),
                    //           ),
                    //           Shadow(
                    //             blurRadius: 6.0,
                    //             offset: Offset(
                    //               5.0,
                    //               0.0,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Text(
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
                            ),
                            if (isImageHDLoading.value)
                              const Column(
                                children: [
                                  SizedBox(height: 50),
                                  Text(
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
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    10,
                    15,
                    10,
                    date == '' ? 15 : 30,
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
                        ),
                      if (date != '')
                        Padding(
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
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: double.infinity,
            child: Image.asset(
              'assets/loading.png',
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}
