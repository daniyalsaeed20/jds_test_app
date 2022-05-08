// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/colors.dart';

class RemovePackage extends StatelessWidget {
  RemovePackage({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Divider(
            color: CustomColors.blackLight,
            thickness: 3.h,
          ),
          InkWell(
            onTap: function,
            child: Container(
              color: CustomColors.red,
              child: const Icon(
                Icons.close,
                color: CustomColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
