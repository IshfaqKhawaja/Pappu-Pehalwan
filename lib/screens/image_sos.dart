import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../chat/widgets/show_image_bubble.dart';
import '../chat/widgets/show_video_bubble.dart';
import '../providers/user_details.dart';
import 'show_files.dart';
import 'package:provider/provider.dart';

class ImagesSOS extends StatefulWidget {
  final scaffoldKey;
  final isAdmin;
  final userId;
  final username;
  const ImagesSOS({
    Key? key,
    this.scaffoldKey,
    this.isAdmin = false,
    this.userId,
    this.username,
  }) : super(key: key);

  @override
  State<ImagesSOS> createState() => _ImagesSOSState();
}

class _ImagesSOSState extends State<ImagesSOS> {
  String userId = '';
  Map<String, dynamic> userDetails = {};
  List<File>? files;
  bool isImage = false;
  bool isVideo = false;
  bool isFileSending = false;
  var file;
  void isFileSendingTrue(bool value, var file, String type) {
    isImage = false;
    isVideo = false;
    setState(() {
      isFileSending = value;
      type == 'image'
          ? isImage = true
          : type == 'video'
              ? isVideo = true
              : {};
      this.file = file;
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
          print(file);
          isFileSendingTrue(true, file, type);
          final ref = FirebaseStorage.instance
              .ref()
              .child('chat-images')
              .child('$userId${Timestamp.now()}');
          await ref.putFile(file);
          final url = await ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('images-sos')
              .doc(userId)
              .collection('messages')
              .add({
            'text': '',
            'createdAt': Timestamp.now(),
            'date': DateTime.now().toIso8601String(),
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'read': 0,
            'type': file.path.endsWith('.jpg') ||
                    file.path.endsWith('.jpeg') ||
                    file.path.endsWith('.png')
                ? 'image'
                : 'video',
            'attachment': url,
          });
          isFileSendingTrue(false, '', '');

          await FirebaseFirestore.instance
              .collection('images-sos')
              .doc(userId)
              .set({
            'createdAt': Timestamp.now(),
            'unread': 1,
            'recentText': file.path.endsWith('.jpg') ||
                    file.path.endsWith('.jpeg') ||
                    file.path.endsWith('.png')
                ? 'image'
                : 'video',
            'username': userDetails['name'],
            'profile_url': '',
          });
        }
      } on PlatformException catch (err) {
        isFileSendingTrue(false, '', '');
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
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

  @override
  void initState() {
    super.initState();
    userId =
        widget.isAdmin ? widget.userId : FirebaseAuth.instance.currentUser!.uid;
    userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    print(userDetails);
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isAdmin ? widget.username : 'Image SOS',
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
            .collection('images-sos')
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
                'No Attachments Yet',
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
                      print(tempData['userId']);
                      print(userId);
                      print(tempData['userId'] == userId);
                      return tempData['type'] == 'image'
                          ? ShowImageBubble(
                              datetime: tempData['date'],
                              isMe: tempData['userId'] == userId,
                              isNetwork: true,
                              read: tempData['read'],
                              url: tempData['attachment'],
                              showDate: true,
                            )
                          : tempData['type'] == 'video'
                              ? ShowVideoBubble(
                                  datetime: tempData['date'],
                                  isMe: tempData['userId'] == userId,
                                  isNetwork: true,
                                  read: tempData['read'],
                                  url: tempData['attachment'],
                                  showDate: true,
                                )
                              : const SizedBox.shrink();
                    }),
              ),
              if (isFileSending)
                isImage
                    ? ShowImageBubble(
                        url: file,
                        datetime: DateTime.now().toIso8601String(),
                        isMe: userId == FirebaseAuth.instance.currentUser!.uid,
                        read: 0,
                        isNetwork: false,
                      )
                    : isVideo
                        ? ShowVideoBubble(
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: pickImage,
            child: const Icon(
              Icons.party_mode,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: _pickFiles,
            child: const Icon(
              Icons.collections,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
