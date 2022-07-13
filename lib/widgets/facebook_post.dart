import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jeevansetu/widgets/play_video.dart';
import 'package:jeevansetu/widgets/show_annoncement_files.dart';

import 'body_part_3_item.dart';

class FaceBookPost extends StatefulWidget {
  final post;
  final index;
  final changeData;
  const FaceBookPost({
    Key? key,
    this.post,
    this.changeData,
    this.index,
  }) : super(key: key);

  @override
  State<FaceBookPost> createState() => _FaceBookPostState();
}

class _FaceBookPostState extends State<FaceBookPost> {
  var postType = '';
  var userType = '';

  void changePostType(value) {
    postType = value;
  }

  @override
  void initState() {
    postType = widget.post['postType'] ?? "FEATURED";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4).copyWith(
        top: 2,
      ),
      child: Stack(
        children: [
          BodyPart3Item(
            key: ValueKey(widget.post['id']),
            title: widget.post['message'].toString().split('\n')[0],
            subTitle: '',
            provider: 'Facebook',
            image: widget.post.containsKey('media') &&
                    widget.post['media'].containsKey('media') &&
                    widget.post['media']['media'].containsKey('image') &&
                    widget.post['media']['media']['image'].containsKey('src')
                ? widget.post['media']['media']['image']['src']
                : '',
            media: widget.post['media'],
            date: DateTime.parse(widget.post['date']),
            comments: 100,
            likes: 200,
            shares: 29,
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return Dialog(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'User Type : ',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: widget.post['userType'],
                                        onChanged: (value) {
                                          userType = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Post Type : ',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: DropDownWidget(
                                        changePostType: changePostType,
                                        postType: postType,
                                      ),
                                      // child: TextFormField(
                                      //   initialValue: post['postType'],
                                      //   onChanged: (value) {
                                      //     postType = value;
                                      //   },
                                      // ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      widget.changeData(
                                          widget.index, 'userType', userType);
                                      widget.changeData(widget.index,
                                          'postType', postType.toUpperCase());
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Update'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  final postType;
  final changePostType;
  const DropDownWidget({
    Key? key,
    this.postType,
    this.changePostType,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  var postType = '';
  @override
  void initState() {
    if (widget.postType == '') {
      postType = 'FEATURED';
    }
    else{
      postType = widget.postType ?? "FEATURED";

    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: const [
        DropdownMenuItem(
          child: Text('FEATURED'),
          value: 'FEATURED',
        ),
        DropdownMenuItem(
          child: Text('STORY'),
          value: 'STORY',
        ),
        DropdownMenuItem(
          child: Text('POST'),
          value: 'POST',
        ),
      ],
      onChanged: (value) {
        setState(() {
          postType = value.toString();
          widget.changePostType(postType);
        });
      },
      value: postType,
    );
  }
}
