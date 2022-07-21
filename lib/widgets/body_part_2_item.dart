import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view_fb_post.dart';

class BodyPart2Item extends StatefulWidget {
  final images;
  final title;
  final hpccPost;

  const BodyPart2Item({
    Key? key,
    this.images,
    this.title,
    this.hpccPost,
  }) : super(key: key);

  @override
  State<BodyPart2Item> createState() => _BodyPart2ItemState();
}

class _BodyPart2ItemState extends State<BodyPart2Item> {
  Widget closedConatiner() {
    double width = 120;
    double height = 200;
    return widget.images.length == 0 || widget.images[0].length == 0
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.images[0]['media']['image']['src'] ?? '',
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    width: width,
                    color: Colors.black.withOpacity(0.2),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      widget.title.toString().trim(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                        fontSize: 10,
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {

    return OpenContainer(
      closedBuilder: (context, action) => closedConatiner(),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openColor: Theme.of(context).scaffoldBackgroundColor,
      transitionType: ContainerTransitionType.values[1],
      openBuilder: (context, action) => ViewFBPost(
        id: widget.hpccPost['id'],
        title: widget.hpccPost['title'],
        appbarTitle: 'हर दिन अद्यतन',
        description: widget.hpccPost['message'] ?? '',
        date: DateTime.parse(widget.hpccPost['date']),
        attachement: widget.hpccPost.containsKey('subattachments')
            ? widget.hpccPost['subattachments']
            : [],
        media: widget.hpccPost['media'],
        type: widget.hpccPost['type'],
      ),
    );
  }
}
