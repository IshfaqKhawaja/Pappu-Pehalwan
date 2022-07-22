import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'body_part_3_item.dart';

class FaceBookPost extends StatefulWidget {
  final post;
  final index;
  final changeData;
  final userCategories;
  final loadUserCategories;

  const FaceBookPost({
    Key? key,
    this.post,
    this.changeData,
    this.index,
    this.userCategories,
    this.loadUserCategories,
  }) : super(key: key);

  @override
  State<FaceBookPost> createState() => _FaceBookPostState();
}

class _FaceBookPostState extends State<FaceBookPost> {
  var postType = '';
  List userType = [];
  List userCategories = [];

  void changeUserType(value) {
    setState(() {
      userType = value;
    });
  }

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
              onPressed: () async {
                userCategories = await widget.loadUserCategories();
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return Dialog(
                          child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Post Type : ',
                                    style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: DropDownWidget(
                                    changePostType: changePostType,
                                    postType: postType,
                                  )),
                                ],
                              ),
                              Text(
                                'User Type : ',
                                style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              UserType(
                                userCategories: userCategories,
                                changeData: widget.changeData,
                                postUserCategories: widget.post['userType'],
                                changeUserType: changeUserType,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: (){
                                    widget.changeData(
                                      widget.index, 'userType', userType);
                                    widget.changeData(widget.index,
                                      'postType', postType.toUpperCase()
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Update'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
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
    } else {
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
          child: Text('HPCC'),
          value: 'HPCC',
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

class UserType extends StatefulWidget {
  final userCategories;
  final changeData;
  final postUserCategories;
  final changeUserType;

  const UserType(
      {Key? key,
      this.userCategories,
      this.changeData,
      this.postUserCategories,
      this.changeUserType
      }) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  List postUserCategories = [];
  List userCategories = [];
  @override
  void initState(){
    if(widget.postUserCategories == null){
      postUserCategories = [];
    }else{
      postUserCategories = widget.postUserCategories;
    }
    if(widget.userCategories == null){
      userCategories = [];
    }else{
      userCategories = widget.userCategories;
    }
    super.initState();
  }
  
  @override
  void dispose(){
    //TODO: implement dispose
    super.dispose();
    userCategories = [];
    postUserCategories = [];
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              ...postUserCategories.map((e) => InkWell(
                onTap: (){
                  postUserCategories.remove(e);
                  widget.changeUserType(postUserCategories);
                  setState((){});
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(e,style: GoogleFonts.openSans(
                    color: Colors.white
                  ),),
                ),
              )).toList(),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 3,
            color: Colors.black,
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: 200,
            height: 45,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder()
              ),
              onChanged: (value){
                setState((){
                  userCategories = (widget.userCategories as List).where((element) => element.toLowerCase().contains(value.toLowerCase())).toList();
                });
              },
            ),
          ),
          Wrap(
            children: [
              ...userCategories.map((e) => InkWell(
                onTap: (){
                  if(!postUserCategories.contains(e)){
                    postUserCategories.add(e);
                    widget.changeUserType(postUserCategories);
                  }
                  setState((){});
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(e,style: GoogleFonts.openSans(
                    color: Colors.white
                  ),),
                ),
              )).toList(),
            ],
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
