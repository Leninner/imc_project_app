

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget{
  CustomButton({Key? key,
    required this.onTap,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
    this.borderRadiusButton,
    this.verticalSizeButton,
    this.horizontalMarginButton,
    this.fontSizeButton,
  }) : super(key: key);

  VoidCallback onTap;
  String buttonText;
  Color? buttonColor;
  Color? textColor;
  double? borderRadiusButton;
  double? verticalSizeButton;
  double? horizontalMarginButton;
  double? fontSizeButton;



  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMarginButton ?? 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusButton ?? 0),
        color:buttonColor ?? Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalSizeButton ?? 0),
            child: Center(
              child: Text(
                buttonText ?? 'Boton',
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontFamily: 'FONTSPRING DEMO - Aftika Bold',
                  fontSize: fontSizeButton ?? 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}