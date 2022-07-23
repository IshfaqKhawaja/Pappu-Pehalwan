import 'package:flutter/material.dart';
import '../providers/load_data_from_facebook.dart';
import '../widgets/body_part_2_item.dart';
import 'package:provider/provider.dart';

class BodyPart2 extends StatefulWidget {
  const BodyPart2({Key? key}) : super(key: key);

  @override
  State<BodyPart2> createState() => _BodyPart2State();
}

class _BodyPart2State extends State<BodyPart2> {
  List stories = [];
  List posts = [];
  List displayPosts = [];
  int start = 0;
  int stop = 5;
  int count = 5;
  final _controller = ScrollController();

  void getDisplayPosts(int start, int stop) {
    setState(() {
      if (stop < stories.length && start < stories.length) {
        displayPosts.addAll(stories.sublist(start, stop));
      } else if (stop >= stories.length && start < stories.length) {
        displayPosts.addAll(stories.sublist(start));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    posts = Provider.of<LoadDataFromFacebook>(context, listen: false).getPosts;
    stories = posts.where((element) => element['postType'] == 'STORY').toList();
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
    // print(stories.length);
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 250,
      // color: Colors.white,
      width: width,
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 20,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (stories.isNotEmpty)
            Text(
              'भारतीय जनता पार्टी',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.7)),
            ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: displayPosts.length + 1,
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (_, index) {
                    if (index == displayPosts.length &&
                        displayPosts.length != stories.length) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return index == stories.length
                        ? const SizedBox.shrink()
                        : BodyPart2Item(
                            images:
                                displayPosts[index]['subattachments'].length !=
                                        0
                                    ? displayPosts[index]['subattachments']
                                    : displayPosts[index]['media'] != 0
                                        ? [displayPosts[index]['media']]
                                        : [],
                            title: displayPosts[index].containsKey('message')
                                ? displayPosts[index]['message'].split('\n')[0]
                                : '',
                            hpccPost: displayPosts[index],
                          );
                  })),
        ],
      ),
    );
  }
}
