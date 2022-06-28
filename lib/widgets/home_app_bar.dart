import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../chat/screens/chat.dart';
import '../chat/screens/chat_screen.dart';
import '../providers/user_details.dart';
import 'app_bar_item.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  Map<String, dynamic> userDetails = {};
 

  @override
  Widget build(BuildContext context) {
    userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    final titles = [
      // 'पर्यटन',
      // 'संस्कृति',
      // 'मैनपुरी',
      // 'लखनऊ',
      // 'सुझाव',
      // 'पर्यटन और संस्कृति',
      // 'मैनपुरी',
      'आपके सुझाव',
      'जानकारी',
      'कार्यक्रम',
      'जोगिंदर नगर',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and Suggestion Button
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 46,
              ),
            ),
            const Spacer(),
            OpenContainer(
                closedBuilder: (context, action) => Container(
                      margin: const EdgeInsets.only(
                        top: 13,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        'सुझाव/शिकायत',
                        style: GoogleFonts.openSans(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                // transitionDuration: const  Duration(milliseconds: 1000),
                closedColor: Colors.transparent,
                openElevation: 0.0,
                closedElevation: 0.0,
                openBuilder: (context, action) =>
                userDetails['isAdmin'] ?
                     ChatScreen()
                     : Chat(
                      userId: userDetails['userId'],
                      username: userDetails['name'],
                      phoneNumber: userDetails['phoneNumber'],
                      isDirect: true,
                     
                     ),
            ),
          ],
        ),
        // End
        const SizedBox(
          height: 15,
        ),
        // Scroll Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              titles.length,
              (index) => AppBarItem(
                title: titles[index],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
