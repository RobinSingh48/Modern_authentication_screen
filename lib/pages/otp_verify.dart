import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:project_1/pages/home_screen.dart';


class VerifyOTP extends StatefulWidget {
  String verificationId;
   VerifyOTP({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
   TextEditingController otpController = TextEditingController();

   var otpCode;

   void verifyOTP()async{
     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpCode);
    try{
     UserCredential usercredential = await FirebaseAuth.instance.signInWithCredential(credential);
     Navigator.popUntil(context, (route) => route.isFirst);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }on FirebaseException catch(ex){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toUpperCase().toString()),backgroundColor: Colors.red,));
     }

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/10),
                child: Icon(Icons.lock,color: Colors.black,size: MediaQuery.of(context).size.height/5,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              Text("Enter OTP",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              PinCodeTextField(
                maxLength: 6,
                controller: otpController,
                defaultBorderColor: Colors.grey.shade400,
                keyboardType: TextInputType.text,
                pinBoxHeight: MediaQuery.of(context).size.height/15,
                pinBoxWidth: MediaQuery.of(context).size.height/20,
                pinTextStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                errorBorderColor: Colors.red,

              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              GestureDetector(
                onTap: (){
                  if(otpController != null){
                    setState(() {
                      otpCode = otpController.text.trim();
                    });
                    verifyOTP();
                  }

                },
                child: Container(
                  height: MediaQuery.of(context).size.height/15,
                  width: MediaQuery.of(context).size.width/3.5,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                     borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Verify",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
