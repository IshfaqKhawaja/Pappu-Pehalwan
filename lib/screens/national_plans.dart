import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constant.dart';
import '../widgets/yogana_container.dart';
class NationalPlans extends StatefulWidget {
  const NationalPlans({Key? key}) : super(key: key);

  @override
  State<NationalPlans> createState() => _NationalPlansState();
}

class _NationalPlansState extends State<NationalPlans> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('yogana').where('type',isEqualTo:'national').snapshots(),
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
                        Image.network(docs[index]['url']),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(docs[index]['title']),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                docs[index]['description'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: plansContentTextStyle,),
                              const SizedBox(
                                width: 4,
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.arrow_forward_ios, size: 20,
                                    color: Color(0xff146AA7),),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            if(docs[index]['url'] != ''){
                              await FirebaseStorage.instance.refFromURL(docs[index]['url']).delete();
                            }
                            await FirebaseFirestore.instance.collection('yogana').doc(docs[index].id).delete();
                            Fluttertoast.showToast(msg: 'Deleted Successfully');
                          },
                          icon: const Icon(Icons.delete,color: Colors.red,)
                      )
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
