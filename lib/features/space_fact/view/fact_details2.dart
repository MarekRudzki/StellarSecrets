import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart';

class FactDetails2 extends HookWidget {
  final String copyright;
  final String date;
  final String description;
  final String hdUrl;
  final String title;
  final String url;

  const FactDetails2({
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

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: isImageHD.value ? hdUrl : url,
                placeholder: (context, url) => Container(
                  height: double.infinity,
                  child: Image.asset(
                    'assets/loading.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // FadeInImage(
              //   placeholder: const AssetImage(
              //     'assets/loading.png',
              //   ),
              //   image: NetworkImage(
              //     isImageHD.value ? hdUrl : url,
              //   ),
              // ),
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
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              10,
              15,
              10,
              15,
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
              ],
            ),
          ),
        ],
      ),
    );

    // return FutureBuilder<ui.Image>(
    //   future: completer.future,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return
    //     } else {
    //       return Container(
    //         height: double.infinity,
    //         child: Image.asset(
    //           'assets/loading.png',
    //           fit: BoxFit.cover,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
