import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/user_details.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Users extends StatelessWidget {
  const Users({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final users = snapshot.data!.docs;
        if(users.isEmpty){
          return  Center(
            child: Text('No users found',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),            
            ),
          );
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, index) {
            final user = users[index].data()! as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: ListTile(
                title: Text(user['name'] != '' ? user['name'].toString().toUpperCase() : user['phoneNumber'],
                style : GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
                
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(user['phoneNumber'], style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 12,
                    
                    ),),
                    Text(user['email'], style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 12,
                    
                    ),),
                     
                  ],
                ),
                trailing: userDetails['isAdmin'] == true ?
                ToggleSwitch(
                          minWidth: 60.0,
                          initialLabelIndex: user['isAdmin'] == true ? 0 : 1,
                          cornerRadius: 10.0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          labels:const  ['Admin', 'User'],
                          customTextStyles: const [
                            TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ],


                         
                          onToggle: (index) {
                            FirebaseFirestore.instance.collection('users').doc(user['userId']).update({
                              'isAdmin': index == 0 ? true : false,
                            });
                          },
                          activeBgColors: const [[Colors.blue],[Colors.pink]],

                          
                        )

                 : null ,
              ),
            );
          },
        );
      },
    );
  }
}