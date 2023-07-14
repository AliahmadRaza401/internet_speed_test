import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_speedtest_app/utility/app_colors.dart';
import 'package:internet_speedtest_app/widgets/custom_text_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckUpdateService {
  void versionCheck(context) async {
    await FirebaseFirestore.instance
        .collection("internetSpeedTest")
        .doc("build")
        .snapshots()
        .listen((value) async {
      int lastVer;

      lastVer = int.parse(value['build_number'].toString());

      print("doc android version: ${value['build_number']} ");

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var versionCode = packageInfo.buildNumber;
      print(lastVer.toString() +
          "----------------  App version ---------" +
          versionCode.toString());
      if (lastVer > int.parse(versionCode)) {
        updateDialog(context);
      }
    });
  }

  updateDialog(context) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, 'Cancel');
          return Future.value(false);
        },
        child: AlertDialog(
          // title: Text(DemoLocalization.of(context).translate(StringKeys.updateT)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: text(
                      text: 'New Update in availalbe',
                      size: 18.sp,
                      boldText: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: 'popinsregular',
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 20),
                    child: Text(
                      'There is an update available for this app',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'popinsregular',
                      ),
                      textAlign: TextAlign.center,
                    ),

                    //  text(
                    //   text: 'There is an update available for this app',
                    // size: 20.sp,
                    // boldText: FontWeight.w400,
                    // color: Colors.black,
                    // fontFamily: 'popinsregular',
                    // ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                        height: 40.h,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.p1Color,
                                  AppColors.p2Color,
                                  // const Color(0xff13B89B),
                                  // const Color(0xff29ABE2)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  onSurface: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0 // foreground
                                  ),
                              onPressed: () {
                                _launchURL(context);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: text(
                                    text: 'UPDATE ',
                                    size: 16.sp,
                                    boldText: FontWeight.w900,
                                    color: AppColors.primaryColor,
                                    fontFamily: 'popinsregular',
                                  )),
                            ))),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: text(
                            text: 'NOT NOW',
                            size: 16.sp,
                            boldText: FontWeight.w800,
                            color: AppColors.p1Color,
                            fontFamily: 'popinsregular',
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(context) async {
    String url =
        "https://play.google.com/store/apps/details?id=com.alchemative.outfitters.pk";

    if (await canLaunch(url)) {
      await launch(url);
      Navigator.of(context, rootNavigator: false).pop('dialog');
    } else {
      throw 'Could not launch $url';
    }
  }
}
