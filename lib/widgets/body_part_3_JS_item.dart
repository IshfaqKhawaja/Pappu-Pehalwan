import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BodyPart3JSItem extends StatelessWidget {
  final title;
  final id;
  final image;
  final subTitle;
  final date;
  final provider;
  final media;
  const BodyPart3JSItem({
    Key? key,
    this.id,
    this.title,
    this.image,
    this.media,
    this.subTitle,
    this.date,
    this.provider,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
   double containerWidth = MediaQuery.of(context).size.width * 0.7 ;
    final style = GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
    const spaceWidget = SizedBox(
      height: 10,
    );
    return Container(
      width: containerWidth,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title.toString().trimLeft(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
          spaceWidget,
          Text(
                DateFormat('MMM dd yyyy').format(date),
                style: style.copyWith(
                  color: Colors.grey,
                ),
              ),
          spaceWidget,
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image != ''
                ? CachedNetworkImage(
                   imageUrl:  image,
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
         
        ],
      ),
    );
  }
}
