import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pappupehalwan/auth/splash_screen.dart';
import 'package:pappupehalwan/providers/user_details.dart';
import 'package:provider/provider.dart';
import 'play_video.dart';
import 'show_annoncement_files.dart';
import 'package:share_plus/share_plus.dart';

class ViewFBPost extends StatefulWidget {
  final id;
  final title;
  final date;
  final attachement;
  final media;
  final description;
  final appbarTitle;
  final type;
  final post;

  const ViewFBPost({
    Key? key,
    this.id,
    this.title,
    this.appbarTitle,
    this.date,
    this.media,
    this.attachement,
    this.description,
    this.type = '',
    this.post,
  }) : super(key: key);

  @override
  State<ViewFBPost> createState() => _ViewFBPostState();
}

class _ViewFBPostState extends State<ViewFBPost> {
  var userDetails = {};
  var postType = '';
  List userType = [];
  List userCategories = [];

  void changeUserType(value) {
    setState(() {
      userType = value;
    });
  }

  void changePostType(value) {
    setState(() {
      postType = value;
    });
  }

  Future<List> getPostsfromFirebase() async {
    var res =
        await FirebaseFirestore.instance.collection('posts').doc('posts').get();
    return res.data()!['posts'];
  }

  Future<void> deletePost(post) async {
    var data = await getPostsfromFirebase();
    data.removeWhere(
        (element) => element['id'].toString() == post['id'].toString());
    await FirebaseFirestore.instance
        .collection('posts')
        .doc('posts')
        .update({'posts': data});
  }

  Future<void> updateData(postUserCategories, post) async {
    var data = await getPostsfromFirebase();
    int postIndex = data.indexWhere(
        (element) => element['id'].toString() == post['id'].toString());
    data[postIndex]['postType'] = postType;
    data[postIndex]['userType'] = postUserCategories;
    await FirebaseFirestore.instance
        .collection('posts')
        .doc('posts')
        .update({'posts': data});
  }

  Future<List> loadUserCategories() async {
    var res =
        await FirebaseFirestore.instance.collection('userCategories').get();
    List data = res.docs.map((doc) => doc.data()['category']).toList();
    return data;
  }

