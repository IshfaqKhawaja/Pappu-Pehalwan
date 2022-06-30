import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/user_details.dart';
import '../widgets/users_chat.dart';

class ChatScreen extends StatelessWidget {
  final scaffoldKey;
  final userId;
  final isAdmin;
  final username;
  static const routeName = '/chat-screen';
  const ChatScreen({
    Key? key,
    this.scaffoldKey,
    this.isAdmin = false,
    this.userId,
    this.username,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final userId = isAdmin ? this.userId :  FirebaseAuth.instance.currentUser!.uid;
    final userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(
         isAdmin ? username :  'Suggestions / Complaints',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
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
              // print(docs[index]);
              return UsersChat(
                username: userDetails['name'],
                docId: docs[index].id,
                phoneNumber: userDetails['phoneNumber'],
                profileUrl: '',
                recentText: docs[index]['title'],
                unread: 0,
                userid: userId,
                details: docs[index]['details'],
                datetime: docs[index]['createdAt'],
                appBarTitle: docs[index]['title'],
                questions : docs[index]['questions'],
                scaffoldKey: scaffoldKey,
              );
            },
          );
        },
      ),
    );
  }
}
