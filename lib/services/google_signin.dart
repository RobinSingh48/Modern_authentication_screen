
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/home_screen.dart';

class GoogleSignInService {

  signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser!=null){
      try{
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }on FirebaseAuthException catch(ex){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.toString().toUpperCase()), backgroundColor: Colors.red,duration: Duration(seconds: 3),
          dismissDirection: DismissDirection.vertical,elevation: 0,));
      }
    }

    // Obtain the auth details from the request


    // Create a new credential

    // Once signed in, return the UserCredential


  }
}
