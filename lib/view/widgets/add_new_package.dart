// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/colors.dart';
import 'package:jds_test_app/view/widgets/custom_text.dart';

class AddNewPackage extends StatelessWidget {
  AddNewPackage({
    required this.function,
  });

  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.w,
        horizontal: 50.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: function,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.black,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: CustomColors.white,
                  ),
                ),
                SizedBox(width: 20.w),
                CustomText(
                  text: "Add another",
                  color: CustomColors.grey,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
