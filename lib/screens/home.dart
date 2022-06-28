import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/splash_screen.dart';
import '../chat/screens/chat.dart';
import '../chat/widgets/show_image.dart';
import '../providers/load_data_from_facebook.dart';
import '../providers/user_details.dart';
import 'show_files.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;
  

  void checkCreds(context) {
    final user = FirebaseAuth.instance.currentUser;
    // print(user);

    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }
  void rebuilt() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkCreds(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadDataFromFacebook()),
        ChangeNotifierProvider(create: (_)=> UserDetails()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff4a7fd1),
              actionsIconTheme: IconThemeData(
                color: Color(0xffeef3f6),
              ),
            ),
            scaffoldBackgroundColor: const Color(0xfff0e8f8),
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff082545),
              ),
              bodyMedium: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff082545),
              ),
              bodySmall: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff082545),
              ),
              // button: GoogleFonts.openSans(
              //   fontSize: 16,
              //   fontWeight: FontWeight.w600,
              //   color: Color(0xff082545),
              // ),
              // headline1: GoogleFonts.openSans(
              //   fontSize: 24,
              //   fontWeight: FontWeight.w600,
              //   color: Color(0xff082545),
              // ),
              // headline2: GoogleFonts.openSans(
              //   fontSize: 22,
              //   fontWeight: FontWeight.w600,
              //   color: Color(0xff082545),
              // ),
            ),
            primaryColor: const Color(0xff4a7fd1),
            iconTheme: const IconThemeData(
              color: Color(0xffeef3f6),
            ),
            backgroundColor: const Color(0xfff0e8f8),
            buttonColor: const Color(0xffe51818),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xffd5dadf),
            )),
        home: SplashScreen(),
        routes: {
          ShowFiles.routeName : (_) => ShowFiles(),
          ShowImage.routeName: (_) => ShowImage(),
          Chat.routeName : (_) => Chat(),
        },
      ),
    );
  }
}
