// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/colors.dart';
import 'package:jds_test_app/view/widgets/custom_text.dart';

class SummaryDetails extends StatelessWidget {
  SummaryDetails({
    required this.index,
    required this.description,
    required this.price,
  });

  int index;
  int price;
  String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: "Package $index",
          color: CustomColors.black,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: CustomText(
            alignment: TextAlign.start,
            text: description,
            color: CustomColors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        CustomText(
          text: "\$$price",
          color: CustomColors.black,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
