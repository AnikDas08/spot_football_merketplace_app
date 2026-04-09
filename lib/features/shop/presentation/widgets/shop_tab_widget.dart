import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/shop/presentation/controllers/shop_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class ShopTabWidget extends StatelessWidget {
  const ShopTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _tab(
                title: 'Redemption',
                selected: controller.selectedTab == 0,
                onTap: ()=> controller.changeTab(0),
              ),
              SizedBox(width: 12.w),
              _tab(
                title: 'Coffle',
                selected: controller.selectedTab == 1,
                onTap: ()=> controller.changeTab(1),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tab({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: CommonText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: selected ? AppColors.white : AppColors.primaryColor,
        ),
      ),
    );
  }
}