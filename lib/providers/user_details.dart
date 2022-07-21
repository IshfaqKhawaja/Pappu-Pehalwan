import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserDetails with ChangeNotifier {
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get getUserDetails => userDetails;
  Future<void> loadUserDetails() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var res =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var data = res.data()!;
    userDetails = data;
    notifyListeners();
  }
}
