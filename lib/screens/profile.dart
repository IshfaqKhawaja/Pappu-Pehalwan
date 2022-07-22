import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/user_details.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> profile = {};
  var userDetails = {};
  PickedFile? imageChosen;
  bool savingData = false;
  String profileUrl = '';
  final genders = ['Male, Female'];
  bool isMale = true;
  bool isFemale = false;
  String gender = 'male';

  @override
  void initState() {
    super.initState();
    userDetails =
        Provider
            .of<UserDetails>(context, listen: false)
            .getUserDetails;
    profileUrl = userDetails['profileUrl'] ?? '';
    if (userDetails['gender'] != null && userDetails['gender'] == 'male') {
      isMale = true;
      isFemale = false;
      gender = 'male';
    } else {
      isMale = false;
      isFemale = true;
      gender = 'female';
    }
  }
  Widget makeTextField(context, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.openSans(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(
            height: 10,
          ),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              setState(() {
                profile[title.toString().toLowerCase()] = value;
              });
            },
            keyboardType:
                title == 'Age' ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: userDetails[title.toString().toLowerCase()] ?? title,
              hintStyle: GoogleFonts.openSans(
                color: Theme.of(context).primaryColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void chooseProfilePic() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageChosen = image;
      });
    }
  }

  void saveData() async {
    // print(userDetails);
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        savingData = true;
      });
      // Deleting Previous Image
      if (profileUrl != '') {
        // print(profileUrl);
      await FirebaseStorage.instance.refFromURL(profileUrl).delete();
      }
      if (imageChosen != null) {
        var ref = FirebaseStorage.instance
            .ref()
            .child('profile_pics')
            .child('${userDetails['userId']}${Timestamp.now()}.jpg');
        await ref.putFile(File(imageChosen!.path));
        var url = await ref.getDownloadURL();
        profile['profileUrl'] = url;
      }
      profile['gender'] = gender;
      print(profile);
      var id = userDetails['userId'];
      // print(id);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(profile);
      Provider.of<UserDetails>(context, listen: false).loadUserDetails();
      setState(() {
        savingData = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
         const  SnackBar(content: Text('Details Update'), duration: Duration(milliseconds: 1000)));
    } catch (e) {
      print(e);
      setState(() {
        savingData = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = const SizedBox(
      height: 10,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizedBox,
            InkWell(
              onTap: chooseProfilePic,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: imageChosen != null
                    ? Image.file(File(imageChosen!.path)).image
                    : profileUrl != ''
                        ? NetworkImage(profileUrl)
                        : Image.asset('assets/images/default.jpg').image,
              ),
            ),
            sizedBox,
            makeTextField(context, 'Name'),
            sizedBox,
            makeTextField(context, 'Email'),
            sizedBox,
            makeTextField(context, 'Occupation'),
            sizedBox,
            makeTextField(context, 'Age'),
            sizedBox,
            makeTextField(context, 'Address'),
            sizedBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gender',style: GoogleFonts.openSans(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: isMale ? Theme.of(context).primaryColor : Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Male',
                              style: GoogleFonts.openSans(
                                color: isMale ? Theme.of(context).primaryColor : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        onTap: (){
                          setState((){
                            isMale = true;
                            isFemale = false;
                            gender = 'male';
                          });
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: isFemale ? Theme.of(context).primaryColor : Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Female',
                              style: GoogleFonts.openSans(
                                color: isFemale ? Theme.of(context).primaryColor : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        onTap: (){
                          setState((){
                            isMale = false;
                            isFemale = true;
                            gender = 'female';
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            sizedBox,
            sizedBox,
            MaterialButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onPressed: saveData,
              child: savingData
                  ? const CircularProgressIndicator()
                  : Text(
                      'SAVE',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            sizedBox,
          ],
        ),
      ),
    );
  }
}
