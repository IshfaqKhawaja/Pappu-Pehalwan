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
          builder: (_) => userDetails['isAdmin'] ? ImageSOSAdmin() : About()
          // ImagesSOS(
          //         scaffoldKey: scaffoldKey,
          //         username: userDetails['name'] ?? userDetails['phoneNumber'],
          //         userId: userDetails['userId'],
          //       ),
          ));
// =======
//         builder: (_) => userDetails['isAdmin']
//             ? ImageSOSAdmin()
//             : ImagesSOS(
//                 scaffoldKey: scaffoldKey,
//                 username: userDetails['name'] ?? userDetails['phoneNumber'],
//                 userId: userDetails['userId'],
//               ),
            // : About()
        // ImagesSOS(
        //         scaffoldKey: scaffoldKey,
        //         username: userDetails['name'] ?? userDetails['phoneNumber'],
        //         userId: userDetails['userId'],
        //       ),
      // ));
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
          ? Users()
          : Groups(
              scaffoldKey: scaffoldKey,
            ),
      BodyHome(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
          // title: const HomeAppBar(),
          title: const Text('पप्पू पहलवान'),
          backgroundColor: const Color(0xFF56514D),
          actions: [
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: DropdownButton(
            //     onChanged: (Language? language){
            //     },
            //       underline: SizedBox(),
            //       icon: Icon(Icons.language,color: Colors.white,),
            //       items:languageList().map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
            //           value: lang,
            //           child: Text(lang.name)
            //       )).toList(),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const About()));
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
        //     const SizedBox(
        //       width: 10,
        //     ),
        //   ],
        //   centerTitle: true,
        //   elevation: 0,
        // ),
        // body: screens[currentIndex],
        // bottomNavigationBar: showBottomBar
        //     ? BottomBar(
        //         currentIndex: currentIndex,
        //         changeIndex: changeIndex,
        //         scaffoldKey: scaffoldKey,
        //       )
        //     : null,
        // drawer: DrawerWidget(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: userDetails['isAdmin']
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           FloatingActionButton(
        //             heroTag: null,
        //             backgroundColor: Theme.of(context).primaryColor,
        //             onPressed: () async {
        //               widget.rebuilt();
        //               await Provider.of<LoadDataFromFacebook>(context,
        //                       listen: false)
        //                   .loadPosts();
        //               widget.built();
        //             },
        //             child: const Icon(
        //               Icons.refresh,
        //               size: 30,
        //               color: Colors.white,
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           FloatingActionButton(
        //             heroTag: null,
        //             backgroundColor: Theme.of(context).primaryColor,
        //             onPressed: () {
        //               Provider.of<LoadDataFromFacebook>(context, listen: false)
        //                   .pushDataToFirebase();
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 const SnackBar(
        //                   content: Text('Data Saved ...'),
        //                 ),
        //               );
        //             },
        //             child: const Icon(
        //               Icons.save,
        //               size: 30,
        //               color: Colors.white,
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 70,
        //           ),
        //         ],
        //       )
        //     : null,
      ),
    );
  }
}
