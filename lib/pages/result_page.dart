import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:internet_speedtest_app/pages/single_reult_detail_screen.dart';
import 'package:internet_speedtest_app/provider/home_provider.dart';
import 'package:internet_speedtest_app/utility/app_Images.dart';
import 'package:internet_speedtest_app/utility/app_colors.dart';
import 'package:internet_speedtest_app/widgets/app_Routes.dart';
import 'package:internet_speedtest_app/widgets/custom_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/wifi_Resut_Model.dart';
import '../widgets/custom_app_bar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int adsPlace = 2;
  @override
  Widget build(BuildContext context) {
    context.watch<HomeProvider>().getTODOItem();
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // bottomNavigationBar: AdsServices.displayBannerAd(),
      appBar: CustomeAppBar(
        appAlignment: true,
        titleTxt: 'History',
      ),
      // extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(
            //     AppImages.backgroundImage,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: homeProvider.todoList.length == 0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          AppImages.noHistory,

                          // width: 200,
                          // height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.fill,
                        ),
                        text(
                          text: 'No Data Found',
                          size: 34.sp,
                          color: AppColors.textGreyColor,
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: FadeInUpBig(
                        child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: homeProvider.todoList.isEmpty
                              ? 0
                              : homeProvider.todoList.length,
                          //  +
                          //     (homeProvider.todoList.length ~/ 3),
                          itemBuilder: (context, index) {
                            WifiResultModel singleIndex =
                                homeProvider.todoList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  AppRoutes.push(
                                    context,
                                    PageTransitionType.fade,
                                    SingleResultDetailScreen(
                                      singleIndex: homeProvider.todoList[index],
                                      indexnumber: index,
                                    ),
                                  );
                                },
                                child: resultWidget(
                                  DateFormat('yyyy-MM-dd ')
                                      .format(singleIndex.testDate!),
                                  singleIndex.dowoloadSpeed.toString(),
                                  DateFormat('HH:mm')
                                      .format(singleIndex.testDate!),
                                  singleIndex.uploadSpeed.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
            // : SizedBox(
            //     height: MediaQuery.of(context).size.height,
            //     child: ListView.builder(
            //       itemCount: homeProvider.todoList.isEmpty
            //           ? 0
            //           : homeProvider.todoList.length +
            //               (homeProvider.todoList.length ~/ 3),
            //       itemBuilder: (context, index) {
            //         if (index > 0 && (index + 1) % 4 == 0) {
            //           final adIndex = (index + 1) ~/ 4 - 1;
            //           return Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: InkWell(
            //                   onTap: () {
            //                     AppRoutes.push(
            //                       context,
            //                       PageTransitionType.fade,
            //                       SingleResultDetailScreen(
            //                         singleIndex:
            //                             homeProvider.todoList[index],
            //                         indexnumber: index,
            //                       ),
            //                     );
            //                   },
            //                   child: resultWidget(
            //                     homeProvider.todoList[adIndex].ipAddress
            //                         .toString(),
            //                     homeProvider.todoList[adIndex].dowoloadSpeed
            //                         .toString(),
            //                     DateFormat('yyyy-MM-dd HH:mm').format(
            //                         homeProvider
            //                             .todoList[adIndex].testDate!),
            //                     homeProvider.todoList[adIndex].uploadSpeed
            //                         .toString(),
            //                   ),
            //                 ),
            //               ),
            //               AdsServices.displayNativeMRECAd(),
            //             ],
            //           );
            //         } else {
            //           final dataIndex = index - (index ~/ 4);
            //           final todoCat = homeProvider.todoList[dataIndex];
            //           return Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: InkWell(
            //               onTap: () {
            //                 AppRoutes.push(
            //                   context,
            //                   PageTransitionType.fade,
            //                   SingleResultDetailScreen(
            //                     singleIndex: homeProvider.todoList[index],
            //                     indexnumber: index,
            //                   ),
            //                 );
            //               },
            //               child: resultWidget(
            //                 todoCat.ipAddress.toString(),
            //                 todoCat.dowoloadSpeed.toString(),
            //                 DateFormat('yyyy-MM-dd HH:mm')
            //                     .format(todoCat.testDate!),
            //                 todoCat.uploadSpeed.toString(),
            //               ),
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //   ),
          ),
        ),
      ),
    );
  }

  Widget resultWidget(
    String ipAddress,
    String downloadSpeed,
    String testdate,
    String uploadData,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: AppColors.lightBG,
        borderRadius: BorderRadius.circular(10.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.textWhiteColor,
        //     blurStyle: BlurStyle.outer,
        //     blurRadius: 8,
        //     spreadRadius: 1,
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Icon(
            //       Icons.arrow_back_ios_new_rounded,
            //       color: AppColors.textWhiteColor,
            //     )
            //   ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  text: testdate,
                  size: 16.sp,
                  color: AppColors.textWhiteColor,
                  fontFamily: 'Josefine Sans',
                  boldText: FontWeight.w700,
                ),
                SizedBox(height: 10.h),
                text(
                  text: ipAddress.isEmpty ? 'Unknown' : ipAddress,
                  size: 16.sp,
                  color: AppColors.textWhiteColor,
                  boldText: FontWeight.w400,
                  fontFamily: 'Josefin Sans',
                ),
              ],
            ),
            Container(
              height: 27,
              width: 2,
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Color(0xFF6FFFBD),
                      size: 18.w,
                    ),
                    SizedBox(width: 10.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text(
                          text: downloadSpeed,
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
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_up_sharp,
                      color: Color(0xFF995FCF),
                      size: 18.w,
                    ),
                    SizedBox(width: 10.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text(
                          text: uploadData,
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
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Icon(
            //       Icons.arrow_forward_ios_rounded,
            //       color: AppColors.textWhiteColor,
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
