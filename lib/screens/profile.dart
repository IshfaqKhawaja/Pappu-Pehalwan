import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
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
            decoration: InputDecoration(
              hintText: title,
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
            Icon(
              Icons.account_circle,
              size: 200,
              color: Theme.of(context).primaryColor,
            ),
            sizedBox,
            makeTextField(context, 'Name'),
            sizedBox,
            makeTextField(context, 'Occupation'),
            sizedBox,
            makeTextField(context, 'Age'),
            sizedBox,
            makeTextField(context, 'Village/Town'),
            sizedBox,
            makeTextField(context, 'Gender'),
            sizedBox,
            makeTextField(context, 'Verified/Unverified'),
            sizedBox,
            sizedBox,
            MaterialButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onPressed: () {},
              child: Text('SAVE', style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              
              ),),
              ),
              sizedBox,
          ],
        ),
      ),
    );
  }
}
