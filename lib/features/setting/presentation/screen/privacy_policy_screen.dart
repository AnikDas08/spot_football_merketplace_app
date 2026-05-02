import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.privacyPolicy),
      body: Padding(
        padding: .all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                child: CommonText(
                  text: AppString.legalProtoCol.toUpperCase(),
                  color: AppColors.primaryColor,
                  fontSize: 32.sp,
                  fontWeight: FontWeight(700),
                  textAlign: .center,
                ),
              ),
              CommonText(
                text: AppString.lastUpdatedOctober2024.toUpperCase(),
                color: AppColors.color6B6B6B,
                fontSize: 16.sp,
                fontWeight: FontWeight(510),
                textAlign: .center,
              ),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: .start,
                spacing: 10,
                children: [
                  CommonText(
                    text: AppString.updateYourCredentials.toUpperCase(),
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight(700),
                    textAlign: .center,
                  ),
                  CommonText(
                    maxLines: 7,
                    text: AppString.atVoltageAthletic,
                    color: AppColors.color6B6B6B,
                    fontSize: 16.sp,
                    fontWeight: FontWeight(400),
                    textAlign: .start,
                  ),
                  CommonText(
                    maxLines: 7,
                    text: AppString.informationCollection,
                    color: AppColors.color6B6B6B,
                    fontSize: 16.sp,
                    fontWeight: FontWeight(400),
                    textAlign: .start,
                  ),
                  CommonText(
                    text: AppString.usageRight.toUpperCase(),
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight(700),
                    textAlign: .center,
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      CommonText(
                        maxLines: 7,
                        text: AppString.atVoltageAthletic,
                        color: AppColors.color6B6B6B,
                        fontSize: 16.sp,
                        fontWeight: FontWeight(400),
                        textAlign: .start,
                      ),  CommonText(
                        maxLines: 7,
                        text: AppString.voltageAthletic,
                        color: AppColors.color6B6B6B,
                        fontSize: 16.sp,
                        fontWeight: FontWeight(400),
                        textAlign: .start,
                      ), CommonText(
                        maxLines: 7,
                        text: AppString.informationCollection,
                        color: AppColors.color6B6B6B,
                        fontSize: 16.sp,
                        fontWeight: FontWeight(400),
                        textAlign: .start,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
