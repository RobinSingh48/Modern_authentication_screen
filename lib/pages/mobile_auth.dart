import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_1/pages/otp_verify.dart';
import 'package:project_1/pages/widgets/custom_icon_button.dart';
import 'package:project_1/pages/widgets/custom_widgets.dart';
import 'package:slider_button/slider_button.dart';

import '../services/google_signin.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();




  var mobileNo = "";

  void getOTP()async{
    await FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.code.toString().toUpperCase()),backgroundColor: Colors.redAccent,duration: Duration(seconds: 3),));
        },
        codeSent: (verificationId, forceResendingToken) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Send OTP"),backgroundColor: Colors.green,));
       Navigator.push(context, CupertinoPageRoute(builder: (context) => VerifyOTP(verificationId: verificationId),));
      }, codeAutoRetrievalTimeout: (verificationId) {},
    phoneNumber: mobileNo,);
  }

bool buttonValue = true;
  bool buttonValidation(){
  buttonValue =  mobileController.text.isNotEmpty?false:true;
  return buttonValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10),
                    child: Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 80,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 35),
                    child: Text(
                      "Let's Login By Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3.2,
                    width: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                        ),
                        Form(
                          key: key,
                          child: CustomTextField(
                            textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                            keyboardType: TextInputType.number,
                            maximum: 10,
                            controller: mobileController,
                            prefixIcon: Icon(Icons.call,color: Colors.grey,size: MediaQuery.of(context).size.height/25,),

                            hintText: 'Enter Mobile no',
                            secureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              if (value.length != 10) {
                                return 'Phone number should be 10 digits long';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Not Valid Number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/20,),
                        SliderButton(
                          action: () {
                            if(key.currentState!.validate()){
                                setState(() {
                                  mobileNo = '+91'+mobileController.text.trim();
                                });
                                getOTP();

                            }
                          },
                          label: buttonValidation()?Text("Enter Number To Active Button",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold,fontSize: 16),):Text(
                            "Slide to get OTP",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          icon: Icon(Icons.phone,
                            size: MediaQuery.of(context).size.height/20,
                          ),
                          buttonColor: Colors.black12,
                          highlightedColor: Colors.white,
                          disable: buttonValidation(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Or Continue With"),
                        ),
                        Expanded(
                          child: Divider(

                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  Custom_Icon_Button(imageName: 'assets/google_logo.png',ontap: (){
                    GoogleSignInService().signInWithGoogle(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
