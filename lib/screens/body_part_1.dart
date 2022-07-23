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
  List posts = [];
  final _controller = ScrollController();
  int displayPostDots = 10;
  List displayPosts = [];
  int start = 0;
  int stop = 5;
  int count = 5;

  void getDisplayPosts(int start, int stop) {
    setState(() {
      if (stop < featuredPosts.length && start < featuredPosts.length) {
        displayPosts.addAll(featuredPosts.sublist(start, stop));
      } else if (stop >= featuredPosts.length && start < featuredPosts.length) {
        displayPosts.addAll(featuredPosts.sublist(start));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    posts = Provider.of<LoadDataFromFacebook>(context, listen: false).getPosts;
    featuredPosts =
        posts.where((element) => element['postType'] == 'FEATURED').toList();
    getDisplayPosts(start, stop);
      _controller.addListener(() {
        if (_controller.offset == _controller.position.maxScrollExtent) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              start = stop;
              stop = stop + count;
              getDisplayPosts(start, stop);
            });
          });
        }
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
      height: 285,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(featuredPosts.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 10),
            child: Text(
              'सार्वजनिक हित जानकारी',
              style: GoogleFonts.openSans(
                color: Colors.black.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: displayPosts.length + 1,
                controller: _controller,
                itemBuilder: (ctx, index) {
                  if (index == displayPosts.length &&
                      displayPosts.length != featuredPosts.length) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.13,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      openColor: Theme.of(context).backgroundColor,
                      closedColor: Theme.of(context).backgroundColor,
                      closedBuilder: (_, __) {
                        currentIndex = index;
                        return Row(
                          children: [
                            index == featuredPosts.length
                                ? const SizedBox.shrink()
                                : BodyPart1Item(
                                    image: displayPosts[index]
                                                .containsKey('media') &&
                                            displayPosts[index]['media']
                                                .containsKey('media') &&
                                            displayPosts[index]['media']
                                                    ['media']
                                                .containsKey('image') &&
                                            displayPosts[index]['media']
                                                    ['media']['image']
                                                .containsKey('src')
                                        ? displayPosts[index]['media']['media']
                                            ['image']['src']
                                        : '',
                                    title: displayPosts[index]
                                            .containsKey('message')
                                        ? displayPosts[index]['message']
                                            .split('\n')[0]
                                        : '',
                                        
                                  )
                          ],
                        );
                      },
                      openBuilder: (_, __) {
                        return ViewFBPost(
                          post: displayPosts[index],
                          id: displayPosts[index]['id'],
                          title: displayPosts[index].containsKey('message')
                              ? displayPosts[index]['message'].split('\n')[0]
                              : '',
                          appbarTitle: 'Featured',
                          description:
                          displayPosts[index].containsKey('message')
                              ? displayPosts[index]['message'] : '',
                          date: DateTime.parse(displayPosts[index]['date']),
                          attachement:
                              displayPosts[index].containsKey('subattachments')
                                  ? displayPosts[index]['subattachments']
                                  : [],
                          media: displayPosts[index]['media'],
                          type: displayPosts[index].containsKey('type')
                              ? displayPosts[index]['type']
                              : '');

                      });
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
