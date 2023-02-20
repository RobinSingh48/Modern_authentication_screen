



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custom_Icon_Button extends StatelessWidget {
  final String imageName;
  final Function()? ontap;
  Custom_Icon_Button({required this.imageName,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200]
        ),
        child: Image.asset(imageName),
        height: 70,
        width: 70,
      ),
    );
  }
}

