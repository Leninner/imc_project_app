

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget{
  CustomTextField({Key? key,
  required this.hintText,
  this.keyboardType,
  this.controller,

    sizeButton,
  }) : super(key: key);

  String? hintText;
  double? sizeButton;
  TextInputType? keyboardType;
  TextEditingController? controller;




  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Padding (
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: sizeButton ??5.00),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF2F2F3),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF2C2B47),
                fontSize: 16,
                fontFamily: 'FONTSPRING DEMO - Aftika Bold',
              fontWeight: FontWeight.bold)

            ),
          ),
        ),
      ],
    );
  }
  }
