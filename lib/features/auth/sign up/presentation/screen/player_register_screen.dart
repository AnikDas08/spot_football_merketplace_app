import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
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
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// Title
              const CommonText(
                text: 'Player Registration',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                color: AppColors.black,
                bottom: 8,
              ),

              /// Subtitle
              const CommonText(
                text:
                'Please Select One Of The Following Which Applies To You - All Registrations Pending ENG Admin Approval',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                maxLines: 3,
                color: AppColors.color6B6B6B,
                bottom: 24,
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
              GetX<PlayerRegistrationController>(
                builder: (ctrl) {
                  return CommonButton(
                    titleText: 'Continue',
                    isLoading: ctrl.isLoading.value,
                    onTap: () {
                      if (ctrl.selectedPlan.value != null) {
                        Get.toNamed(AppRoutes.verify_player_screen);
                      } else {
                        Get.snackbar('Alert', 'Please select a plan first');
                      }
                    },
                  );
                },
              ),

              SizedBox(height: 20.h),

              /// Switch Role Text
              GestureDetector(
                onTap: () {
                  controller.switchPrimaryRoleLater();
                },
                child: const Center(
                  child: CommonText(
                    text: 'You can switch your primary role\nlater in settings',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    color: AppColors.color6B6B6B,
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
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: plan.isSelected ? AppColors.black : AppColors.transparent,
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    Text(
                      plan.badge,
                      style: TextStyle(fontSize: 22.sp),
                    ),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: plan.title,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                /// Features and Price Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Features List (Left Side)
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: List.generate(
                          plan.features.length,
                              (index) {
                            final isTrue = plan.featureStatus[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Row(
                                children: [
                                  Icon(
                                    isTrue ? Icons.check_circle_outline : Icons.cancel_outlined,
                                    size: 22.sp,
                                    color: isTrue ? const Color(0xFF19CA77) : const Color(0xFFF44336),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: CommonText(
                                      text: plan.features[index],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    /// Price Section (Right Side)
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '£${plan.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w700,
                              color: plan.title == 'AMATEUR'
                                  ? const Color(0xFFF44336) // Red for Amateur
                                  : plan.title == 'SEMI PRO'
                                  ? const Color(0xFFEABB00) // Yellow for Semi Pro
                                  : const Color(0xFF19CA77), // Green for Pro
                            ),
                          ),
                          CommonText(
                            text: plan.priceSubtitle,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.color6B6B6B,
                            top: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                /// Select Button
                GestureDetector(
                  onTap: onSelectTap,
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CommonText(
                      text: plan.buttonText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Small Floating logo like in screenshot (Optional placeholder)
          Positioned(
            top: 10,
            right: 16,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/icons/calendar.png', // Just a placeholder for the floating effect
                height: 40.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
