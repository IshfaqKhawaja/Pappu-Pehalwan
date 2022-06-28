import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../screens/news_web.dart';

class NewsItem extends StatefulWidget {
  final title;
  final image;
  final url;
  final provider;
  final date;
  final likes;
  final shares;
  final comments;
  const NewsItem({
    Key? key,
    this.title,
    this.url,
    this.provider,
    this.date,
    this.likes,
    this.comments,
    this.shares,
    this.image,
  }) : super(key: key);

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool isLiked = false;
  void changeIsLiked() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;
    final style = GoogleFonts.openSans(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    );
    const spaceWidget = SizedBox(
      height: 10,
    );
    return InkWell(
      onTap:(){
        Navigator.of(context).push(
           MaterialPageRoute(
            builder: (_) => NewsWeb(url:widget.url,title:widget.title),
           ),          
          );
      },
      child: Container(
        width: containerWidth,
        height: 400,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 0,
        ).copyWith(right: 10,),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Column(
          children: [
            Container(
              width: containerWidth,
              child: Text(
                widget.title + '...',
                maxLines: 2,
                style: style,
              ),
            ),
            spaceWidget,
            Row(
              children: [
                Text(
                  widget.provider,
                  style: style.copyWith(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('dd MMM').format(widget.date),
                  style: style.copyWith(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            spaceWidget,
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.image,
                height: 200,
                width: containerWidth,
                fit: BoxFit.cover,
              ),
            ),
            spaceWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: changeIsLiked,
                  icon: Icon(
                    Icons.thumb_up,
                    color: isLiked ? Colors.redAccent : Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.likes.toString(),
                  style: style.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.comments.toString(),
                  style: style.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.share,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.shares.toString(),
                  style: style.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            spaceWidget,
          ],
        ),
      ),
    );
  }
}
