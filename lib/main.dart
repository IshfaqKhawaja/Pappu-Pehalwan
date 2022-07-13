import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

void main() async  {
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
  statusBarColor: Color(0xFF56514D), //or set color with: Color(0xFF0000FF)
));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const Home(),
  );
}
