import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.mySubscriptions),
      body: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            CommonText(
              text: AppString.subcriptionDetails.toUpperCase(),
              fontSize: 20.sp,
              fontWeight: FontWeight(590),
            ),
            SizedBox(height : 20.h),
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
                        text: AppString.semiPro,
                        fontWeight: FontWeight(590),
                        fontSize: 20.sp.sp,
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
                              isIncluded: true,
                            ),
                            SizedBox(height: 8.h),
                            _FeatureItem(
                              text: AppString.noEngCoins,
                              isIncluded: false,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CommonText(
                            text: AppString.semiProPrice,
                            fontWeight: FontWeight(590),
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
                    onTap: () {},
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
