import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pappupehalwan/providers/user_details.dart';
import 'package:provider/provider.dart';
import '../widgets/yogana_container.dart';
import '../constant.dart';
class StatesPlans extends StatefulWidget {
  final type;
  const StatesPlans({Key? key, this.type,}) : super(key: key);

  @override
  State<StatesPlans> createState() => _StatesPlansState();
}

class _StatesPlansState extends State<StatesPlans> {
  String type = 'state';
  Map userDetails = {};
  bool isLoading  = false;
  @override
  void initState(){
    super.initState();
    type = widget.type == 0 ? 'state' : 'national';
    userDetails = Provider.of<UserDetails>(context, listen : false).getUserDetails;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('yogana').where('type',isEqualTo:type).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        final docs = snapshots.data!.docs;
        if(docs.isEmpty){
          return const Center(child: Text('No Data '),);
        }
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    YoganaContainer(
                      title: docs[index]['title'],
                      description: docs[index]['description'],
                      url: docs[index]['url'],


                    )));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 65,
                color: const Color(0xffD9D9D9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    if(docs[index]['url'] != '')
                      Container(
                        width: 120,
                          child: Image.network(docs[index]['url'])),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(docs[index]['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                              fontSize: 14
                            ),
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(
                                docs[index]['description'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: plansContentTextStyle,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if(userDetails['isAdmin'])

                    IconButton(onPressed: () async{
                      setState((){
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(milliseconds: 1000));
                      try {
                        if (docs[index]['url'] != '') {
                          await FirebaseStorage.instance.refFromURL(
                              docs[index]['url']).delete();
                        }
                        await FirebaseFirestore.instance.collection('yogana')
                            .doc(docs[index].id)
                            .delete();
                        Fluttertoast.showToast(msg: 'Deleted Successfully');
                        setState((){
                          isLoading = false;
                        });
                      }
                      catch(e){
                        print(e);
                        setState((){
                          isLoading = false;
                        });
                      }

                    }, icon: isLoading ?
                    Container(
                        height: 20,
                        width: 20,
                        child: const CircularProgressIndicator())
                        :const Icon(Icons.delete, color: Colors.red,),),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
