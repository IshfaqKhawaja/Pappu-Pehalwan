import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BodyPart3Item extends StatefulWidget {
  final title;
  final id;
  final image;
  final subTitle;
  final date;
  final provider;
  final media;
  final likes;
  final comments;
  final shares;
  const BodyPart3Item({
    Key? key,
    this.id,
    this.title,
    this.image,
    this.media,
    this.subTitle,
    this.date,
    this.provider,
    this.comments,
    this.likes,
    this.shares,
  }) : super(key: key);

  @override
  State<BodyPart3Item> createState() => _BodyPart3ItemState();
}

class _BodyPart3ItemState extends State<BodyPart3Item> {
  bool isLiked = false;
  void changeIsLiked() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width  * 0.9 ;
    final style = GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
    const spaceWidget = SizedBox(
      height: 10,
    );
    return Container(
      width: containerWidth,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        top: 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: widget.image != ''
                ? CachedNetworkImage(
                   imageUrl:  widget.image,
                    height: 200,
                    width: containerWidth,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/news1.jpg',
                    height: 200,
                    width: containerWidth,
                    fit: BoxFit.cover,
                  ),
          ),
        spaceWidget,
        spaceWidget,

          Text(
            widget.title.toString().trimLeft(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
        //  const SizedBox(
        //     height: 2,          
        //   ),
            Text(
                DateFormat('MMM dd yyyy').format(widget.date),
                style: style.copyWith(
                  color: Colors.grey,
                ),
              ),
          // Row(
          //   children: [
          //     Text(
          //       widget.provider,
          //       style: style.copyWith(
          //         color: Colors.red,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
            
          //   ],
          // ),
         
          // spaceWidget,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     IconButton(
          //       onPressed: changeIsLiked,
          //       icon: Icon(
          //         Icons.thumb_up,
          //         color: isLiked ? Colors.redAccent : Colors.grey,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Text(
          //       widget.likes.toString(),
          //       style: style.copyWith(
          //         color: Colors.black,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     const Icon(
          //       Icons.comment,
          //       color: Colors.grey,
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Text(
          //       widget.comments.toString(),
          //       style: style.copyWith(
          //         color: Colors.black,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     const Icon(
          //       Icons.share,
          //       color: Colors.grey,
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Text(
          //       widget.shares.toString(),
          //       style: style.copyWith(
          //         color: Colors.black,
          //       ),
          //     ),
          //   ],
          // ),
        //  const  Divider(
        //     color: Colors.black,
        //     height: 4,
        //   )
          // spaceWidget,
          // Text(
          //   widget.subTitle,
          //   style: style.copyWith(
          //     fontSize: 16,
          //     color: Colors.black.withOpacity(0.7),
          //   ),
          // ),
        ],
      ),
    );
  }
}
