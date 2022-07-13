import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../chat/screens/chat.dart';
import '../providers/user_details.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyPart2JS extends StatelessWidget {
  final scaffoldKey;
  const BodyPart2JS({
    Key? key,
    this.scaffoldKey,
  }) : super(key: key);
  Widget makeIconContainer(context, icon, title, index, width, color) {
    return InkWell(
      splashColor: Colors.redAccent,

      onHover: (_) {},
      onTap: () {
        final userDetails =
            Provider.of<UserDetails>(context, listen: false).getUserDetails;

        if (index == 0 || index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Chat(
                  userId: userDetails['userId'],
                  username: userDetails['name'] != ''
                      ? userDetails['name']
                      : userDetails['phoneNumber'],
                  appBarTitle: title,
                  phoneNumber: userDetails['phoneNumber'],
                  isDirect: true,
                  isTitleSet: true,
                  scaffoldKey: scaffoldKey,                  
                  index: index == 0 ? 0 : 1,
                );
              },
            ),
          );
        }
        if (index == 1) {
          launch("tel://9999999999");
        }
      },
      child: Container(
        // height: 120,
        width: width * 0.27,
        margin: const EdgeInsets.only(
          right: 10,
          left: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: width * 0.1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: width * 0.029,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var titles = [
      {
        'icon': Icons.quiz,
        'title': 'शिकायत', 
        'color': Color(0xFF149531),
      },
      {
        'icon': Icons.woman_outlined,
        'title': 'आपातकालीन नंबर',
        'color': Color(0xFFF20202)
      },
      {
        'icon': Icons.assistant_outlined,
        'title': 'सुझाव', 
        'color': Color(0xFF149531),
        },
    ];
    final width = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.white,
      width: width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(
          titles.length,
          (index) => makeIconContainer(context, titles[index]['icon'],
              titles[index]['title'], index, width, titles[index]['color']),
        ),
      ),
    );
  }
}
