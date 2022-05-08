// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/colors.dart';
import 'package:jds_test_app/view/widgets/custom_text.dart';

class SolidFillButton extends StatelessWidget {
  Color buttonColor;
  Color textColor;
  final void Function() function;
  double height;
  double fontSize;
  String text;
  FontWeight fontWeight;
  bool hasGradient;
  double radius;

  SolidFillButton({
    required this.text,
    required this.function,
    this.buttonColor = CustomColors.greyLight,
    this.height = 50,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.textColor = CustomColors.greyLight,
    this.hasGradient = false,
    this.radius = 50.0,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: hasGradient == false ? buttonColor : null,
                gradient: hasGradient == true
                    ? const LinearGradient(
                        colors: [CustomColors.greyLight, CustomColors.greyLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                borderRadius: BorderRadius.circular(
                  radius,
                ),
              ),
              height: height == 50 ? 50.h : height,
              // width: GET.WIDTH,
              child: Center(
                child: CustomText(
                  text: text,
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
