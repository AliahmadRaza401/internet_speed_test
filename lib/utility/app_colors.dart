import 'package:flutter/material.dart';

class AppColors {
  static const Color textBlackColor = Color(0xFF000000);
  static const Color textWhiteColor = Color(0xFFfffffff);
  static const Color textGreyColor = Color(0xFFB2BEB5);
  static const Color primaryColor = Color(0xFF0e061f);
  static const Color secondaryColor = Color(0xFF151f2b);
  static const Color greenColor = Color(0xff15CA48);
    static const Color p1Color = Color(0xFF32DAEB);
        static const Color p2Color = Color(0xFF6FFFBD);
  static const Color s1Color = Color(0xFF7e56d6);
        static const Color s2Color = Color(0xFFee71f6);
     static const Color lightBG       = Color.fromARGB(80, 35, 47, 78);
          static const Color lightBGMeter       = Color.fromARGB(80, 35, 47, 78);

  static Gradient Lineargradiebnt = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        secondaryColor,
        primaryColor,
      ]);
  static Gradient btngradiebnt = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [p1Color, p2Color]);
}
