import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import '../chat/widgets/audio_bubble.dart';
import '../providers/user_details.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AudioSOS extends StatefulWidget {
  final scaffoldKey;
  final userId;
  final isAdmin;
  final username;
  const AudioSOS({
    Key? key,
    this.scaffoldKey,
    this.isAdmin = false,
    this.userId,
    this.username,
  }) : super(key: key);

  @override
  State<AudioSOS> createState() => _AudioSOSState();
}

class _AudioSOSState extends State<AudioSOS> {
  String userId = '';
  Map<String, dynamic> userDetails = {};
  bool isAudio = false;
  bool isFileSending = false;
  var file;
  void isFileSendingTrue(bool value, var file, String type) {
    isAudio = false;
    setState(() {
      isFileSending = value;
      isAudio = value;
      this.file = file;
    });
  }

// Recorder Details
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
      isFileSendingTrue(true, audioFile, 'audio');

      final ref = FirebaseStorage.instance
          .ref()
          .child('audios')
          .child('$userId${Timestamp.now()}.wav');
      File temp =
          File('/data/user/0/com.abscodinformatics.pappupehalwan/cache/$audioFile');
      print('temp is $temp');
      await ref.putFile(temp);
      isFileSendingTrue(false, '', '');
      final url = await ref.getDownloadURL();
      print(url);

      var res = await FirebaseFirestore.instance
          .collection('audio-sos') //'chats
          .doc(userId)
          .collection('messages') //messages
          .add({
        'title': '',
        'createdAt': Timestamp.now(),
        'date': DateTime.now().toIso8601String(),
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'read': 0,
        'isMe': widget.userId == FirebaseAuth.instance.currentUser!.uid ? 1 : 0,
        'type': 'audio',
        'attachment': url,
      });

      await FirebaseFirestore.instance.collection('audio-sos').doc(userId).set({
        'createdAt': Timestamp.now(),
        'unread': 1,
        'recentText': 'audio',
        'username': widget.username,
        // 'profile_url': widget.profileUrl,
      });
    } catch (err) {
      isFileSendingTrue(false, '', '');
      print(err);
    }
  }

  void startRecording() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }

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
  void dispose() {
    if (myRecorder != null) {
      myRecorder!.closeRecorder();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId =widget.isAdmin ? widget.userId :  FirebaseAuth.instance.currentUser!.uid;
    userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isAdmin ? widget.username : 'Audio SOS',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      // extendBodyBehindAppBar: true,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('audio-sos')
            .doc(userId)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
          final data = snapshots.data!.docs;
          if (data.isEmpty) {
            return Center(
              child: Text(
                'No Audios yet',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    reverse: true,
                    itemBuilder: (ct, index) {
                      final tempData = data[index].data()! as Map;
                      return tempData['type'] == 'audio'
                          ? AudioBubble(
                              url: tempData['attachment'],
                              datetime: tempData['date'],
                              isMe: tempData['userId'] == userId,
                              read: tempData['read'],
                              isNetwork: true,
                            )
                          : const SizedBox.shrink();
                    }),
              ),
              if (isFileSending)
                isAudio
                    ? AudioBubble(
                        url: file,
                        datetime: DateTime.now().toIso8601String(),
                        isMe: userId == FirebaseAuth.instance.currentUser!.uid,
                        read: 0,
                        isNetwork: false,
                      )
                    : const SizedBox.shrink(),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(
          recording ? Icons.stop : Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
