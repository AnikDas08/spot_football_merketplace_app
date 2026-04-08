import 'package:flutter/material.dart' hide TabController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import '../controllers/tab_controller.dart';

class TransferTabWidget extends StatelessWidget {
  const TransferTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: 'MY TRANSFERS',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _TabItem(
                    title: 'All',
                    selected: controller.selectedTab == 0,
                    onTap: () => controller.changeTab(0),
                  ),
                  _TabItem(
                    title: 'Buy',
                    selected: controller.selectedTab == 1,
                    onTap: () => controller.changeTab(1),
                  ),
                  _TabItem(
                    title: 'Sell',
                    selected: controller.selectedTab == 2,
                    onTap: () => controller.changeTab(2),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    ;
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const _TabItem({required this.title, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: CommonText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight(590),
          color: selected ? AppColors.white : AppColors.primaryColor,
        ),
      ),
    );
  }
}
