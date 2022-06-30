import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/load_data_from_facebook.dart';
import '../widgets/body_part_1_item.dart';
import '../widgets/view_fb_post.dart';
import 'package:provider/provider.dart';

class BodyPart1 extends StatefulWidget {
  const BodyPart1({Key? key}) : super(key: key);

  @override
  State<BodyPart1> createState() => _BodyPart1State();
}

class _BodyPart1State extends State<BodyPart1> {
  int index = 0;
  int currentIndex = 0;
  List featuredPosts = [];
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    featuredPosts = Provider.of<LoadDataFromFacebook>(context, listen: false)
        .getFeaturedPosts;
    _controller.addListener(() {
      setState(() {
        currentIndex =
            _controller.offset ~/ (MediaQuery.of(context).size.width * 0.69);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 10),
            child: Text('सार्वजनिक हित जानकारी',
                style: GoogleFonts.openSans(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
                ),
          ),
          SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            
            child: Row(
              children: List.generate(
                featuredPosts.length,
                (index) => OpenContainer(
                  // transitionDuration: const Duration(milliseconds: 1000),
                  transitionType: ContainerTransitionType.fade,
                  openColor: Theme.of(context).backgroundColor,
                  closedColor: Theme.of(context).backgroundColor,

                  closedBuilder: (_, __) {
                    return Row(
                      children: [
                        BodyPart1Item(
                          image: featuredPosts[index].containsKey('media') &&
                                  featuredPosts[index]['media']
                                      .containsKey('media') &&
                                  featuredPosts[index]['media']['media']
                                      .containsKey('image') &&
                                  featuredPosts[index]['media']['media']['image']
                                      .containsKey('src')
                              ? featuredPosts[index]['media']['media']['image']['src']
                              : '',
                          title: featuredPosts[index]['title'],
                        ),
                        
                      ],
                    );
                  },
                  openBuilder: (_, __) {
                    String description = '';
                    final containsDescription =
                        (featuredPosts[index]['message'] as String)
                            .contains('Description');
                    if (!containsDescription) {
                      description = '';
                    } else {
                      description = (featuredPosts[index]['message'] as String)
                          .split('Description')[1]
                          .replaceAll(':', '');
                    }
                    return ViewFBPost(
                      id: featuredPosts[index]['id'],
                      title: featuredPosts[index]['title'],
                      appbarTitle: 'Featured',
                      description: description,
                      date: DateTime.parse(featuredPosts[index]['date']),
                      attachement:
                          featuredPosts[index].containsKey('subattachments')
                              ? featuredPosts[index]['subattachments']
                              : [],
                      media: featuredPosts[index]['media'],
                    );
                  },
                ),
              ),
            ),
          ),
                   const SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                featuredPosts.length,
                (index) => Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: CircleAvatar(
                        backgroundColor:
                            index == currentIndex ? Theme.of(context).primaryColor : Colors.grey,
                        radius: index == currentIndex ? 5 : 4,
                      ),
                    )),
          ),
         const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
