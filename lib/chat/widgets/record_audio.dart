import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordAudio extends StatefulWidget {
  final userId;
  final username;
  final isFileSending;
  final details;
  final questions;
  final changeMessageSent;
  final changeSameScreen;
  final sameScreen;
  final docId;
  final appBarTitle;
  final scaffoldKey;
  final scrollToEnd;
  final changeShowInputMessageField;
  final isFromUserChats;
  final changeShowReplyAgain;
  const RecordAudio({
    Key? key,
    this.userId,
    this.username,
    this.isFileSending,
    this.changeMessageSent,
    this.changeSameScreen,
    this.sameScreen,
    this.details,
    this.questions,
    this.docId,
    this.appBarTitle,
    this.scaffoldKey,
    this.scrollToEnd,
    this.changeShowInputMessageField,
    this.isFromUserChats,
    this.changeShowReplyAgain,
  }) : super(key: key);

  @override
  State<RecordAudio> createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  FlutterSoundRecorder? myRecorder;
  bool recording = false;
  String audioFile = 'temp';

  Future<void> initRecorder() async {
    myRecorder = await FlutterSoundRecorder().openRecorder();
    if (myRecorder != null) {
      print("Recorder initialized");
    }
  }

  void sendAudio(audioFile, BuildContext ctx) async {
    try {
      widget.isFileSending(true, audioFile, 'audio');

      final ref = FirebaseStorage.instance
          .ref()
          .child('audios')
          .child('${widget.userId}${Timestamp.now()}.wav');
      File temp =
          File('/data/user/0/com.abscodinformatics.pappupehalwan/cache/$audioFile');
      print('temp is $temp');
      await ref.putFile(temp);
      widget.isFileSending(false, '', '');
      final url = await ref.getDownloadURL();
      print(url);
      List details = widget.details;
      details.add({
        'title': '',
        'createdAt': Timestamp.now(),
        'date': DateTime.now().toIso8601String(),
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'read': 0,
        'isMe': widget.userId == FirebaseAuth.instance.currentUser!.uid ? 1 : 0,
        'type': 'audio',
        'attachment': url,
      });
      var res;
      if (!widget.sameScreen) {
        res = await FirebaseFirestore.instance
            .collection('suggestions') //'chats
            .doc('${widget.userId}')
            .collection('messages') //messages
            .add({
          'details': details,
          'questions': widget.questions,
          'createdAt': Timestamp.now(),
          'title': widget.appBarTitle,
        });
        widget.changeMessageSent(res.id);
        widget.changeSameScreen(res.id);
      } else {
        await FirebaseFirestore.instance
            .collection('suggestions') //'chats
            .doc('${widget.userId}')
            .collection('messages')
            .doc(widget.docId) //messages
            .update({
          'details': details,
          'questions': widget.questions,
          'createdAt': Timestamp.now(),
          'title': widget.appBarTitle,
        });
        widget.changeMessageSent(widget.docId);
      }
      // widget.scrollToEnd();
      await FirebaseFirestore.instance
          .collection('suggestions')
          .doc('${widget.userId}')
          .set({
        'createdAt': Timestamp.now(),
        'unread': 1,
        'recentText': 'audio',
        'username': widget.username,
        // 'profile_url': widget.profileUrl,
      });
      // ScaffoldMessenger.of(widget.scaffoldKey.currentContext!)
      //     .showSnackBar(SnackBar(
      //   content: Text(widget.appBarTitle == 'सुझाव'
      //       ? ' धन्यवाद, आपका सुझाव हमारे पास पहुंच गया है l हम जल्द ही आपसे संपर्क करेंगे |'
      //       : 'धन्यवाद, आपकी समस्या हमारे पास पहुंच गई है l हम जल्द ही आपसे संपर्क करेंगे |'),
      // ));
      if (!widget.isFromUserChats) {
       widget.changeShowInputMessageField(false);
       widget.changeShowReplyAgain(true);
        // await showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (ctx) {
        //       return AlertDialog(
        //         content: const Text('Do you want to reply again?'),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               widget.changeShowInputMessageField(true);
        //               closeChat = false;
        //               Navigator.of(ctx).pop();
        //             },
        //             child: const Text('Yes'),
        //           ),
        //           TextButton(
        //             onPressed: () {
        //               widget.changeShowInputMessageField(false);
        //               closeChat = true;
        //               Navigator.of(ctx).pop();
        //             },
        //             child: const Text('No'),
        //           ),
        //         ],
        //       );
        //     }).then((value) {
        //   if (closeChat) {
        //     Navigator.of(context).pop();
        //   }
        //   print(closeChat);
        // });
      }
    } on PlatformException catch (err) {
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text('$err'),
      ));
    } catch (err) {
      print(err);
    }
  }

  void startRecording() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
      throw RecordingPermissionException("Microphone permission not granted");

    await myRecorder!.startRecorder(
      toFile: audioFile,
      codec: Codec.defaultCodec,
    ); // A temporary file named 'foo'
  }

  void stopRecording() async {
    if (myRecorder!.isRecording) {
      myRecorder!.stopRecorder();
      sendAudio(audioFile, context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (myRecorder != null) {
      myRecorder!.closeRecorder();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (recording) {
          stopRecording();
          setState(() {
            recording = false;
          });
        } else {
          setState(() {
            recording = true;
          });
          await initRecorder();
          startRecording();
        }
      },
      icon: Icon(
        recording ? Icons.stop : Icons.mic,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
