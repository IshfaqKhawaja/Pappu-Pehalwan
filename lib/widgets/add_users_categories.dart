import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUsersCategories extends StatefulWidget {
  const AddUsersCategories({Key? key}) : super(key: key);

  @override
  State<AddUsersCategories> createState() => _AddUsersCategoriesState();
}

class _AddUsersCategoriesState extends State<AddUsersCategories> {
  String value = '';
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('userCategories').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Add UserCategory',
                          ),
                          onChanged: (value) {
                            setState(() {
                              this.value = value;
                            });
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              if (value != '') {
                                FirebaseFirestore.instance
                                    .collection('userCategories')
                                    .add({'category': value});
                                setState(() {
                                  value = '';
                                  controller.text = '';
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 30,
                              semanticLabel: 'Add',
                            )),
                      ],
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(
                      data[index - 1]['category'],
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              String val = '';
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                  hintText: data[index - 1]
                                                      ['category']),
                                              onChanged: (v) {
                                                val = v;
                                              },
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'userCategories')
                                                      .doc(data[index - 1].id)
                                                      .update(
                                                          {'category': val});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Edit',
                                                  style: GoogleFonts.openSans(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('userCategories')
                                    .doc(data[index - 1].id)
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
