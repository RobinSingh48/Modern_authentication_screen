import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:project_1/pages/login_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  void signOut()async{
     await FirebaseAuth.instance.signOut();
   GoogleSignInAccount? googleSignOut = await GoogleSignIn().signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

  }
  void googleSignOut()async{
    GoogleSignInAccount? googleSignOut = await GoogleSignIn().signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [GestureDetector(
          onTap: (){
           googleSignOut();
           signOut();
          },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.exit_to_app,color: Colors.black,size: 30,),
            ))],


      ),
      body: Center(
        child: Text("WELCOME TO HOME SCREEN"),
      ),
    );
  }
}
