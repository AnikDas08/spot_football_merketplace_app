import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';
import '../controller/manager_registation_controller.dart';

class ManagerSubscriptionScreen extends StatelessWidget {
  ManagerSubscriptionScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Accessing your controller
    final controller = Get.put(ManagerRegistationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: SignupAppbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: 'Become an ENG\nManager',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                bottom: 10,
              ),
              const CommonText(
                text: 'Create your account and start managing your team today!',
                fontSize: 16,
                maxLines: 2,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                bottom: 32,
              ),

              // --- FREE TIER CARD ---
              _buildSubscriptionCard(
                icon: Icons.rocket_launch_rounded,
                iconBgColor: const Color(0xFFEEEEEE),
                iconColor: const Color(0xFF5383EC),
                title: 'START FOR FREE',
                description: 'Access basic manager features with no cost. Perfect for individual learning and initial growth.',
                buttonText: 'Sign Up Free',
                onTap: () {
                  Get.toNamed(AppRoutes.manager_registation_screen);
                },
              ),

              SizedBox(height: 16.h),

              // --- PAID TIER CARD ---
              _buildSubscriptionCard(
                icon: Icons.stars_rounded,
                iconBgColor: const Color(0xFFE8F0FE),
                iconColor: const Color(0xFF1A73E8),
                title: 'EARN ENG MANAGER COINS',
                description: 'Upgrade to earn ENG Manager Coins and unlock premium features, exclusive analytics, and team tools.',
                price: '£4.95',
                buttonText: 'Pay & Upgrade',
                onTap: () {
                  Get.toNamed(AppRoutes.manager_registation_screen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the Card UI
  Widget _buildSubscriptionCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String description,
    String? price,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: iconColor, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CommonText(
                  text: title,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CommonText(
            text: description,
            fontSize: 14,
            maxLines: 4,
            color: Colors.black54,
          ),
          if (price != null) ...[
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: price,
                    style: TextStyle(
                      color: const Color(0xFFEAB308), // Golden Yellow
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' / Month',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 20.h),
          CommonButton(
            buttonWidth: double.infinity,
            titleText: buttonText,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}