import 'package:flutter/material.dart';

class AppColors {
  static const Color textBlackColor = Color(0xFF000000);
  static const Color textWhiteColor = Color(0xFFfffffff);
  static const Color textGreyColor = Color(0xFFB2BEB5);
  static const Color primaryColor = Color(0xFF0e061f);
  static const Color secondaryColor = Color(0xFF151f2b);
  static const Color greenColor = Color(0xff15CA48);
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
      colors: [
         Color(0xFF32DAEB),
                                                      Color(0xFF6FFFBD)
      ]);
}
