import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:internet_speedtest_app/provider/home_provider.dart';
import 'package:internet_speedtest_app/provider/internet_connection_provider.dart';
import 'package:internet_speedtest_app/provider/phone_provider.dart';
import 'package:internet_speedtest_app/provider/wifi_provider.dart';
import 'package:internet_speedtest_app/utility/app_colors.dart';
import 'package:internet_speedtest_app/widgets/custom_app_bar.dart';
import 'package:internet_speedtest_app/widgets/custom_text_widget.dart';
import 'package:internet_speedtest_app/widgets/divider.dart';
import 'package:provider/provider.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PhoneProvider>(context, listen: false).readAndroidBuildData();
    Provider.of<WifiProvider>(context, listen: false).initNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    InternetConnectionProvider internetConnectionProvider =
        Provider.of<InternetConnectionProvider>(context, listen: true);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    PhoneProvider phoneProvider =
        Provider.of<PhoneProvider>(context, listen: true);
    WifiProvider wifiProvider =
        Provider.of<WifiProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // bottomNavigationBar: AdsServices.displayBannerAd(),
      appBar: CustomeAppBar(titleTxt: 'SpeedTest', appAlignment: true),
      // extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.Lineargradiebnt,
          // image: DecorationImage(
          //   image: AssetImage(
          //     AppImages.backgroundImage,
          //   ),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: internetConnectionProvider.internetConnection
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<HomeProvider>(
                    builder: (context, homepro, child) {
                      return Expanded(
                        child: Container(
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              homepro.homeState == 0
                                  ? InkWell(
                                      onTap: () {
                                        homeProvider.checkInterSpeed();
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: Center(
                                          child: RippleWave(
                                            color: AppColors.lightBGMeter,
                                            duration: Duration(seconds: 3),
                                            childTween: Tween(begin: 1, end: 1),
                                            repeat: true,
                                            child: Container(
                                              height: 240.h,
                                              width: 240.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  width: 5.r,
                                                  color:
                                                      AppColors.textWhiteColor,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                ),
                                                child: Text(
                                                  "START",
                                                  style: TextStyle(
                                                    fontSize: 40.sp,
                                                    color: AppColors
                                                        .textWhiteColor,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: 'popinsbold',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          infoDisplay(
                                              wifiProvider.wifiIPv4,
                                              phoneProvider.model,
                                              internetConnectionProvider
                                                  .isWifi),
                                          meter(homeProvider),
                                          ratesDisplay(homeProvider),
                                          homepro.homeState == 3
                                              ? testAgainBtn(homepro)
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Center(child: AdsServices.displayNativeMRECAd()),
                ],
              )
            : Center(
                child: Text('Internet Available'),
                //
              ),
      ),
    );
  }

  Widget infoDisplay(wifiIPv4, model, bool isWifi) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
          color: AppColors.lightBG, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  text: 'IP address',
                  size: 12.sp,
                  boldText: FontWeight.w400,
                  color: Color(0xff7c808b),
                  fontFamily: 'popinsregular',
                ),
                text(
                  text: '${wifiIPv4}',
                  size: 15.sp,
                  boldText: FontWeight.w400,
                  color: AppColors.textWhiteColor,
                  fontFamily: 'popinsregular',
                )
              ],
            ),
          )),
          divider(height: 30.0),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  text: 'Model',
                  size: 12.sp,
                  boldText: FontWeight.w400,
                  color: Color(0xff7c808b),
                  fontFamily: 'popinsregular',
                ),
                text(
                  text: '${model}',
                  size: 15.sp,
                  boldText: FontWeight.w400,
                  color: AppColors.textWhiteColor,
                  fontFamily: 'popinsregular',
                )
              ],
            ),
          )),
          divider(height: 30.0),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  text: 'Internet Source',
                  size: 12.sp,
                  boldText: FontWeight.w400,
                  color: Color(0xff7c808b),
                  fontFamily: 'popinsregular',
                ),
                text(
                  text: isWifi ? 'Wifi' : 'Mobile Data',
                  size: 15.sp,
                  boldText: FontWeight.w400,
                  color: AppColors.textWhiteColor,
                  fontFamily: 'popinsregular',
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget meter(HomeProvider homeProvider) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 4500,
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 50,
            labelOffset: 30,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor,
              thickness: 0.1,
              // cornerStyle:
              //     CornerStyle.bothCurve,
              // dashArray: <double>[5, 5],
              color: AppColors.lightBGMeter,
              // gradient: const SweepGradient(
              //     colors: <Color>[
              //       Color(0xFFFF7676),
              //       Color(0xFFF54EA2),
              //     ],
              //     stops: <double>[
              //       0.25,
              //       0.75
              //     ]),
            ),
            majorTickStyle: MajorTickStyle(
              length: 6,
              thickness: 4,
              color: Colors.red,
            ),
            minorTickStyle: MinorTickStyle(
              length: 3,
              thickness: 3,
              color: Colors.green,
            ),
            axisLabelStyle: GaugeTextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 50,
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.03,
                endWidth: 0.03,
                color: Colors.transparent,
              ),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                value: homeProvider.transferRate,
                width: 0.1,
                sizeUnit: GaugeSizeUnit.factor,
                // cornerStyle:
                //     CornerStyle.bothCurve,
                gradient: SweepGradient(
                    colors: homeProvider.testDownloadType
                        ? <Color>[
                            AppColors.s1Color,
                            AppColors.s2Color,
                          ]
                        : <Color>[
                            AppColors.p1Color,
                            AppColors.p2Color,
                          ],
                    stops: <double>[0.25, 0.75]),
              ),
              NeedlePointer(
                value: homeProvider.transferRate,
                enableAnimation: true,
                needleStartWidth: 3,
                needleEndWidth: 10,
                gradient: LinearGradient(colors: <Color>[
                  AppColors.p1Color,
                  AppColors.p2Color,
                ], stops: <double>[
                  0.25,
                  0.75
                ]),
                knobStyle: KnobStyle(
                  color: Color(0xff232F4E),
                ),
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        homeProvider.transferRate.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'popinssemibold',
                        ),
                      ),
                      SizedBox(height: 0.h),
                      Text(
                        'MB',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                angle: 90,
                positionFactor: 0.75,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ratesDisplay(HomeProvider homeProvider) {
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        // height: 18.h,
                        // width: 18.w,
                        // decoration:
                        //     BoxDecoration(
                        //   borderRadius:
                        //       BorderRadius
                        //           .circular(
                        //               30),
                        //   color: AppColors
                        //       .textWhiteColor,
                        //   // image: DecorationImage(
                        //   //   image: AssetImage(
                        //   //     AppImages.uploadIcon,
                        //   //   ),
                        //   // ),
                        // ),
                        child: Icon(
                      Icons.swap_horizontal_circle_outlined,
                      color: Color(0xffFFF38E),
                      size: 18,
                    )),
                    SizedBox(width: 5.w),
                    text(
                      text: 'Progress',
                      size: 15.sp,
                      boldText: FontWeight.w400,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsregular',
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    text(
                      text: homeProvider.dataCompleteRate.toStringAsFixed(0),
                      size: 22.sp,
                      boldText: FontWeight.w800,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsbold',
                    ),
                    SizedBox(width: 5.w),
                    text(
                      text: '%',
                      size: 10.sp,
                      boldText: FontWeight.w400,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsregular',
                    )
                  ],
                ),
              ],
            ),
            divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Color(0xFF6FFFBD),
                      size: 18,
                    ),
                    SizedBox(width: 5.w),
                    text(
                      text: 'Download',
                      size: 15.sp,
                      boldText: FontWeight.w400,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsregular',
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    text(
                      text: homeProvider.testDownloadType
                          ? '${(homeProvider.downloadComplteRate! / 100) * 100}'
                                      .length >
                                  12
                              ? '${((homeProvider.downloadComplteRate! / 100) * 100).toStringAsFixed(2)}'
                              : '${((homeProvider.downloadComplteRate! / 100) * 100).toStringAsFixed(2)}'
                          : '0',
                      size: 22.sp,
                      boldText: FontWeight.w800,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsbold',
                    ),
                    SizedBox(width: 5.w),
                    text(
                      text: 'Mbps',
                      size: 10.sp,
                      boldText: FontWeight.w400,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsregular',
                    )
                  ],
                ),
              ],
            ),
            divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_circle_up_sharp,
                      color: Color(0xFF995FCF),
                      size: 18,
                    ),
                    SizedBox(width: 5.w),
                    text(
                      text: 'Upload',
                      size: 15.sp,
                      boldText: FontWeight.w400,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsregular',
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    text(
                      text: homeProvider.testUploadType
                          ? '${(homeProvider.uploadCompleteRate! / 100) * 100}'
                                      .length >
                                  12
                              ? '${((homeProvider.uploadCompleteRate! / 100) * 100).toStringAsFixed(2)}'
                              : '${((homeProvider.uploadCompleteRate! / 100) * 100).toStringAsFixed(2)}'
                          : '0',
                      size: 22.sp,
                      boldText: FontWeight.w800,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsbold',
                    ),
                    SizedBox(width: 5.w),
                    text(
                      text: 'Mbps',
                      size: 10.sp,
                      boldText: FontWeight.w400,
                      color: AppColors.textWhiteColor,
                      fontFamily: 'popinsregular',
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget testAgainBtn(HomeProvider homeProvider) {
    return FadeInUp(
      child: InkWell(
        onTap: () {
          homeProvider.cleanData();
        },
        child: Container(
          margin: EdgeInsets.only(top: 0, bottom: 50.h),
          width: MediaQuery.of(context).size.width * 0.6,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
          ),
          decoration: BoxDecoration(
              gradient: AppColors.btngradiebnt,
              borderRadius: BorderRadius.circular(30)),
          child: text(
            text: 'Test Again',
            size: 18.sp,
            boldText: FontWeight.w700,
            color: AppColors.primaryColor,
            fontFamily: 'popinssemibold',
          ),
        ),
      ),
    );
  }

  // AdsServices.displayNativeMRECAd(),
  void labelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '0') {
      args.text = 'N';
      args.labelStyle = GaugeTextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14);
    } else if (args.text == '10')
      args.text = '';
    else if (args.text == '20')
      args.text = 'E';
    else if (args.text == '30')
      args.text = '';
    else if (args.text == '40')
      args.text = 'S';
    else if (args.text == '50')
      args.text = '';
    else if (args.text == '60')
      args.text = 'W';
    else if (args.text == '70') args.text = '';
  }
}
