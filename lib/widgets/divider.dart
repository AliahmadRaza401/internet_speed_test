import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

Widget divider({height}){
  return   Container(
                                            width: 2,
                                            height: height == null ?  60 : height,
                                            decoration: BoxDecoration(
                                              // color: Colors.amber,
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    Color(0xff71809c),
                                                    AppColors.primaryColor,
                                                  ]),
                                            ),
                                          );
}