import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyPart1Item extends StatelessWidget {
  final image;
  final title;
  const BodyPart1Item({Key? key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final containerWidth = width * 0.7;
    return image == '' ? const SizedBox.shrink() : Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(bottom :6),
      decoration:  BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
       
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const  Offset(0, 1), // changes position of shadow
          ),
        
        ]
      ),
      child: Column(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 170,
                width: containerWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
         const  SizedBox(height: 6,),
          Container(
            height: 20,
            width: containerWidth * 0.9,
            child: Text(
              title.toString().trim(),
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
