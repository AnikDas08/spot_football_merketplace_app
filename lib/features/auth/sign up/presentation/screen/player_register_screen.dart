import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';
import '../../data/player_registation_model.dart';
import '../controller/player_registatio_controller.dart';

class PlayerRegisterScreen extends StatelessWidget {
  PlayerRegisterScreen({super.key});

  final PlayerRegistrationController controller =
  Get.put(PlayerRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              /// Title
              const CommonText(
                text: 'Player Registration',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                color: AppColors.primaryColor,
                bottom: 10,
              ),

              /// Subtitle
              const CommonText(
                text: 'Please Select One Of The Following Which Applies To You - All Registrations Pending ENG Admin Approval',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                maxLines: 3,
                color: AppColors.primaryColor,
                bottom: 32,
              ),

              /// Registration Plans ListView
              GetBuilder<PlayerRegistrationController>(
                builder: (ctrl) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ctrl.plans.length,
                    itemBuilder: (context, index) {
                      final plan = ctrl.plans[index];
                      return _RegistrationPlanCard(
                        plan: plan,
                        onSelectTap: () {
                          ctrl.selectPlan(plan.id);
                        },
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 24.h),

              /// Continue Button
              GetBuilder<PlayerRegistrationController>(
                builder: (ctrl) {
                  return CommonButton(
                    titleText: 'Continue',
                    isLoading: ctrl.isLoading.value,
                    onTap: () {
                      Get.toNamed(AppRoutes.verify_player_screen);
                    },
                  );
                },
              ),

              SizedBox(height: 16.h),

              /// Switch Role Text
              GestureDetector(
                onTap: () {
                  controller.switchPrimaryRoleLater();
                },
                child: Center(
                  child: CommonText(
                    text: 'You can switch your primary role\nlater in settings',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    color: Color(0xff373737),
                    bottom: 32,
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// ── Registration Plan Card ──────────────────────────────────────────────────
class _RegistrationPlanCard extends StatelessWidget {
  final RegistrationPlan plan;
  final VoidCallback onSelectTap;

  const _RegistrationPlanCard({
    required this.plan,
    required this.onSelectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: plan.isSelected
              ? AppColors.primaryColor
              : Colors.grey.withOpacity(0.2),
          width: plan.isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header with Badge and Title
            Row(
              children: [
                Text(
                  plan.badge,
                  style: TextStyle(fontSize: 24.sp),
                ),
                SizedBox(width: 12.w),
                CommonText(
                  text: plan.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// Features List
            Column(
              children: List.generate(
                plan.features.length,
                    (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        /// Checkmark or Cross Icon
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: plan.featureStatus[index]
                                ? const Color(0xFFE8F5E9)
                                : const Color(0xFFFFEBEE),
                          ),
                          child: Center(
                            child: Text(
                              plan.featureStatus[index] ? '✓' : '✕',
                              style: TextStyle(
                                color: plan.featureStatus[index]
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFF44336),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CommonText(
                            text: plan.features[index],
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            /// Price and Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Price Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '£${plan.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE91E63),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonText(
                      text: plan.priceSubtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF999999),
                    ),
                  ],
                ),

                /// Select Button
                SizedBox(
                  width: 120.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: onSelectTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: CommonText(
                      text: plan.buttonText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ── Social Login Button ──────────────────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.black.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 22.h,
              width: 22.w,
            ),
            12.width,
            CommonText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}