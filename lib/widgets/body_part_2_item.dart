import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view_fb_post.dart';

class BodyPart2Item extends StatefulWidget {
  final images;
  final title;
  final hpccPost;
  const BodyPart2Item({Key? key, this.images, this.title, this.hpccPost,}) : super(key: key);

  @override
  State<BodyPart2Item> createState() => _BodyPart2ItemState();
}

class _BodyPart2ItemState extends State<BodyPart2Item> {
  Widget closedConatiner() {
    double width = 120;
    double height = 200;
    return widget.images.length == 0
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.images[0]['media']['image']['src'],
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
               if(widget.title != '') 
               Positioned(
                  bottom: 1,
                  child: Container(
                    width: width,
                    // height: 40,
                    color: Colors.black.withOpacity(0.2),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      widget.title.toString().trim(),
                      textAlign: TextAlign.justify,
                      // overflow: TextOverflow.ellipsis,
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
     String description = '';
                    final containsDescription =
                        (widget.hpccPost['message'] as String)
                            .contains('Description');
                    if (!containsDescription) {
                      description = '';
                    } else {
                      description = (widget.hpccPost['message'] as String)
                          .split('Description')[1]
                          .replaceAll(':', '');
                    }
    return OpenContainer(
      closedBuilder: (context, action) => closedConatiner(),
      // transitionDuration: const Duration(milliseconds: 1000),
      transitionType: ContainerTransitionType.values[1],
      openBuilder: (context, action) => ViewFBPost(
                      id: widget.hpccPost['id'],
                      title: widget.hpccPost['title'],
                      appbarTitle: 'समाचार',
                      description: description,
                      date: DateTime.parse(widget.hpccPost['date']),
                      attachement:
                         widget.hpccPost.containsKey('subattachments')
                              ? widget.hpccPost['subattachments']
                              : [],
                      media: widget.hpccPost['media'],
                    ),
    );
  }
}
