import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'record_audio.dart';
import '../../screens/show_files.dart';

class NewMessageAdmin extends StatefulWidget {
  final userid;
  final isFileSendingTrue;
  NewMessageAdmin({this.userid, this.isFileSendingTrue});

  @override
  _NewMessageAdminState createState() => _NewMessageAdminState();
}

class _NewMessageAdminState extends State<NewMessageAdmin> {
  var _enteredText = '';
  File? image;
  final _textController = TextEditingController();
  List<File>? files = [];

  void send(List<File> files, BuildContext ctx) async {
    print(files);
    if (files.length > 0) {
      try {
        var id = FirebaseAuth.instance.currentUser!.uid;
        for (var file in files) {
          print(file);
          var type = file.path.endsWith('.jpg') ||
                  file.path.endsWith('.jpeg') ||
                  file.path.endsWith('.png')
              ? 'image'
              : 'video';
          widget.isFileSendingTrue(true, file, type);

          final ref = FirebaseStorage.instance
              .ref()
              .child('chat-images')
              .child('${Timestamp.now()}');
          await ref.putFile(file);
          final url = await ref.getDownloadURL();
          widget.isFileSendingTrue(false, '', '');

          await FirebaseFirestore.instance
              .collection('chats')
              .doc('${widget.userid}')
              .collection('messages')
              .add({
            'text': '',
            'createdAt': Timestamp.now(),
            'date': DateTime.now().toIso8601String(),
            'userId': id,
            'read': 0,
            'type': file.path.endsWith('.jpg') ||
                    file.path.endsWith('.jpeg') ||
                    file.path.endsWith('.png')
                ? 'image'
                : 'video',
            'attachment': url,
          });
          await FirebaseFirestore.instance
              .collection('chats')
              .doc('${widget.userid}')
              .update({
            'createdAt': Timestamp.now(),
            'unread': 0,
            'recentText': file.path.endsWith('.jpg') ||
                    file.path.endsWith('.jpeg') ||
                    file.path.endsWith('.png')
                ? 'image'
                : 'video',
          });
        }
      } on PlatformException catch (err) {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text('$err'),
        ));
      } catch (err) {
        print(err);
      }
    }
  }

  void _pickFiles() async {
    files = [];
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (result != null) {
      List<File> temp =
          result.paths.map((path) => File(path as String)).toList();
      files = new List.from(files!)..addAll(temp);
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
        var id = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance
            .collection('chats')
            .doc('${widget.userid}')
            .collection('messages')
            .add({
          'text': _enteredText,
          'createdAt': Timestamp.now(),
          'date': DateTime.now().toIso8601String(),
          'userId': id,
          'read': 0,
          'type': 'text',
        });
        await FirebaseFirestore.instance
            .collection('chats')
            .doc('${widget.userid}')
            .update({
          'createdAt': Timestamp.now(),
          'unread': 0,
          'recentText': _enteredText,
        });

        setState(() {
          _enteredText = '';
        });
      } on PlatformException catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$err'),
        ));
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const  EdgeInsets.all(10),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _textController,
           textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            decoration:  InputDecoration(
              labelText: 'Send a Message',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              ),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _enteredText = value;
              });
            },
          )),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.mic,
          //     color: Theme.of(context).errorColor,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              _pickFiles();
            },
            icon: Icon(
              Icons.collections,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
            userId: widget.userid,
            username: 'Jiwan Setu',
            isFileSending: widget.isFileSendingTrue,

          ),
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
