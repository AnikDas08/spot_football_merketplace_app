import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/screen/webview_screen.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../auth/sign in/presentation/widgets/signup_appbar.dart';
import '../controller/subscription_controller.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    final bool isFromRegistration =
        Get.arguments?['isFromRegistration'] ?? false;

    // Determine title based on role
    String role = LocalStorage.role;
    if (role.isEmpty) role = "User";
    String titleRole = role[0].toUpperCase() + role.substring(1).toLowerCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (controller.packages.isEmpty) {
          return Center(
            child: CommonText(text: "No subscription plans available."),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CommonText(
                  text: '$titleRole Registration',
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                  color: AppColors.black,
                  bottom: 10.h,
                ),
                CommonText(
                  text:
                      'Please Select One Of The Following Which Applies To You - All Registrations Pending ENG Admin Approval',
                  fontSize: 16.sp,
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
                    return _RegistrationPlanCard(
                      package: package,
                      isSelected:
                          controller.selectedPackage.value?.id == package.id,
                      icon: _getIconForPackage(package.title ?? ""),
                      onSelect: () => controller.selectPackage(package),
                    );
                  },
                ),

                SizedBox(height: 24.h),

                CommonButton(
                  titleText: 'Continue',
                  onTap: controller.selectedPackage.value != null
                      ? () {
                          final selected = controller.selectedPackage.value!;
                          if (selected.paymentLink != null &&
                              selected.paymentLink!.isNotEmpty) {
                            Get.to(
                              () => WebViewScreen(
                                url: selected.paymentLink!,
                                title: "Payment",
                                onPaymentSuccess: () async {
                                  if (isFromRegistration) {
                                    Get.offAllNamed(AppRoutes.signIn);
                                    AppSnackbar.success(
                                      title: "Success",
                                      message: "Payment successful! Please sign in.",
                                    );
                                  } else {
                                    await LocalStorage.setBool(LocalStorageKeys.paymentStatus, true);
                                    Get.offAllNamed(AppRoutes.navBarScreen);
                                    AppSnackbar.success(
                                      title: "Success",
                                      message: "Payment successful! Welcome back.",
                                    );
                                  }
                                },
                              ),
                            );
                          } else {
                            AppSnackbar.error(
                              title: "Error",
                              message: "Payment link not available.",
                            );
                          }
                        }
                      : null,
                ),

                SizedBox(height: 24.h),
                Center(
                  child: CommonText(
                    text: 'You can switch your primary role\nlater in settings',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    color: Color(0xFF6B6B6B),
                    bottom: 32.h,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      }),
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
  final String icon;
  final VoidCallback onSelect;

  const _RegistrationPlanCard({
    required this.package,
    required this.isSelected,
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
          color: isSelected ? AppColors.black : AppColors.transparent,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon, height: 24.r, width: 24.r),
                SizedBox(width: 12.w),
                CommonText(
                  text: package.title?.toUpperCase() ?? "",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
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
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: priceColor,
                        ),
                      ),
                      CommonText(
                        text: '/${package.paymentType ?? "Season"}',
                        fontSize: 12.sp,
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
              onTap: onSelect,
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CommonText(
                  text: 'SELECT ${package.title?.toUpperCase() ?? ""}',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
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
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
