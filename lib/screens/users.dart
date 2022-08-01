import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/sub_admin_typeahead.dart';
import '../providers/user_details.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List userCategories = [];
  String field = '';
  String value = '';
  bool filterApplied = false;

  void applyFilter(field, value) {
    setState(() {
      this.field = field;
      this.value = value;
      filterApplied = true;
    });
  }

  Future<List> loadUserCategories() async {
    userCategories = [];
    var res =
    await FirebaseFirestore.instance.collection('userCategories').get();
    if (res.docs.isNotEmpty) {
      for (var i in res.docs) {
        userCategories.add(i['category']);
      }
    }
    return userCategories;
  }

  void usersFilter() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            UserFilters(
              applyFilter: applyFilter,
            ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider
            .of<UserDetails>(context, listen: false)
            .getUserDetails;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Users",
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            IconButton(
                onPressed: () {
                  usersFilter();
                },
                icon: const Icon(Icons.filter_list))
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data!.docs;
          if (users.isEmpty) {
            return Center(
              child: Text(
                'No users found',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (filterApplied && field != '' && value != '') {
            users.retainWhere((user) {
              field = field != 'phoneNumber' ? field.toLowerCase() : field;
              try {
                var temp = user[field];
                return (user[field] as String)
                    .toLowerCase()
                    .contains(value.toLowerCase());
              } catch (e) {
                return false;
              }
            });
          }

          if (users.isEmpty) {
            return const Center(
              child: Text('No User Found'),
            );
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              final user = users[index].data()! as Map<String, dynamic>;
              return Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme
                      .of(context)
                      .primaryColor
                      .withOpacity(0.2),
                ),
                child: ListTile(
                  onTap: () async {
                    userCategories = await loadUserCategories();

                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return Dialog(
                            child: UserDetail(
                              userId: user['userId'],
                              userCategories: userCategories,
                            ),
                          );
                        });
                  },
                  title: Text(
                    user['name'] != ''
                        ? user['name'].toString().toUpperCase()
                        : user['phoneNumber'],
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      if(user.containsKey('phoneNumber') &&
                          user['phoneNumber'] != '')
                        Text(
                          user['phoneNumber'],
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      if(user.containsKey('email') && user['email'] != '')
                        Text(
                          user['email'],
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      // if(user.containsKey('nagarNigamServices') &&
                      //     user['nagarNigamServices'] != '')
                      //   Text(
                      //     '${user['nagarNigamServices'] ?? ''}',
                      //     style: GoogleFonts.openSans(
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.black,
                      //         fontSize: 10
                      //     ),
                      //   )
                    ],
                  ),
                  trailing: userDetails['isAdmin'] == true
                      ? ToggleSwitch(
                    minWidth: 60.0,
                    initialLabelIndex: user['isAdmin']
                        ? 0 : 1,
                        // : user.containsKey('isSubAdmin') &&
                        // user['isSubAdmin']
                        // ? 1
                        // : 2,
                    cornerRadius: 10.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: const ['Admin','User'],
                    customTextStyles: const [
                      TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      // TextStyle(
                      //   fontSize: 8,
                      //   color: Colors.white,
                      //   fontWeight: FontWeight.w700,
                      // ),
                      TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                    onToggle: (index) async {
                      // if (index == 1) {
                      //   await showDialog(
                      //       context: context,
                      //       builder: (ctx) =>
                      //       const SubAdminTypeAhead()).then((value) {
                      //     if (value != null) {
                      //       FirebaseFirestore.instance
                      //           .collection('users')
                      //           .doc(user['userId'])
                      //           .update({
                      //         'isAdmin': false,
                      //         'isSubAdmin': true,
                      //         'nagarNigamServices': value,
                      //       });
                      //     }
                      //   });
                      // } else {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user['userId'])
                            .update({
                          'isAdmin': index == 0 ? true : false,
                          // 'isSubAdmin': false,
                        });
                      },
                    // },
                    activeBgColors: const [
                      [Colors.blue],
                      // [Colors.orange],
                      [Colors.pink]
                    ],
                  )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetail extends StatefulWidget {
  final userId;
  final userCategories;

  const UserDetail({Key? key, this.userId, this.userCategories})
      : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  var userDetail = {};
  bool loaded = false;
  var userCategory = []; // User Category of Particular User
  var userCategories = []; //All User Categories

  void getUserDetails() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      userDetail = res.data() ?? {};
      setState(() {
        loaded = true;
        userCategory = ((userDetail['userCategories'] ?? []) as List);
      });
    } catch (e) {
      setState(() {
        loaded = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    userCategories = (widget.userCategories as List);
  }

  @override
  void dispose() {
    super.dispose();
    userCategories = [];
    userCategory = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: loaded ? null : 200,
      child: loaded
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('User Categories Present are'),
              Wrap(
                children: [
                  ...userCategory
                      .map((e) =>
                      InkWell(
                        onTap: () {
                          userCategory.remove(e);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            e,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                      .toList(),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 3,
                color: Colors.black,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('Tap to add User Category'),
              const SizedBox(
                height: 6,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search', border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      userCategories = (widget.userCategories as List)
                          .where((element) =>
                          element.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Wrap(
                children: [
                  ...userCategories
                      .map((e) =>
                      InkWell(
                          onTap: () {
                            if (!userCategory.contains(e)) {
                              userCategory.add(e);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              e,
                              style: GoogleFonts.openSans(
                                  color: Colors.white),
                            ),
                          )))
                      .toList(),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.userId)
                        .update({'userCategories': userCategory});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save')),
            ],
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class UserFilters extends StatefulWidget {
  final applyFilter;

  const UserFilters({Key? key, this.applyFilter}) : super(key: key);

  @override
  State<UserFilters> createState() => _UserFiltersState();
}

class _UserFiltersState extends State<UserFilters> {
  String field = '';
  String value = '';
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;
  final controller = TextEditingController();
  var sizedBox = const SizedBox(
    height: 4,
  );

  Widget makeWidget(title, field) {
    return InkWell(
      onTap: () {
        try {
          overlayEntry!.remove();
        } catch (e) {}
        setState(() {
          controller.text = title;
          this.field = field;
        });
      },
      child: Text(
        title.trimLeft(),
        style: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * 0.02,
            color: Colors.black),
      ),
    );
  }

  void _showOverlay(BuildContext context) async {
    //Declaring and Initializing OverlayState
    //and OverlayEntry objects
    overlayState = Overlay.of(context)!;
    overlayEntry = OverlayEntry(builder: (context) {
      //we can return any widget you like here
      //to be displayed on the Overlay
      return Positioned(
          right: MediaQuery
              .of(context)
              .size
              .width * 0.0,
          top: MediaQuery
              .of(context)
              .size
              .height * 0.0,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.6,
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Positioned(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.2,
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.0,
                    child: Material(
                      color: Colors.white.withOpacity(0.7),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              makeWidget('Name', 'name'),
                              sizedBox,
                              makeWidget('Email', 'email'),
                              sizedBox,
                              makeWidget('Phone Number', 'phoneNumber'),
                              sizedBox,
                              makeWidget('Age', 'age'),
                              sizedBox,
                              makeWidget('Address', 'address'),
                              sizedBox,
                              makeWidget('Gender', 'gender'),
                              sizedBox,
                            ],
                          )),
                    ))
              ],
            ),
          ));
    });

    //Inserting the OverlayEntry into the Overlay
    overlayState!.insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xffD5DADE),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Field',
                  hintStyle: GoogleFonts.openSans(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    field = value;
                  });
                },
                onTap: () {
                  _showOverlay(context);
                },
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffA69696)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Value',
                    hintStyle:
                    GoogleFonts.openSans(color: Colors.grey, fontSize: 14)),
                onChanged: (value) {
                  setState(() {
                    this.value = value;
                  });
                },
                onTap: () {
                  try {
                    overlayEntry!.remove();
                  } catch (e) {}
                },
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffA69696)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    //Remove the OverlayEntry from the Overlay
                    try {
                      overlayEntry!.remove();
                    } catch (e) {
                      print(e);
                    }
                    widget.applyFilter(field, value);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xff166FF6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    //Remove the OverlayEntry from the overlay
                    try {
                      overlayEntry!.remove();
                    } catch (e) {
                      print(e);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 248, 11, 82),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
