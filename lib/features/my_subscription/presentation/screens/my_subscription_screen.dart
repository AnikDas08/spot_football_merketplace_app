import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../component/screen/webview_screen.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../auth/sign in/presentation/widgets/signup_appbar.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../controller/subscription_controller.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    final profileController = Get.find<ProfileController>();
    final bool isFromRegistration =
        Get.arguments?['isFromRegistration'] ?? false;

    // Determine title based on role
    String role = LocalStorage.role;
    if (role.isEmpty) role = "User";
    String titleRole = role[0].toUpperCase() + role.substring(1).toLowerCase();

    return Obx(() {
      final subscription = profileController.profileData['subscription'];
      final bool hasSubscription = subscription != null &&
          subscription is Map &&
          subscription['package'] != null;

      return PopScope(
        canPop: hasSubscription || controller.isChangingPlan.value,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (controller.isChangingPlan.value) {
            controller.toggleChangingPlan(false);
          } else {
            AppSnackbar.error(
              title: "Action Required",
              message: "Please select a plan and complete payment to continue.",
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF3F3F3),
          appBar: SignupAppbar(
            showBackButton: hasSubscription || controller.isChangingPlan.value,
            onBack: () {
              if (controller.isChangingPlan.value) {
                controller.toggleChangingPlan(false);
              } else if (hasSubscription) {
                if (Navigator.canPop(context)) {
                  Get.back();
                } else {
                  Get.offAllNamed(AppRoutes.navBarScreen);
                }
              }
            },
          ),
          body: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryColor),
                )
              : (hasSubscription &&
                      !controller.isChangingPlan.value &&
                      !isFromRegistration)
                  ? _buildSubscriptionDetails(controller, subscription)
                  : controller.packages.isEmpty
                      ? const Center(
                          child: CommonText(text: "No subscription plans available."),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                CommonText(
                                  text: '$titleRole Registration',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.start,
                                  color: AppColors.black,
                                  bottom: 10.h,
                                  fontFamily: 'PlayfairDisplay',
                                ),
                                CommonText(
                                  text:
                                      'Please Select One Of The Following Which Applies To You - All Registrations Pending ENG Admin Approval',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  color: AppColors.black,
                                  bottom: 32.h,
                                ),

                                // Plans
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.packages.length,
                                  itemBuilder: (context, index) {
                                    final package = controller.packages[index];
                                    final bool isCurrentPlan = hasSubscription &&
                                        subscription['package']?['_id'] ==
                                            package.id;

                                    return _RegistrationPlanCard(
                                      package: package,
                                      isSelected:
                                          controller.selectedPackage.value?.id ==
                                              package.id,
                                      isCurrentPlan: isCurrentPlan,
                                      icon: _getIconForPackage(
                                          package.title ?? ""),
                                      onSelect: () =>
                                          controller.selectPackage(package),
                                    );
                                  },
                                ),

                                if (controller.selectedPackage.value != null &&
                                    hasSubscription &&
                                    subscription['package']?['_id'] ==
                                        controller.selectedPackage.value?.id)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    child: const Center(
                                      child: CommonText(
                                        text:
                                            "You are currently subscribed to this plan",
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),

                                SizedBox(height: 24.h),

                                CommonButton(
                                  titleText: 'Continue',
                                  isLoading: controller.isCheckingOut.value,
                                  buttonColor: (controller.selectedPackage.value ==
                                              null ||
                                          (hasSubscription &&
                                              subscription['package']?['_id'] ==
                                                  controller.selectedPackage
                                                      .value?.id))
                                      ? Colors.grey.shade400
                                      : AppColors.black,
                                  onTap: (controller.selectedPackage.value !=
                                              null &&
                                          (!hasSubscription ||
                                              subscription['package']?['_id'] !=
                                                  controller.selectedPackage
                                                      .value?.id))
                                      ? () {
                                          controller.generateCheckoutUrl(
                                            packageId: controller
                                                .selectedPackage.value!.id!,
                                            isFromRegistration:
                                                isFromRegistration,
                                            profileController:
                                                profileController,
                                          );
                                        }
                                      : null,
                                ),
                                SizedBox(height: 24.h),
                              ],
                            ),
                          ),
                        ),
        ),
      );
    });

  }

  Widget _buildSubscriptionDetails(SubscriptionController controller, dynamic subscription) {
    final package = subscription['package'];
    final String title = package?['title'] ?? "Unknown Plan";
    final dynamic price = package?['price'] ?? 0;
    final String paymentType = package?['paymentType'] ?? "Season";
    final String description = package?['description'] ?? "";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          CommonText(
            text: 'Subscription Details',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            bottom: 32.h,
            fontFamily: 'PlayfairDisplay',
          ),
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppImages.appLogo, height: 24.r, width: 24.r),
                    SizedBox(width: 12.w),
                    CommonText(
                      text: title,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _FeatureItem(text: description, isIncluded: true),
                          SizedBox(height: 8.h),
                          _FeatureItem(text: "Login Limit: ${package?['loginLimit'] ?? 0}", isIncluded: true),
                          SizedBox(height: 8.h),
                          _FeatureItem(
                            text: "Credits: ${package?['credit'] ?? 0}",
                            isIncluded: (package?['credit'] ?? 0) > 0,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '£$price',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFEABB00),
                          ),
                        ),
                        CommonText(
                          text: '/$paymentType',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B6B6B),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                CommonButton(
                  titleText: 'Change Your Subscriptions Plan',
                  onTap: () => controller.toggleChangingPlan(true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getIconForPackage(String title) {
    title = title.toUpperCase();
    if (title.contains("AMATEUR")) return AppIcons.card;
    if (title.contains("SEMI PRO")) return AppIcons.star;
    if (title.contains("PROFESSIONAL")) return AppIcons.pro;
    return AppIcons.star;
  }
}

class _RegistrationPlanCard extends StatelessWidget {
  final PackageModel package;
  final bool isSelected;
  final bool isCurrentPlan;
  final String icon;
  final VoidCallback onSelect;

  const _RegistrationPlanCard({
    required this.package,
    required this.isSelected,
    this.isCurrentPlan = false,
    required this.icon,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    Color priceColor = const Color(0xFF19CA77); // Default Green
    if (package.title?.toUpperCase().contains("AMATEUR") ?? false) {
      priceColor = const Color(0xFFF44336); // Red
    } else if (package.title?.toUpperCase().contains("SEMI PRO") ?? false) {
      priceColor = const Color(0xFFEABB00); // Yellow/Gold
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? AppColors.colorEABB00 : AppColors.transparent,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppImages.appLogo, height: 24.r, width: 24.r),
                SizedBox(width: 12.w),
                CommonText(
                  text: package.title ?? "",
                  fontSize: 18,
                  fontWeight: FontWeight.w500, 
                  color: AppColors.black,
                  fontFamily: 'PlayfairDisplay',
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _FeatureItem(
                        text: package.description ?? "",
                        isIncluded: true,
                      ),
                      SizedBox(height: 8.h),
                      _FeatureItem(
                        text: "Login Limit: ${package.loginLimit}",
                        isIncluded: true,
                      ),
                      SizedBox(height: 8.h),
                      _FeatureItem(
                        text: "Credits: ${package.credit}",
                        isIncluded:
                            package.credit != null && package.credit! > 0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '£${package.price}',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                          color: priceColor,
                        ),
                      ),
                      CommonText(
                        text: '/${package.paymentType ?? "Season"}',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B6B6B),
                        top: 2.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: isCurrentPlan ? null : onSelect,
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCurrentPlan ? Colors.grey.shade300 : AppColors.black,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.colorEABB00, width: 1.0),
                ),
                child: CommonText(
                  text: isCurrentPlan 
                      ? 'Current Plan' 
                      : 'Select ${package.title ?? ""}',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isCurrentPlan ? Colors.grey.shade600 : AppColors.white,
                ),
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
          size: 20.sp,
          color: isIncluded ? const Color(0xFF19CA77) : const Color(0xFFF44336),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CommonText(
            textAlign: TextAlign.start,
            text: text,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
