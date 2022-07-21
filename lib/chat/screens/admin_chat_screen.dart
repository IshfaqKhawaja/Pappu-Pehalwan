import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../widgets/admin__message_chat.dart';


class AdminChatScreen extends StatefulWidget {
  final userId;
  final username;
  const AdminChatScreen({
    Key? key,
    this.userId,
    this.username,
  }) : super(key: key);

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final toggleButtonItems = ['सुझाव', 'शिकायत'];
  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.username,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: true,
        actions: [
          ToggleSwitch(
            customHeights: const [40, 40],
            minHeight: 40,
            initialLabelIndex: index,
            cornerRadius: 10.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Theme.of(context).appBarTheme.color,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: toggleButtonItems,
            customTextStyles: const[
              TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )
            ],
            onToggle: (index){
              this.index = index!;
              setState((){

              });
            },
            activeBgColors: const [
              [Colors.orange],
              [Colors.orange]
            ],
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('suggestions')
            .doc(widget.userId)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot<dynamic>> userSnapShot) {
          if (userSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var docs = userSnapShot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Text('No Chats',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
            );
          }
          if(index != -1){
            docs = docs.where((doc) => doc.data()['title'] == toggleButtonItems[index]).toList();
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
                userid: widget.userId,
                username: widget.username,
                isRedirect: true,
                details: data['details'],
                questions: data['questions'],
                docId: docs[index].id,
                appBarTitle: data['title'],
                status: data['status'],
              );
            },
          );
        },
      ),
    );

  }
}
