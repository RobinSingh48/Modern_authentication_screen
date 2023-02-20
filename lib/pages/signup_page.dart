
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_1/pages/login_page.dart';
import 'package:project_1/pages/mobile_auth.dart';
import 'package:project_1/pages/widgets/custom_icon_button.dart';
import 'package:project_1/pages/widgets/custom_widgets.dart';
import 'package:project_1/pages/widgets/my_custom%20widgets.dart';

import '../services/google_signin.dart';

class SignUp_Page extends StatefulWidget {

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController gmailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cpasswordController = TextEditingController();

  String email = "";

  String password = "";
  String cpassword = "";

  @override
  void dispose() {
    gmailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }




  void signUp()async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(password==cpassword){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Created Successfully'),backgroundColor: Colors.green,duration: Duration(seconds: 3),
          dismissDirection: DismissDirection.vertical,));
        gmailController.clear();
        passwordController.clear();
        cpasswordController.clear();
       Navigator.push(context, CupertinoPageRoute(builder: (context) => LoginScreen(),));
      }
    }on FirebaseAuthException catch(ex){
       print(ex.toString().toUpperCase());
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.toString().toUpperCase()),
         backgroundColor: Colors.red,duration: Duration(seconds: 3),
         dismissDirection: DismissDirection.vertical,elevation: 0,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/25),
                    child: Icon(Icons.lock,color: Colors.black,size: 50,),
                  ),

                  SizedBox(height: 30,),
                  Text("Let's Create an account for You",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.grey),),
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
                            helpText: 'Must contain upper, lower, special character',
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
                          SizedBox(height: 20,),
                          CustomTextField(secureText: true,
                              controller: cpasswordController,
                              hintText: 'Confirm Password',
                            validator: (value){
                            if(password != cpassword){
                              return "Password Not Matched";
                            }else if(value == null){
                              return 'Empty';
                            }else{
                              return null;
                            }
                            },
                          ),
                          SizedBox(height: 20,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            height: 60,
                            width: double.infinity,
                            child: My_CustomButton(text: "Sign UP",
                            onPress: (){
                              if(_key.currentState!.validate()){
                                setState(() {
                                  email = gmailController.text.trim();
                                  password = passwordController.text.trim();
                                  cpassword = cpasswordController.text.trim();
                                });
                                signUp();
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

                      }),
                      SizedBox(width: 40,),
                      Custom_Icon_Button(imageName: 'assets/otp.png',ontap: (){
                        GoogleSignInService().signInWithGoogle(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));
                      }),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

