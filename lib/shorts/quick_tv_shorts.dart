import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickTVShorts extends StatefulWidget {
  final media;
  final type;
  final title;
  const QuickTVShorts({
    Key? key,
    this.media,
    this.title,
    this.type,
  }) : super(key: key);

  @override
  State<QuickTVShorts> createState() => _QuickTVShortsState();
}

class _QuickTVShortsState extends State<QuickTVShorts> {
  bool halt = false;
  bool isLiked = false;
  int index = 0;
  double widthFactor = 0.0;
  bool isFit = true;

  void returnFunction() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: ((context) => Body()),),
    //   (route) => false,

    // );
  }

  void changeImage() async {
    if (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      while (widthFactor < 1.0) {
        await Future.delayed(const Duration(
          microseconds: 1000,
        ));
        if (mounted) {
          setState(() {
            widthFactor = widthFactor + 0.001;
          });
        } else {
          break;
        }
      }
      if (mounted) {
        if (index < widget.media.length - 1) {
          if (mounted) {
            setState(() {
              index++;
              widthFactor = 0.0;
            });
          }
        } else {
          if (mounted) {
            returnFunction();
          }
        }
        if (mounted) {
          changeImage();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    changeImage();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: InkWell(
        onDoubleTap: () {
          setState(() {
            isFit = !isFit;
          });
        },
        onTap: () {
          if (mounted) {
            if (index < widget.media.length - 1) {
              if (mounted) {
                setState(() {
                  index++;
                  widthFactor = 0.0;
                  changeImage();
                });
              }
            } else {
              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          }
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            
            children: [
              widget.type == 'image'
                  ? Hero(
                      tag: widget.media[0]['media']['image']['src'],
                      child: CachedNetworkImage(
                        imageUrl: widget.media[index]['media']['image']['src'],
                        height: height,
                        width: width,
                        fit:  BoxFit.contain,
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                bottom: 6,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 4,
                      ),
                      width: width,
                      child: Text(
                        widget.title.toString().trim(),
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Slider :
                    Row(
                      children: [
                        ...List.generate(widget.media.length, (index) {
                          return Container(
                            width: width / widget.media.length,
                            margin: const EdgeInsets.only(right: 5),
                            height: 3,
                            color: Colors.black,
                            child: FractionallySizedBox(
                              widthFactor: index < this.index ? 1 : widthFactor,
                              heightFactor: 1.0,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                color: index < this.index
                                    ? Colors.white
                                    : index == this.index
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          );
                        })
                      ],
                    )
                  ],
                ),
              ),
              // Buttons
              Positioned(
                right: 10,
                bottom: 100,
                child: Column(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : Colors.white,
                            size: 35,
                          ),
                        ),
                        Text(
                          '12k',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        Text(
                          '2k',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shortcut,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        Text(
                          '120',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
