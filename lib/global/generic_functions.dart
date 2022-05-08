import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jds_test_app/global/colors.dart';

class GenericFunctions {

  toast({String text = "Not Provided"}) {
    return Fluttertoast.showToast(
      msg: text,
      fontSize: 24.sp,
      toastLength: Toast.LENGTH_SHORT,
      textColor: CustomColors.white,
      backgroundColor: CustomColors.backGroundTwo,
      gravity: ToastGravity.BOTTOM,
    );
  }

}
