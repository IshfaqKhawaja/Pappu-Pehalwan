import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'play_video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class ShowAnnoncementFiles extends StatefulWidget {
  static const routeName = '/show-annoncement-files';
  final files;
  final isHomeScreen;
  ShowAnnoncementFiles({
    this.files,
    this.isHomeScreen = false,
  });

  @override
  _ShowAnnoncementFilesState createState() => _ShowAnnoncementFilesState();
}

class _ShowAnnoncementFilesState extends State<ShowAnnoncementFiles> {
  bool fit = true;
  final _controller = CarouselController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
            options: CarouselOptions(
                height: 290,
                autoPlay: false,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
                aspectRatio: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                onPageChanged: (index, _){
                  setState(() {
                    this.index = index;
                  });
                
                },
                ),
            itemCount: widget.files.length,

            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              String type = widget.files[index]['type'];

              return Container(
                child: Center(
                  child: type.toUpperCase() == 'photo'.toUpperCase()
                      ? InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierColor: Colors.white.withOpacity(0.4),
                                builder: (_) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0.0,
                                    child: Container(
                                      color: Colors.transparent,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: PhotoView(
                                        backgroundDecoration:
                                            const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        imageProvider:
                                            CachedNetworkImageProvider(
                                          widget.files[index]['media']['image']
                                              ['src'],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            imageUrl: widget.files[index]['media']['image']
                                ['src'],
                            fit: fit ? BoxFit.cover : BoxFit.contain,
                          ),
                        )
                      : PlayVideo(
                          video: widget.files[index]['url'],
                          type: 'network',
                        ),
                ),
              );
            }),
        if (widget.files.length > 1)
          Positioned(
            right: 6,
            child: Chip(
              label: Text(
                '${index + 1} / ${widget.files.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              backgroundColor: Colors.black54,
            ),
          ),
      ],
    );
  }
}
