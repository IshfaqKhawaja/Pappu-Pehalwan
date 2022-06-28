import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserDetails with ChangeNotifier {
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get getUserDetails => userDetails;
  void loadUserDetails() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var res = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var data = res.data()!;
    userDetails['email'] = data['email'];
    userDetails['isAdmin']  =data['isAdmin'];
    userDetails['name']  =data['name'];
    userDetails['phoneNumber'] = data['phoneNumber'];
    userDetails['userId']  = userId;
    notifyListeners();    
  }
}
