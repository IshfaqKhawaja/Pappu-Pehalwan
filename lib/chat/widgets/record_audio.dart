import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final changeIsRecording;
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
    this.changeIsRecording,
  }) : super(key: key);

  @override
  State<RecordAudio> createState() => RecordAudioState();
}

class RecordAudioState extends State<RecordAudio> {
  FlutterSoundRecorder? myRecorder;
  bool recording = false;
  String audioFile = 'temp';
  List<Color> spinKitColors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
  ];

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
          'status' : 0,
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
          });
      if (!widget.isFromUserChats) {
        widget.changeShowInputMessageField(false);
        widget.changeShowReplyAgain(true);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (recording)
          SpinKitWave(
            itemCount: 5,
            size: 35,
            itemBuilder: (ctx, index) {
              return Container(
                height: 10,
                width: 0,
                margin: const EdgeInsets.only(left: 6),
                decoration: BoxDecoration(
                  color: spinKitColors[index % spinKitColors.length],
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        if (recording)
          const SizedBox(
            width: 20,
          ),
        IconButton(
          onPressed: () async {
            if (recording) {
              widget.changeIsRecording(false);
              stopRecording();
              setState(() {
                recording = false;
              });
            } else {
              setState(() {
                recording = true;
              });
              widget.changeIsRecording(true);
              await initRecorder();
              startRecording();
            }
          },
          icon: Icon(
            recording ? Icons.stop : Icons.mic,
            color: recording ? Colors.red : Theme.of(context).primaryColor,
            size: 26,
          ),
        ),
      ],
    );
  }
}
