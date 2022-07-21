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
  List posts = [];
  List firebasePosts = [];
  List displayPosts = [];
  int start = 0;
  int stop = 5;
  int count = 5;
  bool loadingPosts = false;
  final _controller = ScrollController();

  void getDisplayPosts(int start, int stop) async {
    setState(() {
      loadingPosts = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      if (stop < posts.length && start < posts.length) {
        displayPosts.addAll(posts.sublist(start, stop));
      } else if (stop > posts.length && start < posts.length) {
        displayPosts.addAll(posts.sublist(start));
      }
      loadingPosts = false;
    });
  }

  @override
  void initState() {
    super.initState();
    firebasePosts =
        Provider.of<LoadDataFromFacebook>(context, listen: false).getPosts;
    posts = firebasePosts
        .where((element) => element['postType'] == 'POST')
        .toList();
    getDisplayPosts(start, stop);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'पप्पू पहलवान',
            style: GoogleFonts.openSans(
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(displayPosts.length + 1, (index) {
                  if (index == displayPosts.length &&
                      displayPosts.length != posts.length) {
                    return Container(
                      height: 45,
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: loadingPosts
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  start = stop;
                                  stop = stop + count;
                                  getDisplayPosts(start, stop);
                                },
                                child: const Text('Load More')),
                      ),
                    );
                  }
                  return index == posts.length
                      ? const SizedBox.shrink()
                      : OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                          openColor: Theme.of(context).backgroundColor,
                          closedColor: Theme.of(context).backgroundColor,
                          transitionDuration:
                              const Duration(milliseconds: 1000),
                          closedBuilder: (_, __) => BodyPart3Item(
                                key: ValueKey(posts[index]['id']),
                                title: posts[index]['message'].split('\n')[0] ??
                                    '',
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
                                date: DateTime.parse(posts[index]['date']),
                                comments: 100,
                                likes: 200,
                                shares: 29,
                              ),
                          openBuilder: (_, __) => ViewFBPost(
                                id: posts[index]['id'],
                                title: posts[index]['message'].split('\n')[0] ??
                                    '',
                                appbarTitle: 'From Facebook',
                                description: posts[index]['message'],
                                date: DateTime.parse(posts[index]['date']),
                                attachement:
                                    posts[index].containsKey('subattachments')
                                        ? posts[index]['subattachments']
                                        : [],
                                media: posts[index]['media'],
                                type: posts[index]['type'],
                              ));
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
