import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/admin__message_chat.dart';

class AdminMessages extends StatefulWidget {
  const AdminMessages({Key? key}) : super(key: key);

  @override
  State<AdminMessages> createState() => _AdminMessagesState();
}

class _AdminMessagesState extends State<AdminMessages> {
  String userId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: GoogleFonts.openSans(
            textStyle: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('suggestions')
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

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              final data = docs[index].data()!;
              return AdminMessageChat(
                datetime: data['createdAt'],
                phoneNumber: data['username'],
                recentText: '',
                unread: data['unread'],
                userid: docs[index].id,
                username: data['username'],
              );
            },
          );
        },
      ),
    );
  }
}
