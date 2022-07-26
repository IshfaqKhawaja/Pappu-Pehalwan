import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pappupehalwan/providers/load_data_from_facebook.dart';
import 'package:pappupehalwan/providers/user_details.dart';
import 'package:provider/provider.dart';
import '../widgets/admin__message_chat.dart';

class AdminMessages extends StatefulWidget {
  const AdminMessages({Key? key}) : super(key: key);

  @override
  State<AdminMessages> createState() => _AdminMessagesState();
}

class _AdminMessagesState extends State<AdminMessages> {
  String userId = '';
  String? value;
  String selectedCategory = '';
  String date = '';
  bool filtered = false;
  String nagarNigamServices = '';
  String name = '';

  void applyFilter(category, date, nagarNigamServices, name) {
    setState(() {
      selectedCategory = category ?? '';
      this.date = date ?? '';
      this.nagarNigamServices = nagarNigamServices ?? '';
      filtered = true;
      this.name = name ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  void messagesFilter(userDetails) {
    showDialog(
        context: context,
        builder: (ctx) => ShowDialogWidget(
          // This is defines below this class
              applyFilter: applyFilter,
          userDetails: userDetails,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Messages",
              style: GoogleFonts.openSans(
                textStyle: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if(userDetails['isAdmin'] ||
                userDetails.containsKey('isSubAdmin') &&
                    userDetails['isSubAdmin'])
            InkWell(
              onTap: () {
                messagesFilter(userDetails);
              },
              child: const Icon(Icons.filter_list),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('suggestions')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> userSnapShot) {
          if (userSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var docs = userSnapShot.data!.docs;
          if(userDetails.containsKey('isSubAdmin') &&
              userDetails['isSubAdmin'] &&
              userDetails.containsKey('nagarNigamServices')){
           docs.retainWhere((element) =>
           element['nagarNigamServices'] == userDetails['nagarNigamServices']);
          }

          if (filtered) {
            if (date != '' && nagarNigamServices != '' && name != '') {
              docs = docs.where((element) {
                try {
                  var t1 = element['createdAt'];
                  var t2 = element['nagarNigamServices'];
                  var t3 = element['username'];

                  return (element['createdAt'] as Timestamp)
                          .toDate()
                          .isAfter(DateTime.parse(date)) &&
                      element['nagarNigamServices'] == nagarNigamServices &&
                      element['username']
                          .toString()
                          .toLowerCase()
                          .contains(name.toLowerCase());
                } catch (e) {
                  return false;
                }
              }).toList();
            } else if (date != '' && nagarNigamServices != '') {
              docs = docs.where((element) {
                try {
                  var t1 = element['createdAt'];
                  var t2 = element['nagarNigamServices'];
                  return (element['createdAt'] as Timestamp)
                      .toDate()
                      .isAfter(DateTime.parse(date)) &&
                      element['nagarNigamServices'] == nagarNigamServices;
                } catch (e) {
                  return false;
                }
              }).toList();
            } else if (date != '' && name != ''){
              docs = docs.where((element) {
                try {
                  var t1 = element['createdAt'];
                  var t3 = element['username'];
                  return (element['createdAt'] as Timestamp)
                      .toDate()
                      .isAfter(DateTime.parse(date)) &&
                element['username']
                      .toString()
                      .toLowerCase()
                      .contains(name.toLowerCase());
                } catch (e) {
                  return false;
                }
              }).toList();
            }
            else if (nagarNigamServices != '' && name != '') {
              docs = docs.where((element) {
                try {
                  var t2 = element['nagarNigamServices'];
                  var t3 = element['username'];
                  return element['nagarNigamServices'] == nagarNigamServices && element['username']
                      .toString()
                    .toLowerCase()
                    .contains(name.toLowerCase());
                } catch (e) {
                  return false;
                }
              }).toList();
            } else if (date != ''){
              docs = docs.where((element) {
                try {
                  var t1 = element['createdAt'];
                  return (element['createdAt'] as Timestamp)
                      .toDate()
                      .isAfter(DateTime.parse(date));
                } catch (e) {
                  return false;
                }
              }).toList();
            }else if (nagarNigamServices != ''){
              docs = docs.where((element) {
                try{
                  var t2 = element['nagarNigamServices'];
                  return element['nagarNigamServices'] == nagarNigamServices;
                } catch (e) {
                  return false;
                }
              }).toList();
            } else if (name != '') {
              docs = docs.where((element) {
                try {
                  var t3 = element['username'];
                  return element['username']
                      .toString()
                      .toLowerCase()
                      .contains(name.toLowerCase());
                } catch (e) {
                  return false;
                }
              }).toList();
            }
          }

          if (docs.isEmpty) {
            return const Center(
              child: Text('No Chats Found'),
            );
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              final data = docs[index].data();
              return AdminMessageChat(
                datetime: data['createdAt'],
                phoneNumber: data['username'],
                recentText: '',
                unread: data['unread'],
                userid: docs[index].id,
                username: data['username'],
              );
            },
          );
        },
      ),
    );
  }
}

class ShowDialogWidget extends StatefulWidget {
  final applyFilter;
  final userDetails;

  const ShowDialogWidget({Key? key, this.applyFilter, this.userDetails}) : super(key: key);

  @override
  State<ShowDialogWidget> createState() => _ShowDialogWidgetState();
}

class _ShowDialogWidgetState extends State<ShowDialogWidget> {
  String? value;
  List<String> nagarNigamServicesList = ['सफाई', 'बिजली विभाग'];
  String selectedCategory = 'शिकायत';
  String date = '';
  String name = '';

  DropdownMenuItem<String> buildMenuItem(String nagarNigamServicesList) {
    return DropdownMenuItem(
        value: nagarNigamServicesList,
        child: Text(
          nagarNigamServicesList,
          style:
              GoogleFonts.openSans(fontWeight: FontWeight.w700, fontSize: 12),
        ));
  }

  @override
  void initState(){
    super.initState();
    List<String> temp = Provider.of<LoadDataFromFacebook>(context,listen: false).getNagarNigamServices;
    if(temp.isNotEmpty){
      nagarNigamServicesList = temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xffD5DADE),
      child: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
            // height: height * 0.35,
            width: width * 0.88,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 10
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffA69696)
                      )
                    ),
                    onChanged: (value) {
                      setState((){
                        name = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Pickup Date",style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700,fontSize: 12
                      ),),
                      IconButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025))
                              .then((date) {
                            setState(() {
                              this.date = date.toString();
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.date_range,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                if(widget.userDetails['isAdmin'])
                Container(
                  height: 41,
                  width: width * 0.88,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    alignment: Alignment.bottomRight,
                    menuMaxHeight: 300,
                    hint: Text(
                      "नगर निगम सुविधाएं",
                      style: GoogleFonts.openSans(
                          color: const Color(0xffA69696),
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    value: value,
                    isExpanded: true,
                    iconSize: 18,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xff8C8282),
                    ),
                    items: nagarNigamServicesList.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  )),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    widget.applyFilter(selectedCategory, date, value,name);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 94,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w500, fontSize: 12,
                        color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
