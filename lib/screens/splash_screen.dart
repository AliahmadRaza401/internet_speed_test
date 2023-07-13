import 'dart:async';
import 'package:internet_speedtest_app/utility/app_Images.dart';
import 'package:internet_speedtest_app/utility/app_colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:internet_speedtest_app/screens/home_screen.dart';
import 'package:internet_speedtest_app/widgets/app_Routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        AppRoutes.pushAndRemoveUntil(
          context,
          PageTransitionType.leftToRightWithFade,
          HomeScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.Lineargradiebnt
            // image: DecorationImage(
            //   image: AssetImage(
            //     AppImages.backgroundImage,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage(
                  AppImages.spalshIcon,
                ),
                // fit: BoxFit.contain ,
              ),
            ),
            Text(
              'INTERNET',
              style: TextStyle(
                fontFamily: 'josefine Sans',
                fontSize: 36,
                color: AppColors.textWhiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'SPEED TEST',
              textAlign: TextAlign.left,
              style: TextStyle(
                // decoration: TextDecoration.underline,
                fontFamily: 'josefine Sans',
                fontSize: 24,
                color: AppColors.textWhiteColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'By AmigosDev',
                textAlign: TextAlign.left,
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  fontFamily: 'josefine Sans',
                  fontSize: 14,
                  color: AppColors.textWhiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
