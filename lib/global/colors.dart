import 'package:flutter/material.dart';

class CustomColors {
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteDark = Color(0xFF5E5E5E);
  static const Color whiteLight = Color(0xFFA4A4A4);
  static const Color black = Color(0xFF000000);
  static const Color blackLight = Color(0xFF282828);
  static const Color greyButtonLight = Color(0xFFB9B9B9);
  static const Color greyButtonDark = Color(0xFF858585);
  static const Color greyLight = Color(0xFFECECEC);
  static const Color grey = Color(0xFF9B9B9B);
  static const Color greyDark = Color(0xFF787878);
  static const Color greenLight = Color(0xFF11FF45);
  static const Color green = Color.fromARGB(255, 102, 255, 47);
  static const Color blue = Color.fromARGB(255, 162, 223, 255);
  static const Color themeColor = Color.fromARGB(255, 0, 255, 149);
  static const Color blueDark = Color.fromARGB(255, 0, 100, 154);
  static const Color blueLight = Color(0xFF78EFFF);
  static const Color red = Color.fromARGB(255, 255, 0, 0);

  static const Color backGroundOne = Color(0xFF0A0A11);
  static const Color backGroundTwo = Color.fromARGB(255, 255, 128, 43);
  static const LinearGradient backGroundGradient = LinearGradient(
    colors: [
      backGroundOne,
      backGroundTwo,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color headerOne = Color(0xFF29302E);
  static const Color headerTwo = Color(0xFF122228);
  static const LinearGradient headerGradient = LinearGradient(
    colors: [
      headerOne,
      headerTwo,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  MaterialColor convertToMaterialColor(var string) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(136, 14, 79, .1),
      100: const Color.fromRGBO(136, 14, 79, .2),
      200: const Color.fromRGBO(136, 14, 79, .3),
      300: const Color.fromRGBO(136, 14, 79, .4),
      400: const Color.fromRGBO(136, 14, 79, .5),
      500: const Color.fromRGBO(136, 14, 79, .6),
      600: const Color.fromRGBO(136, 14, 79, .7),
      700: const Color.fromRGBO(136, 14, 79, .8),
      800: const Color.fromRGBO(136, 14, 79, .9),
      900: const Color.fromRGBO(136, 14, 79, 1),
    };
    MaterialColor colorCustom = MaterialColor(string, color);
    return colorCustom;
  }
}
