import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/load_data_from_facebook.dart';
import '../widgets/body_part_3_item.dart';
import '../widgets/view_fb_post.dart';
import 'package:provider/provider.dart';

class BodyPart3 extends StatefulWidget {
  const BodyPart3({Key? key}) : super(key: key);

  @override
  State<BodyPart3> createState() => _BodyPart3State();
}

class _BodyPart3State extends State<BodyPart3> {
  int currentIndex = 0;
  final controller = ScrollController();
  List posts = [];
  
  @override
  void initState() {
    super.initState();
    posts = Provider.of<LoadDataFromFacebook>(context, listen: false).getPosts;
  
    controller.addListener(() {
      setState(() {
        currentIndex =
            controller.offset ~/ (MediaQuery.of(context).size.width * 0.75);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
 
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text('पप्पू पहलवान',
               style: GoogleFonts.openSans(
                 color: Colors.black.withOpacity(0.7),
                 fontSize: 16,
                 fontWeight: FontWeight.w800,
               ),
               ),
          posts.length == 0
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: List.generate(posts.length, (index) {
                      String description = '';
                      final containsDescription =
                          (posts[index]['message'] as String)
                              .contains('Description');
                      if (!containsDescription) {
                        description = '';
                      } else {
                        description = (posts[index]['message'] as String)
                            .split('Description')[1]
                            .replaceAll(':', '');
                      }
                      return OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                           openColor: Theme.of(context).backgroundColor,
                          closedColor: Theme.of(context).backgroundColor,
                          // transitionDuration: const Duration(milliseconds: 1000),
                          closedBuilder: (_, __) => BodyPart3Item(
                                key: ValueKey(posts[index]['id']),
                                title: posts[index]['title'],
                                subTitle: '',
                                provider: 'Facebook',
                                image: posts[index].containsKey('media') &&
                                        posts[index]['media']
                                            .containsKey('media') &&
                                        posts[index]['media']['media']
                                            .containsKey('image') &&
                                        posts[index]['media']['media']['image']
                                            .containsKey('src')
                                    ? posts[index]['media']['media']['image']
                                        ['src']
                                    : '',
                                media: posts[index]['media'],
                                date: 
                                    DateTime.parse(posts[index]['date']),
                                comments: 100,
                                likes: 200,
                                shares: 29,
                              ),
                          openBuilder: (_, __) => ViewFBPost(
                                id: posts[index]['id'],
                                title: posts[index]['title'],
                                appbarTitle: 'From Facebook',
                                description: description,
                                date: 
                                    DateTime.parse(posts[index]['date']),
                                attachement:
                                    posts[index].containsKey('subattachments')
                                        ? posts[index]['subattachments']
                                        : [],
                                media: posts[index]['media'],
                              ));
                    }),
                  ),
              ),
        ],
      ),
    );
  }
}
