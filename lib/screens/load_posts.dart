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
    print('Data loaded from Firebase');
    if (res.docs.isNotEmpty) {
      posts = res.docs[0].data()['posts'] ?? [];
    }
  }

  // Loading posts from start to end
  Future<void> loadAllPosts(int start, int end) async {
    try {
      await loadPostsFromFirebase();
      if (tempPosts.isNotEmpty) {
        for (var post in tempPosts) {
          // if (start >= end) {
          //   break;
          // }
          // print('Start is $start');
          start += 1;
          var id = post['id'];
          // print(id);
          final res = await http.get(Uri.parse(
              '$urlPart$id?fields=message,attachments,created_time&access_token=$accessToken'));
          var postData = jsonDecode(res.body);
          var attachments = {};
          var subAttachments = [];
          var media = {};
          if (postData.containsKey('attachments')) {
            attachments = postData['attachments']['data'][0];
            if (attachments.containsKey('media')) {
              media = attachments;
            }
            if (attachments.containsKey('subattachments')) {
              subAttachments = attachments["subattachments"]['data'] ?? [];
            }
          }
          Map<String, dynamic> tempPost = {
            'id': id,
            'message': postData['message'] ?? '',
            'date': postData["created_time"] ?? DateTime.now(),
            'media': media,
            'subattachments': subAttachments,
            'createdTime': postData['created_time'],
            'type': attachments['type'] ?? '',
            'userType': '',
            'postType': '',
          };
          var index = posts.indexWhere(((element) => element['id'] == id));
          if (index != -1) {
            tempPost['userType'] = posts[index]['userType'] ?? '';
            tempPost['postType'] = posts[index]['postType'] ?? '';
            posts[index] = tempPost;
          } else {
            posts.insert(0, tempPost);
          }

          // print(posts.length);
        }
        // this.start += total;
      }
      setState(() {
        loaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadPosts() async {
    // accessToken =
    //     Provider.of<LoadDataFromFacebook>(context, listen: false).getFbKey;
    accessToken =
        'EAAHAavFovc4BAITfd4LTeU8pHezZB12OwtvzxZAZBA5aNeqKibSQAYTOgONNJGmP46n20ek3HVF6ZCO3AZCEzRsAkFYebgFYtbZAwZAYUgbq3aUR4udSqxwzWzb0mdhLgADZAAtNqVjkEzkTZBSVnwyrB02o9jMeO26fTGi7IKPPBSw9Q5ZCqUhvtz';
    int limit = 100;
    url =
        "${urlPart}106458985426806/feed?access_token=$accessToken&limit=$limit";
    var res;
    try {
      res = await http.get(Uri.parse(url));
      tempPosts = jsonDecode(res.body)['data'];
      print('Base URL Loaded From Facebook');
      loadAllPosts(start, total);
    } catch (e) {
      print('The error in load posts from facebook $e ${res.body}');
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    loadPosts();
    // controller.addListener(() {
    //   if (controller.position.maxScrollExtent == controller.offset) {
    //     loadAllPosts(start, start + total);
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                await FirebaseFirestore.instance
                    .collection('posts')
                    .doc('posts')
                    .set({
                  'posts': posts,
                });
                setState(() {
                  updating = false;
                });
                Fluttertoast.showToast(msg: 'Datebase Updated!');
              },
              child: updating ? Container(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  
                  
                ),
              ) : Text(
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
                  );
                },
              ));
  }
}
