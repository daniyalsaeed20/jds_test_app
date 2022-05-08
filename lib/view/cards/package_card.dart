// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/validators.dart';
import 'package:jds_test_app/view/widgets/custom_text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PackageCard extends StatelessWidget {
  PackageCard({
    required this.functionDeliveryAddress,
    required this.functionDescribePackage,
    required this.functionPickupAddress,
    required this.descriptionController,
    required this.pickupAddressController,
    required this.deliveryAddressController,
  });

  final void Function() functionDescribePackage;
  final void Function() functionPickupAddress;
  final void Function() functionDeliveryAddress;
  TextEditingController descriptionController;
  TextEditingController pickupAddressController;
  TextEditingController deliveryAddressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.packageVariantClosed, size: 90.r),
            SizedBox(
              width: 500.w,
              height: 100.h,
              child: CustomTextField(
                title: "Describe your package",
                controller: descriptionController,
                validator: CustomValidators().fieldValidator,
              ),
            ),
            InkWell(
                onTap: functionDescribePackage,
                child: Icon(Icons.keyboard_arrow_right, size: 60.r)),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 90.r),
            SizedBox(
              width: 500.w,
              height: 100.h,
              child: CustomTextField(
                title: "Pickup address",
                controller: pickupAddressController,
                validator: CustomValidators().fieldValidator,
              ),
            ),
            InkWell(
                onTap: functionPickupAddress,
                child: Icon(Icons.keyboard_arrow_down_rounded, size: 60.r)),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag, size: 90.r),
            SizedBox(
              width: 500.w,
              height: 100.h,
              child: CustomTextField(
                title: "Delivery address",
                controller: deliveryAddressController,
                validator: CustomValidators().fieldValidator,
              ),
            ),
            InkWell(
                onTap: functionDeliveryAddress,
                child: Icon(Icons.keyboard_arrow_down_rounded, size: 60.r)),
          ],
        ),
      ],
    );
  }
}
