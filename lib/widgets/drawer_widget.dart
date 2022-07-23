import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pappupehalwan/chat/screens/chat_screen.dart';
import 'package:pappupehalwan/screens/about.dart';
import 'package:pappupehalwan/screens/admin_messages.dart';
import 'package:pappupehalwan/screens/contact_us.dart';
import '../auth/splash_screen.dart';
import '../providers/user_details.dart';
import 'package:provider/provider.dart';
import '../screens/profile.dart';

class DrawerWidget extends StatefulWidget {
  final username;
  final phoneNumber;
  final scaffoldKey;

  const DrawerWidget(
      {Key? key, this.username, this.phoneNumber, this.scaffoldKey})
      : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      semanticLabel: 'Pappu Pehalwan',
      backgroundColor: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Expanded(
              flex: 18,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: AppBar(
                        title: Column(
                          children: [
                            Image.asset(
                              'assets/images/drawer_icon.png',
                              height: 120,
                              fit: BoxFit.cover,
                              width: 120,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        automaticallyImplyLeading: false,
                        toolbarHeight: 200,
                        centerTitle: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        'Profile',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            )
                            .then((value) => Navigator.of(context).pop());
                      },
                      focusColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    ListTile(
                      title: Text(
                        'Suggestions',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        Icons.assistant,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context){
                          return ChatScreen(
                            isAdmin: false,
                            isComplaint: false,
                            isSuggestion: true,
                            scaffoldKey: widget.scaffoldKey,
                            userId: userDetails['userId'],
                            username: userDetails['name'],
                            suggestionComplaintTitle: 'सुझाव'
                          );
                        }),
                        ).then((value) => Navigator.of(context).pop());
                      },
                      focusColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    ListTile(
                      title: Text(
                        'Messages',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        Icons.message,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context){
                            return ChatScreen(
                              isAdmin: false,
                              isComplaint: false,
                              isSuggestion: false,
                              scaffoldKey: widget.scaffoldKey,
                              userId: userDetails['userId'],
                              username: userDetails['name'],
                            );
                          }
                        )).then((value) => Navigator.of(context).pop());
                      },
                      focusColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    ListTile(
                      title: Text(
                        'Complaints',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        Icons.quiz,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ChatScreen(
                            isAdmin: false,
                            isComplaint: true,
                            isSuggestion: false,
                            scaffoldKey: widget.scaffoldKey,
                            userId: userDetails['userId'],
                            username: userDetails['name'],
                            suggestionComplaintTitle: 'शिकायत',
                          );
                        })).then((value) => Navigator.of(context).pop());
                      },
                      focusColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    ListTile(
                      title: Text(
                        'About',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        Icons.account_circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const About()));
                      },
                      focusColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    ListTile(
                      title: Text(
                        'Contact Us',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUs()
                        )).then((value) => Navigator.of(context).pop());
                      },
                      focusColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                  ],
                ),
              )),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        backgroundColor: Colors.grey[350],
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userDetails['name'] ?? '',
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          Text(
                            userDetails['phoneNumber'] ?? '',
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen(
                                    isFromLogout: true,
                                  )));
                    },
                    child: Text(
                      "LogOut",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
