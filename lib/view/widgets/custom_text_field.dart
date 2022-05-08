// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jds_test_app/global/colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  bool obscureText;
  bool isEnabled;
  TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  Color textColor;
  Color titleColor;
  int maxLines;
  Color cursorColor;
  Color backgroundColorOne;
  Color backgroundColorTwo;

  CustomTextField({
    required this.title,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
    this.textColor = CustomColors.black,
    this.titleColor = CustomColors.whiteLight,
    this.isEnabled = true,
    this.maxLines = 1,
    this.cursorColor = CustomColors.green,
    this.backgroundColorOne = CustomColors.transparent,
    this.backgroundColorTwo = CustomColors.backGroundTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          validator: validator,
          style: TextStyle(
            color: textColor,
          ),
          enabled: isEnabled,
          onEditingComplete: () {},
          obscureText: obscureText,
          keyboardType: keyboardType,
          cursorColor: cursorColor,
          decoration: InputDecoration(
            fillColor: backgroundColorTwo.withOpacity(0.2),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(
            //     color: backgroundColorOne,
            //   ),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: backgroundColorOne,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: backgroundColorOne,
              ),
            ),
            filled: true,
            isDense: true,
            focusColor: textColor,
            hintText: title,
            hintStyle: TextStyle(
              color: titleColor,
            ),
          ),
        ),
      ],
    );
  }
}
