import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_1/pages/home_screen.dart';
import 'package:project_1/pages/login_page.dart';
import 'package:project_1/pages/mobile_auth.dart';
import 'package:project_1/pages/otp_verify.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    title: "Project 1",
    debugShowCheckedModeBanner: false,
    home:(FirebaseAuth.instance.currentUser!=null)?HomeScreen():LoginScreen(),
  ));
}




