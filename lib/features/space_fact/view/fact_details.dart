import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stellar_secrets/features/space_fact/view/widgets/fact_title.dart';
import 'package:stellar_secrets/features/space_fact/view/widgets/hd_image_button.dart';
import 'package:stellar_secrets/features/space_fact/view/widgets/loading_hd_info.dart';
import 'package:stellar_secrets/features/space_fact/view/widgets/new_fact_button.dart';
import 'package:stellar_secrets/features/space_fact/view/widgets/photo_copyright.dart';
import 'package:stellar_secrets/features/space_fact/view/widgets/photo_date.dart';
import 'dart:ui' as ui;

import 'package:stellar_secrets/features/space_fact/view/widgets/zoom_image_button.dart';

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
                    if (url != hdUrl)
                      HDImageButton(
                        isImageHD: isImageHD.value,
                        onPressed: () {
                          isImageHD.value = !isImageHD.value;
                          isImageHDLoading.value = isImageHD.value;
                        },
                      ),
                    ZoomImageButton(
                        url: isImageHD.value && !isImageHDLoading.value
                            ? hdUrl
                            : url),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            FactTitle(title: title),
                            if (isImageHDLoading.value) const LoadingHDInfo(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                if (copyright != '')
                                  PhotoCopyright(copyright: copyright),
                                if (date != '') PhotoDate(date: date),
                              ],
                            ),
                          ),
                          if (date != '') const NewFactButton(),
                        ],
                      )
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
