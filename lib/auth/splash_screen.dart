import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import '../providers/load_data_from_facebook.dart';
import '../providers/user_details.dart';
import '../screens/body.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  bool isLoading = true;
  bool isRebuilding = false;

  Future<void> loadData() async {
    try {
      // await Provider.of<LoadDataFromFacebook>(context, listen: false).loadPosts();

      Provider.of<UserDetails>(context, listen: false).loadUserDetails();
      await Provider.of<LoadDataFromFacebook>(context, listen: false)
          .loadDataFromFirebase();
      await Future.delayed(const Duration(milliseconds: 2400));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  void rebuilt() {
    setState(() {
      isRebuilding = true;
    });
  }

  void built() {
    setState(() {
      isRebuilding = false;
    });
  }

  void checkCreds() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
        loadData();
      });
    } else {
      setState(() {
        isLoading = false;
        isLoggedIn = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkCreds();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/icon.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Pappu Pehalwan',
                        textStyle: GoogleFonts.openSans(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 4,
                    // pause: const Duration(milliseconds: 500),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ],
              ),
            ),
          )
        : isLoggedIn
            ? isRebuilding
                ? Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Body(
                    rebuilt: rebuilt,
                    built: built,
                  )
            : Login(
                loadData: loadData,
              );
  }
}
