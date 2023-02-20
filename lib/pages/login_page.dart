

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/pages/mobile_auth.dart';
import 'package:project_1/pages/signup_page.dart';
import 'package:project_1/pages/widgets/custom_icon_button.dart';
import 'package:project_1/pages/widgets/custom_widgets.dart';
import 'package:project_1/pages/widgets/my_custom%20widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_1/services/google_signin.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 GlobalKey<FormState> _key = GlobalKey<FormState>();

 String email = '';
  String password = '';

  @override
  void dispose() {
    gmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }





  //signin Function
 void signIn()async{
try{
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  if(userCredential.user != null){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User login Successfully'),backgroundColor: Colors.green,duration: Duration(seconds: 3),
      dismissDirection: DismissDirection.vertical,));
    gmailController.clear();
    passwordController.clear();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  }
}on FirebaseAuthException catch (ex){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.toString().toUpperCase()), backgroundColor: Colors.red,duration: Duration(seconds: 3),
    dismissDirection: DismissDirection.vertical,elevation: 0,));
}
}



  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeigh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Icon(Icons.lock,color: Colors.black,size: 80,),
                  SizedBox(height: 60,),
                  Text("Welcome To Login Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.grey),),
                  Form(
                    key: _key,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          CustomTextField(secureText: false,
                              controller: gmailController,
                              hintText: 'Email',
                            validator: (value) {
                             if(value == null){
                               return "Empty Field";
                             }
                              else if (RegExp(
                                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                 .hasMatch(value!)){
                               return null;
                             }
                             else{
                               return "Invalid format";
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          CustomTextField(secureText: true,
                              controller: passwordController,
                              hintText: 'Password',
                            validator: (value) {
                              if(value!.isEmpty ){
                                return "Empty Field";
                              }else if(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                                return null;
                              }else{
                                return " Invalid Format";
                              }
                            },
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){},
                                  child: Text("Forget Password?",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold
                                  ,fontSize: 20),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            height: 60,
                            width: double.infinity,
                            child: My_CustomButton(text: "Sign In",
                            onPress: (){
                              if(_key.currentState!.validate()){
                                setState(() {
                                  email = gmailController.text.trim();
                                  password = passwordController.text.trim();
                                });
                                signIn();
                              }
                            }),
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
                          )
                        ],
                      )),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Custom_Icon_Button(imageName: 'assets/google_logo.png',ontap: (){
                       GoogleSignInService().signInWithGoogle(context);
                      }),
                      SizedBox(width: 40,),
                      Custom_Icon_Button(imageName: 'assets/otp.png',ontap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => OtpScreen(),));
                      }),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),),
                      TextButton(onPressed: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => SignUp_Page(),));
                      }, child: Text('Register now',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
