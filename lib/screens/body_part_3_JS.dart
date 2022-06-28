import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/load_data_from_facebook.dart';
import '../widgets/view_fb_post.dart';
import 'package:provider/provider.dart';
import '../widgets/body_part_3_JS_item.dart';

class BodyPart3JS extends StatefulWidget {
  const BodyPart3JS({ Key? key }) : super(key: key);

  @override
  State<BodyPart3JS> createState() => _BodyPart3JSState();
}

class _BodyPart3JSState extends State<BodyPart3JS> {
  List hpccPosts = [];
  @override
  void initState() {
    super.initState();
    hpccPosts  = Provider.of<LoadDataFromFacebook>(context, listen: false).getHpccPosts;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 230,
      // color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      child: hpccPosts.isEmpty
              ? const SizedBox.shrink()
              :  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('हिमाचल  प्रदेश  कांग्रेस  समिति', style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).primaryColor,
          ),),

         const  SizedBox(height: 20,),
          SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(hpccPosts.length, (index) {
                      String description = '';
                      final containsDescription =
                          (hpccPosts[index]['message'] as String)
                              .contains('Description');
                      if (!containsDescription) {
                        description = '';
                      } else {
                        description = (hpccPosts[index]['message'] as String)
                            .split('Description')[1]
                            .replaceAll(':', '');
                      }
                      return OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                           openColor: Theme.of(context).backgroundColor,
                          closedColor: Theme.of(context).backgroundColor,
                          // transitionDuration: const Duration(milliseconds: 1000),
                          closedBuilder: (_, __) => BodyPart3JSItem(
                                key: ValueKey(hpccPosts[index]['id']),
                                title: hpccPosts[index]['title'],
                                // 'Thakur Jaiveer Singh announced as soon as he took over the chair of tourism minister',
                                subTitle: '',
                                provider: 'हिमाचल  प्रदेश  कांग्रेस  समिति',
                                image: hpccPosts[index].containsKey('media') &&
                                        hpccPosts[index]['media']
                                            .containsKey('media') &&
                                        hpccPosts[index]['media']['media']
                                            .containsKey('image') &&
                                        hpccPosts[index]['media']['media']['image']
                                            .containsKey('src')
                                    ? hpccPosts[index]['media']['media']['image']
                                        ['src']
                                    : '',
                                media: hpccPosts[index]['media'],
                                date: 
                                    DateTime.parse(hpccPosts[index]['date']),
                              ),
                          openBuilder: (_, __) => ViewFBPost(
                                id: hpccPosts[index]['id'],
                                title: hpccPosts[index]['title'],
                                appbarTitle: 'हिमाचल  प्रदेश  कांग्रेस  समिति',
                                description: description,
                                date: 
                                    DateTime.parse(hpccPosts[index]['date']),
                                attachement:
                                    hpccPosts[index].containsKey('subattachments')
                                        ? hpccPosts[index]['subattachments']
                                        : [],
                                media: hpccPosts[index]['media'],
                              ));
                    }),
                  ),
              ),
        ],
      ),
    );
      }
}