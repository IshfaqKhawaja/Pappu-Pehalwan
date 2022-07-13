import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoadDataFromFacebook with ChangeNotifier {
  List posts = [];
  List stories = [];
  List featuredPosts = [];
  List hpccPosts = [];
  List get getPosts => posts;
  List get getStories => stories;
  List get getFeaturedPosts => featuredPosts;
  List get getHpccPosts => hpccPosts;
  Future<void> loadPosts() async {
    posts = [];
    featuredPosts = [];
    stories = [];
    hpccPosts = [];
    int limit = 100;
    var accessToken =
        'EAAHAavFovc4BAITfd4LTeU8pHezZB12OwtvzxZAZBA5aNeqKibSQAYTOgONNJGmP46n20ek3HVF6ZCO3AZCEzRsAkFYebgFYtbZAwZAYUgbq3aUR4udSqxwzWzb0mdhLgADZAAtNqVjkEzkTZBSVnwyrB02o9jMeO26fTGi7IKPPBSw9Q5ZCqUhvtz';
    var urlPart = '';
    var url = '';
    urlPart = 'https://graph.facebook.com/v13.0/';
    url =
        "${urlPart}106458985426806/feed?access_token=$accessToken&limit=$limit";
    try {
      var res = await http.get(Uri.parse(url));
      print(res.body);
      final tempPosts = jsonDecode(res.body)['data'];

      if (tempPosts != null && tempPosts.isNotEmpty) {
        for (var post in tempPosts) {
          var id = post['id'];
          // print(id);
          res = await http.get(Uri.parse(
              '$urlPart$id?fields=message,attachments,created_time&access_token=$accessToken'));
          var postData = jsonDecode(res.body);
          // print(postData);
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
          // print(postData);
          String message = postData['message'] ?? '';
          String title = '';
          String date = '';
          String type = '';
          if (message != '') {
            List messageParts = message.split('\n');

            type =
                messageParts[0].split(':')[1].toString().toUpperCase().trim();
            date = messageParts[1].split(':')[1].toString().trim();
            title = messageParts[2].split(':')[1].toString().trim();
          } else {
            message = '';
          }

          Map<String, dynamic> tempPost = {
            'id': id,
            'message': message,
            'title': title,
            'date': date,
            'postType': type,
            'media': media,
            'subattachments': subAttachments,
            'createdTime': postData['created_time'],
            'type': attachments['type'] ?? '',
          };
          if (type == 'POST') {
            posts.add(tempPost);
          } else if (type == 'STORY') {
            stories.add(tempPost);
          } else if (type == 'FEATURED') {
            featuredPosts.add(tempPost);
          } else if (type == 'HPCC') {
            hpccPosts.add(tempPost);
          }
        }
        posts.sort(
          (a, b) =>
              DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
        );

        stories.sort(
          (a, b) =>
              DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
        );
        hpccPosts.sort(
          (a, b) =>
              DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
        );

        featuredPosts.sort(
          (a, b) =>
              DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
        );
      }
    } catch (e) {
      print('The error in load posts from facebook $e');
    }

    notifyListeners();
  }

  void pushDataToFirebase() {
    FirebaseFirestore.instance.collection('TempData').doc('Posts').set({
      'posts': posts,
      'stories': stories,
      'featuredPosts': featuredPosts,
      'hpccPosts': hpccPosts,
    });
  }

  Future<void> loadDataFromFirebase() async {
    posts = [];
    stories = [];
    featuredPosts = [];
    hpccPosts = [];
    var res = await FirebaseFirestore.instance
        .collection('TempData')
        .doc('Posts')
        .get();
    posts = res.data()!['posts'] ?? [];
    stories = res.data()!['stories'] ?? [];
    featuredPosts = res.data()!['featuredPosts'] ?? [];
    hpccPosts = res.data()!['hpccPosts'] ?? [];
    notifyListeners();
  }
}
