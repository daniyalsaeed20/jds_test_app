// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/validators.dart';
import 'package:jds_test_app/view/widgets/custom_text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentMethodCard extends StatelessWidget {
  PaymentMethodCard({
    required this.function,
  });

  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.creditCard, size: 90.r),
            SizedBox(
              width: 500.w,
              height: 100.h,
              child: CustomTextField(
                title: "Select a payment method",
                controller: TextEditingController(),
                validator: CustomValidators().fieldValidator,
              ),
            ),
            InkWell(
                onTap: function,
                child: Icon(Icons.keyboard_arrow_down, size: 60.r)),
          ],
        ),
      ],
    );
  }
}
