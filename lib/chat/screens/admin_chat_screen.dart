import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/admin__message_chat.dart';




class AdminChatScreen extends StatelessWidget {
  final userId;
  final username;
  const AdminChatScreen({
    Key? key,
    this.userId,
    this.username,
  }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          username,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('suggestions')
            .doc(userId)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot<dynamic>> userSnapShot) {
          if (userSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = userSnapShot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Text('No Chats',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
            );
          }
          // print(docs[0].data());

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              final data = docs[index].data()!;
              return AdminMessageChat(
                datetime: data['createdAt'],
                phoneNumber: '',
                recentText: data['title'],
                unread: 0,
                userid: userId,
                username: username,
                isRedirect: true,
                details: data['details'],
                questions: data['questions'],
                docId: docs[index].id,
                appBarTitle: data['title'],

              );
            },
          );
        },
      ),
    );
    
  }


}
