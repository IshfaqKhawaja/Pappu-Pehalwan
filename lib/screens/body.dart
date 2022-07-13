// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../chat/screens/chat_screen.dart';
import '../providers/load_data_from_facebook.dart';
import '../providers/user_details.dart';
import 'about.dart';
import 'admin_messages.dart';
import 'audio_sos.dart';
import 'audio_sos_admin.dart';
import 'body_home.dart';
import 'groups.dart';
import 'image_sos.dart';
import 'image_sos_admin.dart';
import 'load_posts.dart';
import 'users.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final rebuilt;
  final built;
  const Body({
    Key? key,
    this.rebuilt,
    this.built,
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
  void changeIndex(index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => userDetails['isAdmin']
            ? ImageSOSAdmin()
            : ImagesSOS(
                scaffoldKey: scaffoldKey,
                username: userDetails['name'] ?? userDetails['phoneNumber'],
                userId: userDetails['userId'],
              ),
      ));
    } else if (index == 4) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => userDetails['isAdmin']
            ? AudioSOSAdmin()
            :  AudioSOS(
                scaffoldKey: scaffoldKey,
                username: userDetails['name'] ?? userDetails['phoneNumber'],
                userId: userDetails['userId'],
              ),
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
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    print(userDetails);
    screens = [
      ImagesSOS(
        scaffoldKey: scaffoldKey,
      ),
      userDetails['isAdmin']
          ? AdminMessages()
          : ChatScreen(
              scaffoldKey: scaffoldKey,
            ),
      BodyHome(
        scaffoldKey: scaffoldKey,
      ),
      userDetails['isAdmin'] 
      ? Users():
      Groups(
        scaffoldKey: scaffoldKey,
      ),
      BodyHome(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // title: const HomeAppBar(),
        title: const Text('पप्पू पहलवान'),

        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => About()));
            },
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'assets/images/icon.jpg',
              ),
              radius: 20,
            ),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const  Icon(
      //     Icons.refresh,
      //     color: Colors.white,
      //   ),
      // ),
      drawer: DrawerWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: userDetails['isAdmin']
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text('Loading...'),
                    //   ),
                    // );
                    // widget.rebuilt();
                    // await Provider.of<LoadDataFromFacebook>(context,
                    //         listen: false)
                    //     .loadPosts();
                    // widget.built();
                    Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => LoadPosts()));
                    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text('Done...'),
                    //   ),
                    // );
                  },
                  child: const Icon(
                    Icons.refresh,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                // FloatingActionButton(
                //   heroTag: null,
                //   backgroundColor: Theme.of(context).primaryColor,
                //   onPressed: () {
                //     Provider.of<LoadDataFromFacebook>(context, listen: false)
                //         .pushDataToFirebase();
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text('Data Saved ...'),
                //       ),
                //     );
                //   },
                //   child: const Icon(
                //     Icons.save,
                //     size: 30,
                //     color: Colors.white,
                //   ),
                // ),
                // const SizedBox(
                //   height: 70,
                // ),
              ],
            )
          : null,
    );
  }
}