  @override
  void initState() {
    super.initState();
    userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    postType = widget.post['postType'] ?? "FEATURED";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appbarTitle ?? '',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 20,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final box = context.findRenderObject() as RenderBox?;
              final attachment = widget.type == 'video_inline'
                  ? widget.media.containsKey('media')
                      ? widget.media['media'].containsKey('source')
                          ? widget.media['media']['source']
                          : ''
                      : ''
                  : widget.media.containsKey('media')
                      ? widget.media['media'].containsKey('image')
                          ? widget.media['media']['image'].containsKey('src')
                              ? widget.media['media']['image']['src']
                              : ''
                          : ''
                      : '';

              await Share.share(
                '${widget.description}\n\n$attachment',
                subject: '${widget.title}',
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          // if (userDetails['isAdmin'])
          //   IconButton(
          //       onPressed: () async {
          //         userCategories = await loadUserCategories();
          //         showDialog(
          //             context: context,
          //             builder: (ctx) {
          //               return Dialog(
          //                 child: WillPopScope(
          //                   onWillPop: () async {
          //                     Navigator.of(context).pop({});
          //                     return true;
          //                   },
          //                     child: SingleChildScrollView(
          //                       child: Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           mainAxisSize: MainAxisSize.min,
          //                           children: [
          //                             Row(
          //                               children: [
          //                                 Text(
          //                                   'Post Type : ',
          //                                   style: GoogleFonts.openSans(
          //                                     color: Colors.black,
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 10,
          //                                 ),
          //                                 Expanded(
          //                                     child: DropDownWidget(
          //                                       changePostType: changePostType,
          //                                       postType: postType,
          //                                     )
          //                                 )
          //                               ],
          //                             ),
          //                             const SizedBox(
          //                               height: 10,
          //                             ),
          //                             Text(
          //                               'User Type : ',
          //                               style: GoogleFonts.openSans(
          //                                 color: Colors.black,
          //                                 fontWeight: FontWeight.bold,
          //                               ),
          //                             ),
          //                             const SizedBox(
          //                               width: 10,
          //                             ),
          //                             UserType(
          //                               userCategories: userCategories,
          //                               postUserCategories: widget.post['userType'],
          //                               deletePost : deletePost,
          //                               updateData: updateData,
          //                               post:widget.post,
          //                             ),
          //                             const SizedBox(
          //                               height: 10,
          //                             ),
          //                             const SizedBox(
          //                               height: 20,
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                 ),
          //               );
          //             }).then((value) {
          //           if (value.containsKey('updated') && value['updated']) {
          //             Navigator.of(context).pushAndRemoveUntil(
          //                 MaterialPageRoute(
          //                     builder: (ctx) => const SplashScreen(
          //                           isUpdationRequired: true,
          //                           isFromLogout: false,
          //                         )),
          //                 (route) => false);
          //           }
          //         });
          //         //});
          //         // showDialog(
          //         // context: context,
          //         // builder: (ctx) {
          //         // return DialogWidget(
          //         // post: widget.post,
          //         //);
          //         // })
          //       },
          //       icon: const Icon(
          //         Icons.edit,
          //         color: Colors.white,
          //       )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4).copyWith(
          top: 2,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.attachement.length > 0)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: ShowAnnoncementFiles(
                    files: widget.attachement,
                    isHomeScreen: true,
                    type: widget.type,
                  ),
                ),
              if (widget.attachement.length == 0 &&
                  widget.media != null &&
                  // widget.media['type'] == "video_inline"
                  widget.type == 'video_inline')
                PlayVideo(
                  type: 'network',
                  video: widget.media['media']['source'],
                ),
              if (widget.attachement.length == 0 &&
                  widget.media != null &&
                  // widget.media['type'] == "photo"
                  widget.type == 'photo')
                CachedNetworkImage(
                  imageUrl: widget.media['media']['image']['src'],
                  fit: BoxFit.cover,
                ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: SelectableText(
                      widget.title.toString().trimLeft(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('MMM dd yyyy').format(widget.date),
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: SelectableText(
                      widget.description.toString().trimLeft(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4,
                  ),
                ],
              ),
            ],
          ),
        ),
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
    this.changePostType
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  var postType = '';
  @override
  void iniState(){
    if(widget.postType == '') {
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
              child: Text('STORY'),
            value: 'STORY',
          ),
          DropdownMenuItem(
              child: Text('POST'),
             value: 'POST',
          )
        ],
        onChanged: (value) {
          setState((){
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
  final postUserCategories;
  final updateData;
  final post;
  final deletePost;
  const UserType({Key? key,
    this.userCategories,
    this.postUserCategories,
    this.updateData,
    this.post,
    this.deletePost
  }) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  List postUserCategories = [];
  List userCategories = [];
  bool isDeleting = false;
  bool isLoading = false;

  @override
  void initState() {
    if(widget.postUserCategories == null) {
      postUserCategories = [];
    } else {
      postUserCategories = widget.postUserCategories;
    }
    if(widget.userCategories == null){
      userCategories = [];
    }else {
      userCategories = widget.userCategories;
    }
    super.initState();
  }

  @override
  void dispose(){
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
              ...postUserCategories
              .map(
                  (e) => InkWell(
                    onTap: (){
                      postUserCategories.remove(e);
                      setState((){});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        e,
                        style: GoogleFonts.openSans(
                          color: Colors.white
                        ),
                      ),
                    ),
                  )
              )
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
            width: double.infinity,
            height: 45,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState((){
                  userCategories = (widget.userCategories as List)
                      .where((element) =>
                      element.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          Wrap(
            children: [
              ...userCategories
              .map((e) => InkWell(
                onTap: (){
                  if(!postUserCategories.contains(e)){
                    postUserCategories.add(e);
                  }
                  setState((){});
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    e,
                    style: GoogleFonts.openSans(
                      color: Colors.white
                    ),
                  ),
                ),
              )).toList(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop({'updated' : false});
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isDeleting = true;
                    });
                    try {
                      await widget.deletePost(widget.post);
                      Navigator.of(context).pop({'updated' : true});

                      setState((){
                        isDeleting = false;
                      });
                    } catch (e){
                      print(e);
                      setState((){
                        isDeleting = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
                    }
                  },
                  child: isDeleting
                      ? Container(
                    height: 25,
                    width: 25,
                    child: const CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                      :
                      Text(
                          'Delete',
                        style: GoogleFonts.openSans(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
              ),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try{
                      await widget.updateData(postUserCategories, widget.post);
                      Navigator.of(context).pop({'updated' : true});
                      setState((){
                        isLoading  = false;
                      });
                    } catch (e) {
                      print(e);
                      setState((){
                        isLoading = false ;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                      ));
                    }
                  },
                  child: isLoading
                  ? Container(
                    height: 25,
                    width: 25,
                    child: const CircularProgressIndicator(),
                  )
                      : Text(
                    'Update',
                    style: GoogleFonts.openSans(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}

