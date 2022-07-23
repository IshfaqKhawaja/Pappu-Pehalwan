import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../providers/load_data_from_facebook.dart';
import '../widgets/facebook_post.dart';
import 'package:provider/provider.dart';

class LoadPosts extends StatefulWidget {
  const LoadPosts({Key? key}) : super(key: key);

  @override
  State<LoadPosts> createState() => _LoadPostsState();
}

class _LoadPostsState extends State<LoadPosts> {
  List posts = [];
  List firebasePosts = [];
  List tempPosts = [];
  String accessToken = '';
  var urlPart = 'https://graph.facebook.com/v13.0/';
  var url = '';
  int start = 0;
  int total = 5;
  final controller = ScrollController();
  bool loaded = false;
  bool updating = false;
  List userCategories = [];
  
  Future<List> loadUserCategories() async {
    var res = await FirebaseFirestore.instance.collection('userCategories').get();
    List data = res.docs.map((doc) => doc.data()['category']).toList();
    return data;
  }

  void changeData(index, key, value) {
    setState(() {
      posts[index][key] = value;
    });
    Fluttertoast.showToast(
      msg: 'Please Press Update to Push Changes to Database',
    );
  }

  Future<void> loadPostsFromFirebase() async {
    var res = await FirebaseFirestore.instance.collection('posts').get();
    if (res.docs.isNotEmpty) {
      posts = res.docs[0].data()['posts'] ?? [];
    }
  }

  // Loading posts from start to end
  Future<void> loadAllPosts(int start, int end) async {
    try {
      await loadPostsFromFirebase();
      // List postCategories = ['FEATURED', 'POST', 'STORY'];
      Random random = Random();
      if (tempPosts.isNotEmpty) {
        for (var post in tempPosts) {
          var id = post['id'];
          var attachments = {};
          var subAttachments = [];
          var media = {};
          if (post.containsKey('attachments')) {
            attachments = post['attachments']['data'][0];
            if (attachments.containsKey('media')) {
              media = attachments;
            }
            if (attachments.containsKey('subattachments')) {
              subAttachments = attachments["subattachments"]['data'] ?? [];
            }
          }
          Map<String, dynamic> tempPost = {
            'id': id,
            'message': post['message'] ?? '',
            'date': post["created_time"] ?? DateTime.now(),
            'media': media,
            'subattachments': subAttachments,
            'createdTime': post['created_time'],
            'type': attachments['type'] ?? '',
            'userType': [],
            'postType': 'POST' //postCategories[random.nextInt(3)],
          };
          var index = posts.indexWhere(((element) => element['id'] == id));
          if (index != -1) {
            tempPost['userType'] = posts[index]['userType'] ?? [];
            tempPost['postType'] = posts[index]['postType'] ?? '';
            posts[index] = tempPost;
          } else {
            posts.insert(0, tempPost);
          }
        }
        posts.sort(((a, b) =>
            DateTime.parse(b['date']).compareTo(DateTime.parse(a['date']))));
      }
      setState(() {
        loaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadPosts() async {
    String pageNumber = '106458985426806';
    accessToken =
        Provider.of<LoadDataFromFacebook>(context, listen: false).getFbKey;
    int limit = 100;
    url =
        "${urlPart}$pageNumber/feed?fields=attachments{media,type,subattachments},message,created_time&access_token=$accessToken&limit=$limit";
    var res;
    try {
      res = await http.get(Uri.parse(url));
      if (jsonDecode(res.body).containsKey('data')) {
        tempPosts = jsonDecode(res.body)['data'];
        print('Base URL Loaded From Facebook');
        loadAllPosts(start, total);
      } else {
        Fluttertoast.showToast(
            msg: '${res.body}', toastLength: Toast.LENGTH_LONG);
        setState((){
          loaded = true;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error Loading Posts From Facebook because $e or ${res.body}',
        toastLength: Toast.LENGTH_LONG,
      );
      print('The error in load posts from facebook $e ${res.body}');
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    loadPosts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(posts.length);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Load Posts',
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {
                  updating = true;
                });
                try {
                  await FirebaseFirestore.instance
                      .collection('posts')
                      .doc('posts')
                      .set({
                    'posts': posts,
                  });
                  setState(() {
                    updating = false;
                  });
                } catch (e) {
                  setState(() {
                    updating = false;
                  });
                }
                Fluttertoast.showToast(msg: 'Database Updated!');
              },
              child: updating
                  ? Container(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Update',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
        body: !loaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: controller,
                itemCount: posts.length,
                itemBuilder: (ctx, index) {
                  return FaceBookPost(
                    post: posts[index],
                    index: index,
                    changeData: changeData,
                    userCategories: userCategories,
                    loadUserCategories: loadUserCategories,
                  );
                },
              ));
  }
}
