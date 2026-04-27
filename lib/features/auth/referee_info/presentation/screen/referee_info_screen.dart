import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/common_dropdown_field/common_dropdown_field.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/auth/referee_info/presentation/controller/referee_info_controller.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class RefereeInfoScreen extends StatefulWidget {
  const RefereeInfoScreen({super.key});

  @override
  State<RefereeInfoScreen> createState() => _RefereeInfoScreenState();
}

class _RefereeInfoScreenState extends State<RefereeInfoScreen> {
  final RefereeInfoController controller = Get.put(RefereeInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              const CommonText(
                text: 'Referee Info',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                bottom: 8,
              ),
              const CommonText(
                text: 'Set your officiating preferences to get matched with the right games.',
                fontSize: 16,
                maxLines: 2,
                fontWeight: FontWeight.w400,
                color: AppColors.color373737,
                bottom: 24,
                textAlign: TextAlign.start,
              ),
              
              Row(
                children: [
                  const CommonText(
                    text: 'Experience Level',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  const CommonText(
                    text: ' *',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CommonDropdownField<String>(
                hintText: 'Select experience level',
                items: ['Beginner', 'Intermediate', 'Professional'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedExperience.value = value ?? "";
                },
              ),

              SizedBox(height: 20.h),

              const CommonText(
                text: 'Assigned League',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              SizedBox(height: 8.h),
              CommonDropdownField<String>(
                hintText: 'Assigned League (Optional)',
                items: ['League A', 'League B', 'League C'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.assignedLeague.value = value ?? "";
                },
              ),

              SizedBox(height: 24.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFFFD54F)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: const Color(0xFFFFD54F),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.color373737,
                            fontFamily: 'SFPro',
                          ),
                          children: [
                            const TextSpan(
                              text: 'Tip: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const TextSpan(
                              text: 'Your experience level helps us assign appropriate matches. You can update this later in settings.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              Obx(() => CommonButton(
                onTap: () => controller.completeProcess(),
                buttonColor: AppColors.black,
                titleText: "Continue",
                titleColor: AppColors.white,
                isLoading: controller.isLoading.value,
              )),

              SizedBox(height: 16.h),

              CommonButton(
                onTap: () {},
                buttonColor: const Color(0xFFF3F3F3),
                borderColor: Colors.grey.withOpacity(0.3),
                titleText: "Sample Text",
                titleColor: AppColors.black,
              ),
              
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

