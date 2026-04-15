import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/constants/app_colors.dart';
import '../controller/navbar_controller.dart';



class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavBarController>();

    return Scaffold(
      drawer: const Drawer(),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF5F5F5),
              blurRadius: 20,
              offset: const Offset(0, 0),
            ),
          ],
          border: const Border(
            top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 70.h,
            child: Obx(() {
              final int currentIndex = controller.selectedIndex.value;
              final int totalItems = controller.inActiveIcons.length;

              return LayoutBuilder(
                builder: (context, constraints) {
                  double itemWidth = constraints.maxWidth / totalItems;

                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOutSine,
                        top: 0,
                        left: (itemWidth * currentIndex) + (itemWidth / 2) - (12.5.w),
                        child: Container(
                          width: 25.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4.r),
                              bottomRight: Radius.circular(4.r),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: List.generate(totalItems, (index) {
                          final bool isActive = currentIndex == index;

                          return Expanded(
                            child: GestureDetector(
                              onTap: () => controller.changeIndex(index),
                              behavior: HitTestBehavior.translucent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    isActive
                                        ? controller.activeIcons[index]
                                        : controller.inActiveIcons[index],
                                    height: 22.h,
                                    width: 22.w,
                                    colorFilter: ColorFilter.mode(
                                      isActive
                                          ? AppColors.primaryColor
                                          : AppColors.textSecondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    controller.labels[index].tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
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
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}