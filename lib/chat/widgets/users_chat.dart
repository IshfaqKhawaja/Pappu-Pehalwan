import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../screens/chat.dart';

class UsersChat extends StatelessWidget {
  final username;
  final userid;
  final unread;
  final recentText;
  final phoneNumber;
  final details;
  final questions;
  final docId;
  final appBarTitle;
  final String? profileUrl;
  final Timestamp? datetime;
  final scaffoldKey;
  UsersChat({
    this.username,
    this.docId,
    this.recentText,
    this.unread,
    this.userid,
    this.phoneNumber,
    this.profileUrl,
    this.datetime,
    this.details,
    this.questions,
    this.appBarTitle,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    // print(datetime!.toDate());
    return Container(
      decoration: BoxDecoration(
        color: unread == 1
            ? Theme.of(context).primaryColor.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(top: 6, left: 4, right: 4),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => Chat(
                    appBarTitle: appBarTitle,
                    isTitleSet: true,
                    index: 0,
                    isFromUserChats: true,
                    phoneNumber: phoneNumber,
                    userId: userid,
                    username: username,
                    details: details,
                    docId: docId,
                    scaffoldKey: scaffoldKey,
                    questions: questions,
                    datetime: datetime,
                    isFromChatScreen: true,
                    

                  ),
                ),
              );
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 24,
              ),

              // backgroundImage: profileUrl!.isEmpty
              //     ? Image.asset('assets/images/default_userimage.jpeg').image
              //     : CachedNetworkImageProvider(profileUrl as String),
            ),
            title: Text(
              username,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontWeight: unread == 1 ? FontWeight.bold : FontWeight.w700,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              recentText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  DateFormat().add_MMMEd().format(
                        datetime!.toDate(),
                      ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                Text(
                  DateFormat().add_jm().format(
                        datetime!.toDate(),
                      ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
