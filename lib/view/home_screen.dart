// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/controller/package_controller/package_bloc.dart';
import 'package:jds_test_app/controller/package_controller/package_event.dart';
import 'package:jds_test_app/controller/package_controller/payment_event.dart';
import 'package:jds_test_app/global/colors.dart';
import 'package:jds_test_app/global/constant_variables.dart';
import 'package:jds_test_app/global/generic_functions.dart';
import 'package:jds_test_app/view/cards/package_card.dart';
import 'package:jds_test_app/view/cards/payment_method_card.dart';
import 'package:jds_test_app/view/cards/summary_details.dart';
import 'package:jds_test_app/view/cards/total_cost_card.dart';
import 'package:jds_test_app/view/widgets/add_new_package.dart';
import 'package:jds_test_app/view/widgets/custom_text.dart';
import 'package:jds_test_app/view/widgets/remove_package.dart';
import 'package:jds_test_app/view/widgets/solid_fill_button.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _packageBlocController = PackageBloc();

  @override
  void dispose() {
    _packageBlocController.dispose();
    super.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: 1500.h,
      minHeight: 150.h,
      parallaxEnabled: true,
      parallaxOffset: .5,
      body: SafeArea(
        child: Scaffold(
          /* -------------------------------------------------------------------------- */
          /*                                   App Bar                                  */
          /* -------------------------------------------------------------------------- */
          appBar: ScrollAppBar(
            backgroundColor: CustomColors.white,
            elevation: 0,
            controller: ConstantVariables.homeScrollController,
            title: CustomText(
              text: "Order",
              color: CustomColors.black,
              fontSize: 50.sp,
              fontWeight: FontWeight.bold,
            ),
            automaticallyImplyLeading: false,
            leading: InkWell(
                onTap: () {
                  GenericFunctions().toast();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: CustomColors.black,
                  size: 60.r,
                )),
          ),
          backgroundColor: CustomColors.white,
          body: SingleChildScrollView(
            controller: ConstantVariables.homeScrollController,
            child: Column(
              children: [
                /* --------------------------------- Heading -------------------------------- */
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
                    vertical: 30.h,
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Package",
                        color: CustomColors.black,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                /* -------------------------------------------------------------------------- */
                /*                             Delivery Order List                            */
                /* -------------------------------------------------------------------------- */
                StreamBuilder(
                    stream: _packageBlocController.outPackageCounter,
                    initialData: 1,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Column(
                        children: [
                          for (int i = 0; i < snapshot.data!; i++)
                            Column(
                              children: [
                                if (i != 0)
                                  RemovePackage(
                                    function: () {
                                      _packageBlocController.selectedIndex = i;
                                      _packageBlocController
                                          .packageCounterEventSink
                                          .add(RemoveEvent());
                                      _packageBlocController.paymentEventSink
                                          .add(RemovePaymentEvent());
                                    },
                                  ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: PackageCard(
                                    deliveryAddressController:
                                        _packageBlocController
                                            .packageDeliveryAddressController[i],
                                    descriptionController:
                                        _packageBlocController
                                            .packageDescriptionController[i],
                                    pickupAddressController:
                                        _packageBlocController
                                            .packagePickUpAddressController[i],
                                    functionDeliveryAddress: () {
                                      GenericFunctions().toast();
                                    },
                                    functionDescribePackage: () {
                                      GenericFunctions().toast();
                                    },
                                    functionPickupAddress: () {
                                      GenericFunctions().toast();
                                    },
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
                    }),
                /* --------------------------- add package button --------------------------- */
                AddNewPackage(function: () {
                  _packageBlocController.packageCounterEventSink
                      .add(AddEvent());
                  _packageBlocController.paymentEventSink
                      .add(AddPaymentEvent());
                }),
                SizedBox(height: 150.h),
              ],
            ),
          ),
        ),
      ),
      panelBuilder: (_) {
        return Scaffold(
          body: Container(
            color: CustomColors.white,
            // height: 00.h,
            child: Column(
              children: [
                /* --------------------------------- heading -------------------------------- */
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
                    vertical: 50.h,
                  ),
                  child: CustomText(
                    text: "Payment method",
                    color: CustomColors.black,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /* -------------------------- select payment method ------------------------- */
                PaymentMethodCard(
                  function: () {
                    GenericFunctions().toast();
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
                /* ------------------------------ summary card ------------------------------ */
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.green.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.r),
                        topRight: Radius.circular(45.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 20.h),
                          child: CustomText(
                            text: "Summary",
                            color: CustomColors.black,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          // height: 250.h,
                          child: StreamBuilder(
                              stream: _packageBlocController.outPayment,
                              initialData: 1,
                              builder: (BuildContext context,
                                  AsyncSnapshot<int> snapshot) {
                                /* ------------------------------ summary list ------------------------------ */
                                return Column(
                                  children: [
                                    for (int i = 0; i < snapshot.data!; i++)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        child: Column(
                                          children: [
                                            SummaryDetails(
                                              index: i + 1,
                                              description: _packageBlocController
                                                  .packageDescriptionController[
                                                      i]
                                                  .text,
                                              price: _packageBlocController
                                                  .prices[i],
                                            ),
                                            Divider(
                                              thickness: i == snapshot.data!
                                                  ? snapshot.data!.r
                                                  : 3.r,
                                              color: i == snapshot.data!
                                                  ? CustomColors.black
                                                  : CustomColors.greyDark,
                                            ),
                                          ],
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      child: TotalCostCard(
                                        index: 1,
                                        total: _packageBlocController
                                            .totalPayment
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.w,
                          ),
                          /* ------------------------------- pay button ------------------------------- */
                          child: SolidFillButton(
                            text: "Place Order",
                            function: () {
                              _packageBlocController.payNow();
                              setState(() {});
                            },
                            buttonColor: CustomColors.black,
                            height: 100.h,
                            radius: 15.r,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r)),
    );
  }
}
