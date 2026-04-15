import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/storage/storage_services.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the plan directly from LocalStorage
    String currentPlan = LocalStorage.plan.trim().toUpperCase();

    print("${currentPlan}==============================================================");
    
    // Default to SEMI PRO only if stored plan is empty
    if (currentPlan.isEmpty) {
      currentPlan = "SEMI PRO";
    }
    
    // Simple logic to show different prices based on plan
    String price = "£9.95";
    if (currentPlan == "AMATEUR") {
      price = "£4.95";
    } else if (currentPlan == "PROFESSIONAL") {
      price = "£14.95";
    } else {
      // If it's anything else (like SEMI PRO or something unexpected)
      price = "£9.95";
      currentPlan = "SEMI PRO"; 
    }

    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.mySubscriptions),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: AppString.subcriptionDetails.toUpperCase(),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.startFourPoint),
                      SizedBox(width: 8.w),
                      CommonText(
                        text: currentPlan,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FeatureItem(
                              text: AppString.enhancedTeamRegistration,
                              isIncluded: true,
                            ),
                            SizedBox(height: 8.h),
                            _FeatureItem(
                              text: AppString.detailedPlayerStats,
                              isIncluded: currentPlan != "AMATEUR",
                            ),
                            SizedBox(height: 8.h),
                            _FeatureItem(
                              text: AppString.noEngCoins,
                              isIncluded: currentPlan == "PROFESSIONAL",
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CommonText(
                            text: price,
                            fontWeight: FontWeight.w600,
                            fontSize: 36.sp,
                            color: AppColors.yellow,
                          ),
                          CommonText(
                            text: AppString.perSeason,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CommonButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.player_registration_screen);
                    },
                    titleText: AppString.changeSubscriptionPlan,
                    buttonColor: AppColors.primaryColor,
                    titleColor: AppColors.white,
                    buttonWidth: double.infinity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;
  final bool isIncluded;

  const _FeatureItem({required this.text, required this.isIncluded});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isIncluded ? Icons.check_circle_outline : Icons.cancel_outlined,
          size: 20.r,
          color: isIncluded ? AppColors.green : AppColors.red,
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: CommonText(
            textAlign: .start,
            text: text,
            fontSize: 13.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
