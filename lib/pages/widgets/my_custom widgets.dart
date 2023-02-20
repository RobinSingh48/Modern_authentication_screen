//Signin Button

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class My_CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPress;
  My_CustomButton({
   required this.text,
    required this.onPress
  }) ;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(Colors.black),
        ),
        onPressed: onPress,
        child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),));
  }
}
