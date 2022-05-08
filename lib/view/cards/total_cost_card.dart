// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/colors.dart';
import 'package:jds_test_app/view/widgets/custom_text.dart';

class TotalCostCard extends StatelessWidget {
  TotalCostCard({
    required this.index,
    required this.total,
  });

  int index;
  String total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            CustomText(
              text: "Total",
              color: CustomColors.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: 20.w,
            ),
            CustomText(
              alignment: TextAlign.start,
              text: '\$$total',
              color: CustomColors.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
