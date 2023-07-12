import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_speedtest_app/pages/result_page.dart';
import 'package:internet_speedtest_app/pages/setting_page.dart';
import 'package:internet_speedtest_app/pages/start_page.dart';
import 'package:internet_speedtest_app/utility/app_Images.dart';
import 'package:internet_speedtest_app/widgets/custom_text_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../provider/internet_connection_provider.dart';
import '../utility/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    StartPage(),
    ResultPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    InternetConnectionProvider internetConnectionProvider =
        Provider.of<InternetConnectionProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff111125),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.Lineargradiebnt,
            // image: DecorationImage(
            //     image: AssetImage(
            //       AppImages.backgroundImage,
            //     ),
            //     fit: BoxFit.cover),
          ),
          child: internetConnectionProvider.internetConnection
              ? _pages[_selectedIndex]
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(
                          AppImages.noInternetJson,
                          // width: 200,
                          // height: 200,
                          // fit: BoxFit.fill,
                        ),
                      ),
                      text(
                        text: 'No Internet',
                        size: 34.sp,
                        color: AppColors.textGreyColor,
                      )
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: AppColors.textWhiteColor,
              //     blurStyle: BlurStyle.outer,
              //     blurRadius: 12,
              //     spreadRadius: 1,
              //   ),
              // ],
              ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.secondaryColor,
            selectedLabelStyle: TextStyle(
              color: AppColors.greenColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: TextStyle(
              color: AppColors.textWhiteColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.metersmalIcon,
                  height: 20,
                  width: 25,
                  fit: BoxFit.contain,
                  color: _selectedIndex == 0
                      ? AppColors.greenColor
                      : AppColors.textWhiteColor,
                ),
                label: 'Start',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.historyIcon,
                  height: 20,
                  width: 25,
                  fit: BoxFit.contain,
                  color: _selectedIndex == 1
                      ? AppColors.greenColor
                      : AppColors.textWhiteColor,
                ),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.seetingIcon,
                  height: 20,
                  width: 25,
                  fit: BoxFit.contain,
                  color: _selectedIndex == 2
                      ? AppColors.greenColor
                      : AppColors.textWhiteColor,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.greenColor,
            unselectedItemColor: AppColors.textWhiteColor,
            onTap: navigationBottomBar,
          ),
        ),
      ),
    );
  }
}
