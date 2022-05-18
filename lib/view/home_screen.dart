// ignore_for_file: use_key_in_widget_constructors, body_might_complete_normally_nullable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/controller/package_bloc/bloc/package_bloc.dart';
import 'package:jds_test_app/controller/payment_bloc/bloc/payment_bloc.dart';
// import 'package:jds_test_app/controller/package_controller/package_bloc.dart';
// import 'package:jds_test_app/controller/package_controller/package_event.dart';
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PackageBloc(),
        ),
        BlocProvider(
          create: (context) => PaymentBloc(),
        ),
      ],
      child: SlidingUpPanel(
        maxHeight: 1500.h,
        minHeight: 150.h,
        parallaxEnabled: true,
        parallaxOffset: .5,
        body: const PackageBlocWidget(),
        panelBuilder: (_) {
          return const PaymentBlocWidget();
        },
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r)),
      ),
    );
  }
}

class PackageBlocWidget extends StatelessWidget {
  const PackageBlocWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              BlocBuilder<PackageBloc, PackageState>(
                builder: (BuildContext context, PackageState state) {
                  return Column(
                    children: [
                      for (int i = 0; i < state.packageCounter; i++)
                        Column(
                          children: [
                            if (state.packageCounter > 1)
                              RemovePackage(
                                function: () {
                                  context.read<PackageBloc>().add(
                                        PackageIncrementEvent(
                                          status: PackageStatus.decrement,
                                          index: i,
                                          read: context.read,
                                        ),
                                      );
                                },
                              ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: PackageCard(
                                onTextEdited: (value) {
                                  context.read<PackageBloc>().add(
                                        PackageEditingEvent(
                                          status: PackageStatus.onEdit,
                                          read: context.read,
                                        ),
                                      );
                                },
                                deliveryAddressController:
                                    state.packageDeliveryAddressController[i],
                                descriptionController:
                                    state.packageDescriptionController[i],
                                pickupAddressController:
                                    state.packagePickUpAddressController[i],
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
                      AddNewPackage(function: () {
                        context.read<PackageBloc>().add(
                              PackageIncrementEvent(
                                status: PackageStatus.increment,
                              ),
                            );
                      }),
                      SizedBox(height: 150.h),
                    ],
                  );
                },
              ),

              /* --------------------------- add package button --------------------------- */
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentBlocWidget extends StatelessWidget {
  const PaymentBlocWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state.status == PaymentStatus.payNowResponse) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                dismissDirection: DismissDirection.endToStart,
                duration: const Duration(seconds: 3),
                backgroundColor: CustomColors.backGroundTwo,
                content: SizedBox(
                  height: 150.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: state.heading,
                        fontSize: 36.sp,
                        color: CustomColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: state.message + state.code,
                        fontSize: 28.sp,
                        color: CustomColors.white,
                        maxLines: 3,
                        alignment: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            );
            context.read<PaymentBloc>().add(
                  PaymentResetEvent(
                    status: PaymentStatus.unknown,
                  ),
                );
            context.read<PackageBloc>().add(
                  PackageResetEvent(
                    status: PackageStatus.unknown,
                  ),
                );
          }
        },
        child: Container(
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
                        child: BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (BuildContext context, PaymentState state) {
                            /* ------------------------------ summary list ------------------------------ */
                            return Column(
                              children: [
                                for (int i = 0; i < state.paymentCounter; i++)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50.w),
                                    child: Column(
                                      children: [
                                        SummaryDetails(
                                          index: i + 1,
                                          description:
                                              state.packages[i].description,
                                          price: state.prices[i],
                                        ),
                                        Divider(
                                          thickness:
                                              i == state.paymentCounter - 1
                                                  ? 1.r
                                                  : 3.r,
                                          color: i == state.paymentCounter - 1
                                              ? CustomColors.black
                                              : CustomColors.greyDark,
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.w),
                                  child: TotalCostCard(
                                    index: 1,
                                    total: state.totalPayment.toString(),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
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
                            context.read<PaymentBloc>().add(
                                  PayNowEvent(
                                    status: PaymentStatus.payNow,
                                    packages: const [],
                                    read: context.read<PaymentBloc>(),
                                  ),
                                );
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
      ),
    );
  }
}
