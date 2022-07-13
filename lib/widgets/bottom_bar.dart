import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/user_details.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  final currentIndex;
  final changeIndex;
  final scaffoldKey;
  const BottomBar({
    Key? key,
    this.currentIndex,
    this.changeIndex,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    final labelStyle = GoogleFonts.openSans(
      fontWeight: FontWeight.w800,
      color: Colors.black,
    );
    return BottomNavigationBar(
      backgroundColor: Color(0xff56514D),
      currentIndex: currentIndex,
      onTap: (index) {
        changeIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 13,
      unselectedFontSize: 12,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: labelStyle,
      unselectedLabelStyle: labelStyle,
      items: [
        BottomNavigationBarItem(
          // change name from SOS to about but functionality of sos is still there which we will change
          icon: Icon(
            currentIndex == 0 ? Icons.manage_accounts : Icons.manage_accounts_outlined,
            color: Color(0xffA9ADB6),
            size: currentIndex == 0 ? 25 : 20,
          ),
          label: 'ABOUT',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1 ? Icons.work : Icons.work_outline,
            color: Color(0xffA9ADB6),
            size: currentIndex == 1 ? 25 : 20,
          ),
          label: 'MESSAGES',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.home : Icons.home_outlined,
            color: Color(0xffA9ADB6),
            size: currentIndex == 2 ? 25 : 20,
          ),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 3 ? Icons.person_add : Icons.group,
            color: Color(0xffA9ADB6),
            size: currentIndex == 3 ? 25 : 20,
          ),
          label: userDetails['isAdmin'] ? 'Users' : 'GROUPS',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 4 ? Icons.mic : Icons.mic_outlined,
            color: Color(0xffA9ADB6),
            size: currentIndex == 4 ? 25 : 20,
          ),
          label: 'RECORD',
        ),
      ],
    );
  }
}
