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
  List hpccPosts = [];
  @override
  void initState() {
    super.initState();
    hpccPosts =
        Provider.of<LoadDataFromFacebook>(context, listen: false).getHpccPosts;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      // height: 230,
      // color: Colors.white,
      width: width,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20,),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(
          //   'हिमाचल  प्रदेश  कांग्रेस  समिति',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w800,
          //     color: Colors.black.withOpacity(0.7),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  hpccPosts.length,
                  (index) {
                    return BodyPart2Item(
                      images: hpccPosts[index]['subattachments'].length != 0
                          ? hpccPosts[index]['subattachments']
                          : hpccPosts[index]['media'] != 0
                              ? [hpccPosts[index]['media']]
                              : [],
                      title: hpccPosts[index]['title'],
                      hpccPost: hpccPosts[index],
                    );
                  },
                ),
              ),),
             
        ],
      ),
    );
  }
}
