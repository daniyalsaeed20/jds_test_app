// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jds_test_app/global/constant_variables.dart';
import 'package:jds_test_app/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ConstantVariables().designSize,
      builder: (_) => MaterialApp(
        title: "JDS",
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
