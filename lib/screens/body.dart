// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pappupehalwan/screens/contact_us.dart';
import 'package:pappupehalwan/screens/profile.dart';
import 'package:pappupehalwan/widgets/add_users_categories.dart';
import '../chat/screens/chat_screen.dart';
import '../providers/load_data_from_facebook.dart';
import '../providers/user_details.dart';
import 'about.dart';
import 'admin_messages.dart';
import 'body_home.dart';
import 'load_posts.dart';
import 'users.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final rebuilt;
  final built;
  final loadData;

  const Body({
    Key? key,
    this.rebuilt,
    this.built,
    this.loadData,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showBottomBar = true;
  double prevState = 0.0;
  double newState = 0.0;
  int currentIndex = 2;
  List screens = [];
  Map userDetails = {};
  bool loading = false;

  void changeIndex(index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const About()
      ));
    } else if (index == 4) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const ContactUs()
      ));
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userDetails =
        Provider
            .of<UserDetails>(context, listen: false)
            .getUserDetails;
    print(userDetails);
    screens = [
      const About(),
      userDetails['isAdmin']
          ? const AdminMessages()
          : ChatScreen(
        scaffoldKey: scaffoldKey,
      ),
      BodyHome(
        scaffoldKey: scaffoldKey,
      ),
      userDetails['isAdmin']
          ? const Users() : const Profile(),
      const BodyHome(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return WillPopScope(
      onWillPop: () async {
        bool value = false;
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to exit'),
                actions: [
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                      value = false;
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                      value = true;
                    },
                  ),
                ],
              );
            });
        return value;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('पप्पू पहलवान'),
          backgroundColor: const Color(0xFF56514D),
          actions: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'assets/images/icon.jpg',
              ),
              radius: 20,
            ),

            const SizedBox(
              width: 10,
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: screens[currentIndex],
        bottomNavigationBar: showBottomBar
            ? BottomBar(
          currentIndex: currentIndex,
          changeIndex: changeIndex,
          scaffoldKey: scaffoldKey,
        )
            : null,
        drawer: DrawerWidget(
          scaffoldKey: scaffoldKey,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: userDetails['isAdmin'] && currentIndex == 2
            ? Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () async {
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(builder: (ctx) => const LoadPosts()))
                    .then((value) async {
                  widget.rebuilt();
                  await Provider.of<LoadDataFromFacebook>(
                      context, listen: false).loadPostsFromFirebase(
                        userDetails: userDetails,
                      );
                  widget.built();
                });
              },
              child: loading ? const SpinKitWave(
                color: Colors.white,
                size: 20,
              ) : const Icon(
                Icons.refresh,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        )
            : userDetails['isAdmin'] && currentIndex == 3
            ? Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () async{
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return const Dialog(
                          child: AddUsersCategories(),
                        );
                      }
                  );
                },
              child: const Icon(
                Icons.add,
                size: 30,
                  color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        )
        : null,
      ),
    );
  }
}
