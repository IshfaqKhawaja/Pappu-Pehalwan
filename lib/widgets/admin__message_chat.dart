import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../chat/widgets/message_ticket_status.dart';
import '../chat/screens/admin_chat_screen.dart';
import '../chat/screens/chat.dart';

class AdminMessageChat extends StatelessWidget {
  final datetime;
  final phoneNumber;
  final recentText;
  final unread;
  final userid;
  final username;
  final isRedirect;
  final details;
  final questions;
  final docId;
  final appBarTitle;
  final status;

  const AdminMessageChat({
    Key? key,
    this.datetime,
    this.appBarTitle,
    this.phoneNumber,
    this.recentText,
    this.unread,
    this.userid,
    this.username,
    this.isRedirect = false,
    this.details,
    this.questions,
    this.docId,
    this.status = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(top: 6, left: 4, right: 4),
      child: Column(
        children: [
          ListTile(
            onTap: () async {
              // if (isRedirect && status < 1) {
              //   await FirebaseFirestore.instance
              //       .collection('suggestions')
              //       .doc(userid)
              //       .collection('messages')
              //       .doc(docId)
              //       .update({'status': 1});
              // }
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (ctx) => isRedirect
                    ? Chat(
                        appBarTitle: appBarTitle,
                        details: details,
                        docId: docId,
                        index: 0,
                        isAdmin: true,
                        isDirect: true,
                        isFromUserChats: true,
                        isTitleSet: true,
                        phoneNumber: username,
                        scaffoldKey: null,
                        userId: userid,
                        username: username,
                        questions: questions,
                        datetime: datetime,
                        isFromChatScreen: true,
                      )
                    : AdminChatScreen(
                        userId: userid,
                        username: username,
                      ),
              ))
                  .then((value) {
                if (isRedirect && status < 1) {
                  FirebaseFirestore.instance
                      .collection('suggestions')
                      .doc(userid)
                      .collection('messages')
                      .doc(docId)
                      .update({'status': 1});
                }
              });
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Text(
              username,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontWeight: unread == 1 ? FontWeight.bold : FontWeight.w700,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recentText,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                if (isRedirect)
                  MessageTicketStatus(
                    status: status,
                  )
              ],
            ),
            trailing: Column(
              children: [
                Text(
                  DateFormat().add_MMMEd().format(
                        datetime!.toDate(),
                      ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  DateFormat().add_jm().format(
                        datetime!.toDate(),
                      ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
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
