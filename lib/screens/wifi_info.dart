import 'package:flutter/material.dart';
import 'package:internet_speedtest_app/provider/home_provider.dart';
import 'package:internet_speedtest_app/provider/wifi_provider.dart';
import 'package:internet_speedtest_app/widgets/custom_app_bar.dart';
import 'package:internet_speedtest_app/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utility/app_Images.dart';
import '../utility/app_colors.dart';

class WifiInfoScreen extends StatefulWidget {
  const WifiInfoScreen({super.key});

  @override
  State<WifiInfoScreen> createState() => _WifiInfoScreenState();
}

class _WifiInfoScreenState extends State<WifiInfoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WifiProvider>(context, listen: false).initNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<HomeProvider>().getTODOItem();
    WifiProvider wifiProvider =
        Provider.of<WifiProvider>(context, listen: true);
    return Scaffold(
      // bottomNavigationBar: AdsServices.displayBannerAd(),
      appBar: CustomeAppBar(
        titleTxt: 'Wifi Info',
        appAlignment: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.h),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'Wifi Name',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'WifiBSSID',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'WifiIPv4',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'WifiIPv6',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'Wifi Gateway IP',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'wifiBroadcast',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: 'wifiSubmask',
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.h),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiName.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiBSSID.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiIPv4.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiIPv6.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiGatewayIP.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiBroadcast.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: text(
                          text: wifiProvider.wifiSubmask.toString(),
                          size: 15,
                          fontFamily: 'Josefine Sans',
                          color: AppColors.textWhiteColor,
                          boldText: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
