import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/user_details.dart';
import '../screens/state_plans.dart';
import 'package:provider/provider.dart';

class YojanaScreen extends StatefulWidget {
  const YojanaScreen({Key? key}) : super(key: key);

  @override
  State<YojanaScreen> createState() => _YojanaScreenState();
}

class _YojanaScreenState extends State<YojanaScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String type = 'state';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'सरकारी योजनाएं',
              style: GoogleFonts.openSans(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            if (userDetails['isAdmin'])
              IconButton(
                  onPressed: () => showModalBottomSheet(
                        enableDrag: true,
                        isScrollControlled: false,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        context: context,
                        builder: (context) => YoganaBottomSheet(
                          type: type,
                        ),
                      ),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
          ],
        ),
        bottom: TabBar(
          controller: tabController,
          labelStyle:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700),
          tabs: const [
            Tab(
              text: 'उ.प्र सरकारी योजनाएं',
            ),
            Tab(
              text: 'राष्ट्रीय सरकारी योजनाएं',
            ),
          ],
          onTap: (index) {
            setState(() {
              type = index == 1 ? 'national' : 'state';
            });
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          StatesPlans(
            type: 0,
          ),
          StatesPlans(
            type: 1,
          ),
        ],
      ),
    );
  }
}


//Yogana Bottom Sheet for admin site



class YoganaBottomSheet extends StatefulWidget {
  final type;

  const YoganaBottomSheet({
    Key? key,
    this.type,
  }) : super(key: key);

  @override
  State<YoganaBottomSheet> createState() => _YoganaBottomSheetState();
}

class _YoganaBottomSheetState extends State<YoganaBottomSheet> {
  File? image;
  String title = '';
  String description = '';
  bool isLoading = false;

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<void> send(image, title, description, type) async {
    String url = '';
    //Adding Image to Firebase Storage
    if (image != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('yogana-images')
          .child('${FirebaseAuth.instance.currentUser!.uid}${Timestamp.now()}');
      await ref.putFile(image);
      url = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection('yogana').add(
        {'title': title, 'description': description, 'type': type, 'url': url});

    Fluttertoast.showToast(msg: 'Added Successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: image != null ? 600 : 400,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),

      child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                  onTap: () {
                    _pickImage();
                  },
                  child: image != null
                      ? Image.file(
                          image!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      : const Text("Tap to add photo +"))),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.7)),
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please give title to yojana";
                }
              },
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
              maxLines: 1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: GoogleFonts.openSans(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.7)),
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please give description to yojana";
                }
                return null;
              },
              onChanged: (val) {
                description = val;
              },
              maxLines: 7,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: GoogleFonts.openSans(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  if (image == null) {
                    await send(null, title, description, widget.type);
                  } else {
                    await send(image!, title, description, widget.type);
                  }
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: isLoading
                  ? Container(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator())
                  : const Text('Save'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
