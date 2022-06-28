
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/load_data_from_facebook.dart';
import '../screens/tag_story.dart';
import 'package:provider/provider.dart';

class AppBarItem extends StatefulWidget {
  final title;
  const AppBarItem({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<AppBarItem> createState() => _AppBarItemState();
}

class _AppBarItemState extends State<AppBarItem> {
  List posts = [];
  @override
  void initState() {
    super.initState();
    posts = Provider.of<LoadDataFromFacebook>(context, listen: false).getPosts;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.redAccent,
      onTap: () {
        // var rng = Random();
        // int index = rng.nextInt(posts.length);
        // String description = '';
        //             final containsDescription =
        //                 (posts[index]['message'] as String)
        //                     .contains('Description');
        //             if (!containsDescription) {
        //               description = '';
        //             } else {
        //               description = (posts[index]['message'] as String)
        //                   .split('Description')[1]
        //                   .replaceAll(':', '');
        //             }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TagStory(
              title: widget.title,
            )
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
            color: const Color(0xff1f3853),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Color(0xff001322),
                // blurRadius: 10,
                // spreadRadius: 10,
              ),
            ]),
        child: Text(
          widget.title,
          style: GoogleFonts.openSans(
            color: Theme.of(context).iconTheme.color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
