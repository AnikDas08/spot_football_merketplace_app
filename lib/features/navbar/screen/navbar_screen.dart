import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/constants/app_colors.dart';
import '../controller/navbar_controller.dart';



class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: GetX<NavBarController>(
        builder: (controller) => controller.screens[controller.currentIndex],
      ),

      bottomNavigationBar: GetX<NavBarController>(
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF5F5F5),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
              ],
              border: const Border(
                top: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(controller.activeIcons.length, (index) {
                    final isActive = controller.currentIndex == index;
                    return GestureDetector(
                      onTap: () => controller.changeIndex(index),
                      behavior: HitTestBehavior.translucent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            isActive
                                ? controller.inActiveIcons[index]
                                : controller.inActiveIcons[index],
                            height: 20.h,
                            width: 20.w,
                            colorFilter: ColorFilter.mode(
                              isActive
                                  ? AppColors.primaryColor
                                  : AppColors.textSecondaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            controller.labels.length > index
                                ? controller.labels[index]
                                : '',
                            style: TextStyle(
                              fontFamily: 'SFPro',
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              fontSize: 10.sp,
                              color: isActive
                                  ? AppColors.primaryColor
                                  : AppColors.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}