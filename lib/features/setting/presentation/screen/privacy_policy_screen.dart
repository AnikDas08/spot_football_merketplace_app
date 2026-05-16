import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/setting/presentation/controller/privacy_policy_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/enum/enum.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.privacyPolicy),
      body: GetBuilder<PrivacyPolicyController>(
        init: PrivacyPolicyController(),
        builder: (controller) {
          if (controller.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.status == Status.error) {
            return const Center(child: CommonText(text: "Failed to load privacy policy"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    child: CommonText(
                      text: AppString.legalProtoCol.toUpperCase(),
                      color: AppColors.primaryColor,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CommonText(
                    text: AppString.lastUpdatedOctober2024.toUpperCase(),
                    color: AppColors.color6B6B6B,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Html(
                    data: controller.data.content,
                    style: {
                      "body": Style(
                        fontSize: FontSize(16.sp),
                        fontWeight: FontWeight.w400,
                        color: AppColors.color6B6B6B,
                        textAlign: TextAlign.start,
                      ),
                      "h1": Style(
                        color: AppColors.primaryColor,
                        fontSize: FontSize(20.sp),
                        fontWeight: FontWeight.w700,
                      ),
                      "h2": Style(
                        color: AppColors.primaryColor,
                        fontSize: FontSize(18.sp),
                        fontWeight: FontWeight.w700,
                      ),
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
