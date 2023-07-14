import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_speedtest_app/utility/app_Images.dart';
import '../utility/app_colors.dart';
import 'custom_text_widget.dart';

class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleTxt;
  final bool appAlignment;
  const CustomeAppBar({
    Key? key,
    required this.titleTxt,
    required this.appAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.metersmalIcon,
            height: 20.h,
            width: 25.w,
            fit: BoxFit.contain,
            color: AppColors.textWhiteColor,
          ),
          text(
            text: titleTxt,
            size: 25.sp,
            color: AppColors.textWhiteColor,
            boldText: FontWeight.w700,
            fontFamily: 'Jsefine Sans',
          )
        ],
      ),
      centerTitle: appAlignment,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
