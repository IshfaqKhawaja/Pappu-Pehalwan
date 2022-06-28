import 'package:flutter/material.dart';
import 'package:jeevansetu/chat/widgets/auto_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeevansetu/chat/widgets/new_message_user.dart';
import 'package:jeevansetu/providers/user_details.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  final username;
  final userId;
  final phoneNumber;
  final isDirect;
  final isTitleSet;
  final appBarTitle;
  final index;
  final details;
  final questions;
  final docId;
  final isFromUserChats;
  final scaffoldKey;
  final isAdmin;
  final datetime;
  final isFromChatScreen;

  static const routeName = '/chat';
  Chat({
    this.phoneNumber,
    this.userId,
    this.username,
    this.isDirect = false,
    this.isTitleSet = false,
    this.index = 1,
    this.appBarTitle = '',
    this.details,
    this.questions,
    this.docId,
    this.isFromUserChats = false,
    this.scaffoldKey,
    this.isAdmin = false,
    this.datetime,
    this.isFromChatScreen = false,
  });

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isFileSending = false;
  var file;
  bool isImage = false;
  bool isVideo = false;
  bool isAudio = false;
  bool sameScreen = false;
  String docId = '';
  bool showInputMessageField = false;
  GlobalKey<AutoMessagesState> key = GlobalKey<AutoMessagesState>();

  void changeSameScreen(docId) {
    setState(() {
      sameScreen = true;
      this.docId = docId;
    });
  }

  void changeShowInputMessageField(value) async {
    await Future.delayed(Duration.zero);
    if (mounted) {
      setState(() {
        showInputMessageField = value;
      });
    }
  }

  void isFileSendingTrue(bool value, var file, String type) {
    isImage = false;
    isVideo = false;
    isAudio = false;
    if (mounted) {
      setState(() {
        isFileSending = value;
        type == 'image'
            ? isImage = true
            : type == 'audio'
                ? isAudio = true
                : isVideo = true;
        this.file = file;
      });
    }
  }

  void update(userid) async {
    await FirebaseFirestore.instance
        .collection('suggestions')
        .doc(userid)
        .update({'unread': 0});
  }

  @override
  void initState() {
    super.initState();
    if (widget.isFromUserChats) {
      sameScreen = true;
      docId = widget.docId;
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String userid = '';
    String phoneNumber = '';
    final adminDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    // print(widget.details);
    // if (!widget.isDirect) {
    //   final routeArgs =
    //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    //   username = routeArgs['username'] as String;
    //   userid = routeArgs['userId'] as String;
    //   phoneNumber = routeArgs['phoneNumber'] as String;
    // } else {
    username = widget.username;
    userid = widget.userId;
    phoneNumber = widget.phoneNumber;

    bool isAdmin = adminDetails['isAdmin'] as bool;
    String profileUrl = '';
    if (isAdmin) update(userid);
    // print('Is ffrom same screen: $sameScreen');

    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin
            ? username != ''
                ? username
                : phoneNumber
            : widget.isTitleSet
                ? widget.appBarTitle
                : 'Pappu Pehalwan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const ChatScreen(),
          Expanded(
            flex: 13,
            child: AutoMessages(
              key: key,
              userId: userid,
              changeShowInputMessageField: changeShowInputMessageField,
              index: widget.index,
              isFromUsersChat: widget.isFromUserChats,
              details: widget.isFromUserChats ? widget.details : [],
              questions: widget.isFromUserChats ? widget.questions : null,
              scaffoldKey: widget.scaffoldKey,
              appBarTitle: widget.appBarTitle,
              isFileSending: isFileSending,
              isImage: isImage,
              isAudio: isAudio,
              isVideo: isVideo,
              file: file,
              datetime: widget.datetime,
              isFromChatScreen: widget.isFromChatScreen,
            ),
          ),
          // Messages(
          //   userid: userid,
          // ),

          showInputMessageField
              ? NewMessageUser(
                  userid: userid,
                  profileUrl: profileUrl,
                  username: username != '' ? username : phoneNumber,
                  isFileSendingTrue: isFileSendingTrue,
                  details: widget.isFromUserChats
                      ? widget.details
                      : key.currentState!.previousMessageFields,
                  changeMessageSent: key.currentState!.changeMessageSent,
                  sameScreen: sameScreen,
                  changeSameScreen: changeSameScreen,
                  docId: docId,
                  appBarTitle: widget.appBarTitle,
                  scaffoldKey: widget.scaffoldKey,
                  questions: widget.isFromUserChats
                      ? widget.questions
                      : key.currentState!.questions,
                  scrollToEnd: key.currentState!.scrollAnimateToEnd,
                  changeShowInputMessageField: changeShowInputMessageField,
                  isFromUserChats: widget.isFromUserChats,
                  changeShowReplyAgain: key.currentState!.changeShowReplyAgain,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
