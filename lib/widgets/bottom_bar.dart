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
      currentIndex: currentIndex,
      onTap: (index) {
        changeIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 13,
      unselectedFontSize: 12,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: labelStyle,
      unselectedLabelStyle: labelStyle,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 0 ? Icons.party_mode : Icons.party_mode_outlined,
            color: Colors.black,
            size: currentIndex == 0 ? 25 : 20,
          ),
          label: 'SOS',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1 ? Icons.work : Icons.work_outline,
            color: Colors.black,
            size: currentIndex == 1 ? 25 : 20,
          ),
          label: 'MESSAGES',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.home : Icons.home_outlined,
            color: Colors.black,
            size: currentIndex == 2 ? 25 : 20,
          ),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 3 ? Icons.person_add : Icons.person_add_outlined,
            color: Colors.black,
            size: currentIndex == 3 ? 25 : 20,
          ),
          label: userDetails['isAdmin'] ? 'Users' : 'GROUPS',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 4 ? Icons.mic : Icons.mic_outlined,
            color: Colors.black,
            size: currentIndex == 4 ? 25 : 20,
          ),
          label: 'SOS',
        ),
      ],
    );
  }
}
