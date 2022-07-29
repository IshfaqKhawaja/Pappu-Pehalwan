import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../providers/user_details.dart';
import '../widgets/users_chat.dart';

class ChatScreen extends StatefulWidget {
  final scaffoldKey;
  final userId;
  final isAdmin;
  final username;
  final isSuggestion;
  final isComplaint;
  final suggestionComplaintTitle;
  static const routeName = '/chat-screen';
  const ChatScreen({
    Key? key,
    this.scaffoldKey,
    this.isAdmin = false,
    this.userId,
    this.username,
    this.isSuggestion = false,
    this.isComplaint = false,
    this.suggestionComplaintTitle = '',
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int index = -1;
  var userId = '';
  final toggleButtonItems = ['सुझाव', 'शिकायत'];
  var docs = [];
  var temp;
  bool loadingChat = false;

  @override
  void initState(){
    super.initState();
    userId = widget.isAdmin ? widget.userId : FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    // final userId = widget.isAdmin ? this.widget.userId :  FirebaseAuth.instance.currentUser!.uid;
    final userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text(
         widget.isAdmin
             ? widget.username
             :widget.isSuggestion ? 'सुझाव' : widget.isComplaint ? 'शिकायत' : 'सुझाव/शिकायत',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if(!widget.isSuggestion && !widget.isComplaint)
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
              customTextStyles: const [
                TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                )
              ],
              onToggle: (index){
                this.index = index!;
                setState((){

                });
              },
              activeBgColors: const[
                [Colors.orange],
                [Colors.orange]
              ],
            )
        ],
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
          var docs = userSnapShot.data!.docs;

          if(index != -1){
            docs = docs.where((doc) => doc.data()['title'] == toggleButtonItems[index]).toList();
          }
          // print(docs[0].data());
          if(widget.isSuggestion){
            docs = docs.where((doc) => doc.data()['title'] == widget.suggestionComplaintTitle).toList();
          }
          else if (widget.isComplaint){
            docs = docs.where((doc) => doc.data()['title'] == widget.suggestionComplaintTitle).toList();
          }
          if(docs.isEmpty){
            return Center(
              child: Text('No Chats',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
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
                scaffoldKey: widget.scaffoldKey,
                status : docs[index]['status'] ?? 0,
              );
            },
          );
        },
      ),
    );
  }
}
