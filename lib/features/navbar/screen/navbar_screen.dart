import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/constants/app_colors.dart';
import '../controller/navbar_controller.dart';

class NavBarScreen extends StatelessWidget {
  NavBarScreen({super.key}) {
    Get.put(NavBarController());

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: GetX<NavBarController>(
        builder: (controller) => controller.screens[controller.currentIndex],
      ),

      /// Bottom navigation using BottomAppBar for full control
      bottomNavigationBar: GetX<NavBarController>(
        builder: (controller) {
          return SafeArea(
            bottom: true,
            child: Container(
              padding: EdgeInsets.only(bottom: 0, top: 10, right: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white,
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),

              child:Row(
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
                              ? controller.activeIcons[index]
                              : controller.inActiveIcons[index],
                          height: 19,
                          width: 18,


                        ),
                         SizedBox(height: 4),
                        Text(
                          controller.labels.length > index ? controller.labels[index] : '',
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 12,
                            color: isActive ? AppColors.primaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }


}