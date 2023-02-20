import 'package:flutter/material.dart';

 class CustomTextField extends StatelessWidget {
   final Widget? prefixIcon;
   final String? prefixText;
   final controller;
   final int? minimumLine;
   final int? maximum;
   final TextStyle? textStyle;
   final String hintText;
   final bool secureText;
   final String? helpText;
   final String? Function(String?)? validator;
   final TextInputType? keyboardType;
    CustomTextField({required this.secureText,
      required this.controller,
      required this.hintText,
    this.validator,
    this.helpText,
    this.keyboardType,
    this.textStyle,
    this.maximum,
    this.minimumLine,
    this.prefixIcon,
    this.prefixText}) ;

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding:  EdgeInsets.symmetric(horizontal: 25),
       child: TextFormField(
         maxLength: maximum,
         keyboardType: keyboardType,
         style: textStyle,
         autovalidateMode: AutovalidateMode.values.last,
         controller: controller,
         obscureText: secureText,
         decoration: InputDecoration(
           counterText: "",
           helperText: helpText,
           filled: true,
             fillColor: Colors.grey.shade200,
           hintText: hintText,
           prefixIcon: prefixIcon,
           prefixText: prefixText,
           errorStyle: TextStyle(
             color: Colors.redAccent,
             fontWeight: FontWeight.bold
           ),
           hintStyle: TextStyle(
             fontWeight: FontWeight.bold,
             color: Colors.grey
           ),
           enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(
               color: Colors.grey
             ),

           ),
           focusedBorder:  OutlineInputBorder(
             borderSide: BorderSide(
               color: Colors.grey
             ),
           )
         ),
         validator: validator,
       ),
     );
   }
 }
