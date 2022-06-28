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
  @override
  void initState() {
    super.initState();
    stories =
        Provider.of<LoadDataFromFacebook>(context, listen: false).getStories;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return stories.isEmpty ? const SizedBox.shrink() :
     Container(
      // height: 230,
      // color: Colors.white,
      width: width,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20),
      child: stories.isEmpty ? const  SizedBox.shrink(): Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'समाचार',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  stories.length,
                  (index) {
                    return BodyPart2Item(
                      images: stories[index]['subattachments'].length != 0
                          ? stories[index]['subattachments']
                          : stories[index]['media'] != 0
                              ? [stories[index]['media']]
                              : [],
                      title: stories[index]['title'],
                      hpccPost: stories[index],
                    );
                  },
                ),
              ),),
             
        ],
      ),
    );
  }
}
