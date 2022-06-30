import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'record_audio.dart';
import '../../screens/show_files.dart';

class NewMessageUser extends StatefulWidget {
  final userid;
  final username;
  final details;
  final questions;
  final profileUrl;
  final isFileSendingTrue;
  final addDetails;
  final changeMessageSent;
  final sameScreen;
  final changeSameScreen;
  final docId;
  final appBarTitle;
  final scaffoldKey;
  final scrollToEnd;
  final changeShowInputMessageField;
  final isFromUserChats;
  final changeShowReplyAgain;
  NewMessageUser({
    this.userid,
    this.username,
    this.profileUrl,
    this.isFileSendingTrue,
    this.details,
    this.questions,
    this.addDetails,
    this.sameScreen,
    this.changeMessageSent,
    this.changeSameScreen,
    this.docId,
    this.appBarTitle,
    this.scaffoldKey,
    this.scrollToEnd,
    this.changeShowInputMessageField,
    this.isFromUserChats,
    this.changeShowReplyAgain,
  });

  @override
  _NewMessageUserState createState() => _NewMessageUserState();
}

class _NewMessageUserState extends State<NewMessageUser> {
  var _enteredText = '';
  File? image;
  final _textController = TextEditingController();
  List<File>? files = [];
  GlobalKey<RecordAudioState> audioKey = GlobalKey<RecordAudioState>();
  bool isRecording = false;
  void changeIsRecording(value) {
    setState(() {
      isRecording = value;
    });
  }
  void send(List<File> files, BuildContext ctx) async {
    // print(files);
    if (files.isNotEmpty) {
      try {
        for (var file in files) {
          var type = file.path.endsWith('.jpg') ||
                  file.path.endsWith('.jpeg') ||
                  file.path.endsWith('.png')
              ? 'image'
              : 'video';
          widget.isFileSendingTrue(true, file, type);

          print(file);
          final ref = FirebaseStorage.instance.ref().child('chat-images').child(
              '${FirebaseAuth.instance.currentUser!.uid}${Timestamp.now()}');
          await ref.putFile(file);
          final url = await ref.getDownloadURL();
          widget.isFileSendingTrue(false, '', '');

          List details = widget.details;
          details.add({
            'title': '',
            'createdAt': Timestamp.now(),
            'date': DateTime.now().toIso8601String(),
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'read': 0,
            'isMe':
                widget.userid == FirebaseAuth.instance.currentUser!.uid ? 1 : 0,
            'type': file.path.endsWith('.jpg') ||
                    file.path.endsWith('.jpeg') ||
                    file.path.endsWith('.png')
                ? 'image'
                : 'video',
            'attachment': url,
          });
          var res;
          if (!widget.sameScreen) {
            res = await FirebaseFirestore.instance
                .collection('suggestions') //'chats
                .doc('${widget.userid}')
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
                .doc('${widget.userid}')
                .collection('messages')
                .doc(widget.docId) //messages
                .update({
              'details': details,
              'createdAt': Timestamp.now(),
              'questions': widget.questions,
              'title': widget.appBarTitle,
            });
            widget.changeMessageSent(widget.docId);
          }

          await FirebaseFirestore.instance
              .collection('suggestions')
              .doc('${widget.userid}')
              .set({
            'createdAt': Timestamp.now(),
            'unread': 1,
            'recentText': file.path.endsWith('.jpg') ||
                    file.path.endsWith('.jpeg') ||
                    file.path.endsWith('.png')
                ? 'image'
                : 'video',
            'username': widget.username,
            'profile_url': widget.profileUrl,
          });
          if (!widget.isFromUserChats) {
            widget.changeShowInputMessageField(false);
            widget.changeShowReplyAgain(true);
          }
        }
      } on PlatformException catch (err) {
        widget.isFileSendingTrue(false, '', '');
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text('$err'),
        ));
      } catch (err) {
        // print(err);
      }
    }
  }

  void _pickFiles() async {
    files = [];
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.media,
        allowCompression: true,
        onFileLoading: (status) {
          print(status);
        });
    if (result != null) {
      List<File> temp =
          result.paths.map((path) => File(path as String)).toList();
      files = List.from(files!)..addAll(temp);
      Navigator.of(context).pushNamed(ShowFiles.routeName,
          arguments: {'files': temp}).then((value) {
        if (value != null) {
          setState(() {
            send(files!, context);
          });
        }
      });
    }
  }

  void pickImage() async {
    List<File> images = [];
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      images.add(File(pickedImage.path));
      // print(images);
      await Navigator.of(context).pushNamed(ShowFiles.routeName,
          arguments: {'files': images}).then((value) {
        if (value != null) {
          setState(() {
            send(images, context);
          });
        }
      });
    }
  }
  void _sendMessage() async {
    if (_enteredText.isNotEmpty) {
      try {
        _textController.text = '';
        List details = widget.details;
        details.add({
          'title': _enteredText,
          'createdAt': Timestamp.now(),
          'date': DateTime.now().toIso8601String(),
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'read': 0,
          'type': 'text',
          'isMe':
              widget.userid == FirebaseAuth.instance.currentUser!.uid ? 1 : 0,
        });
        // print(details);
        var res;
        if (!widget.sameScreen) {
          res = await FirebaseFirestore.instance
              .collection('suggestions') //'chats
              .doc('${widget.userid}')
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
              .doc('${widget.userid}')
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

        await FirebaseFirestore.instance
            .collection('suggestions')
            .doc('${widget.userid}')
            .set({
          'createdAt': Timestamp.now(),
          'unread':
              widget.userid == FirebaseAuth.instance.currentUser!.uid ? 0 : 1,
          'recentText': _enteredText,
          'username': widget.username,
          'profile_url': widget.profileUrl,
        });

        setState(() {
          _enteredText = '';
          _textController.text = '';
        });
        if (!widget.isFromUserChats) {
          widget.changeShowInputMessageField(false);
          widget.changeShowReplyAgain(true);
        }

      } on PlatformException catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$err'),
        ));
        print(err);
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
              decoration: InputDecoration(
                hintText: isRecording ? ''
                :
                'Send a Message',
                enabledBorder: isRecording ? null : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                focusedBorder: isRecording ? null : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                border:isRecording ? 
               InputBorder.none :  
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                suffixIcon: _textController.text != ''
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(!isRecording)
                          IconButton(
                            onPressed: () {
                              _pickFiles();
                            },
                            icon: Icon(
                              Icons.collections,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          if(!isRecording)
                          IconButton(
                            onPressed: () {
                              pickImage();
                            },
                            icon: Icon(
                              Icons.local_see,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          RecordAudio(
                            key: audioKey,
                            userId: widget.userid,
                            username: widget.username,
                            isFileSending: widget.isFileSendingTrue,
                            details: widget.details,
                            questions: widget.questions,
                            changeMessageSent: widget.changeMessageSent,
                            changeSameScreen: widget.changeSameScreen,
                            sameScreen: widget.sameScreen,
                            docId: widget.docId,
                            appBarTitle: widget.appBarTitle,
                            scaffoldKey: widget.scaffoldKey,
                            scrollToEnd: widget.scrollToEnd,
                            changeShowInputMessageField:
                                widget.changeShowInputMessageField,
                            isFromUserChats: widget.isFromUserChats,
                            changeShowReplyAgain: widget.changeShowReplyAgain,
                            changeIsRecording : changeIsRecording,
                          ),
                        ],
                      ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredText = value;
                });
              },
            ),
          ),
          if(!isRecording)
          IconButton(
            onPressed: _enteredText.isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
              color: _enteredText.isEmpty
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
