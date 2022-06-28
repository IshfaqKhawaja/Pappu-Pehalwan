import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'audio_bubble.dart';
import 'message_bubble.dart';
import 'show_image_bubble.dart';
import 'show_video_bubble.dart';

class Messages extends StatefulWidget {
  final userid;
  Messages({this.userid});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.userid)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot<dynamic>> chatsSnapShot) {
        if (chatsSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = chatsSnapShot.data!.docs;

        return Expanded(
          child: ListView.builder(
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                final isMe = docs[index]['userId'] == id;
                if (!isMe)
                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.userid)
                      .collection('messages')
                      .doc(docs[index].id)
                      .update({'read': 1});

                if (docs[index]['type'] == 'text') {
                  return MessageBubble(
                    message: docs[index]['text'],
                    datetime: docs[index]['date'],
                    isMe: isMe,
                    read: docs[index]['read'],
                  );
                } else if (docs[index]['type'] == 'image') {
                  return ShowImageBubble(
                    url: docs[index]['attachment'],
                    datetime: docs[index]['date'],
                    isMe: isMe,
                    read: docs[index]['read'],
                  );
                } else if (docs[index]['type'] == 'audio') {
                  return AudioBubble(
                    url: docs[index]['attachment'],
                    datetime: docs[index]['date'],
                    isMe: isMe,
                    read: docs[index]['read'],
                    isNetwork: true,
                  );
                } else if (docs[index]['type'] == 'video') {
                  return ShowVideoBubble(
                    url: docs[index]['attachment'],
                    datetime: docs[index]['date'],
                    isMe: isMe,
                    read: docs[index]['read'],
                  );
                } else {
                  return const SizedBox();
                }
              }),
        );
      },
    );
  }
}
