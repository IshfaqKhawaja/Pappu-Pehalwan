import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'play_video.dart';
import 'show_annoncement_files.dart';
import 'package:share_plus/share_plus.dart';
class ViewFBPost extends StatefulWidget {
  final id;
  final title;
  final date;
  final attachement;
  final media;
  final description;
  final appbarTitle;
  const ViewFBPost({
    Key? key,
    this.id,
    this.title,
    this.appbarTitle,
    this.date,
    this.media,
    this.attachement,
    this.description,
  }) : super(key: key);

  @override
  State<ViewFBPost> createState() => _ViewFBPostState();
}

class _ViewFBPostState extends State<ViewFBPost> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appbarTitle??'',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 20,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async  {
              final box = context.findRenderObject() as RenderBox?;

              await Share.share(
                    'https://play.google.com/store/apps/details?id=com.quantumcoders.jeevansetu',
                    subject: 'Jiwan Setu App on PlayStore',
                    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4).copyWith(top: 2,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.attachement.length > 0)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: ShowAnnoncementFiles(
                    files: widget.attachement,
                    isHomeScreen: true,
                  ),
                ),
              if (widget.attachement.length == 0 &&
                  widget.media != null &&
                  widget.media['type'] == "video_inline")
                PlayVideo(
                  type: 'network',
                  video: widget.media['media']['source'],
                ),
              if (widget.attachement.length == 0 &&
                  widget.media != null &&
                  widget.media['type'] == "photo")
                CachedNetworkImage(
                  imageUrl: widget.media['media']['image']['src'],
                  fit: BoxFit.cover,
                ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: SelectableText(
                      widget.title.toString().trimLeft(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('MMM dd yyyy').format(widget.date),
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        icon: const Icon(Icons.favorite),
                        color: isLiked ? Colors.redAccent : Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: SelectableText(
                      widget.description.toString().trimLeft(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
