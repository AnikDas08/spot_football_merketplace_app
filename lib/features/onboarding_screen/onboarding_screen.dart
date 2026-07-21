import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';
import '../../component/blur_reveal/blur_reveal.dart';
import '../../component/button/common_button.dart';
import '../../component/text/common_text.dart';
import '../../services/storage/storage_keys.dart';
import '../../services/storage/storage_services.dart';
import '../../utils/constants/app_colors.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurReveal(
      child: Scaffold(
        body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/welcome_bg.png",
              fit: BoxFit.fitHeight,
            ),
          ),

          /// Dark Gradient Overlay (Much darker at the bottom)
          Positioned.fill(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.0),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  const CommonText(
                    text: "PLAY THE GAME",
                    fontSize: 12,
                    color: AppColors.colorEABB00,
                    fontWeight: FontWeight.w700,
                  ),
                  const Spacer(flex: 12),

                  /// Welcome Text
                  CommonText(
                    text: "Welcome to",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  /// App Logo (Now under 'Welcome to')
                  Image.asset(AppImages.appLogo, height: 60.h),
                  SizedBox(height: 16.h),

                  /// Subtitle
                  CommonText(
                    text: "Your club. Your app. Every goal, every story, every moment on one platform",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.8),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    bottom: 32.h,
                  ),

                  /// Action Buttons (Side by Side)
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          buttonRadius: 50,
                          titleText: "Sign Up",
                          titleSize: 16.sp,
                          onTap: () => Get.toNamed(AppRoutes.signUp),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CommonButton(
                          buttonRadius: 50,
                          titleText: AppString.signIn,
                          titleSize: 16.sp,
                          onTap: () => Get.toNamed(AppRoutes.signIn),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 32.h),

                  /// Continue with Limited Access
                  InkWell(
                    onTap: () async {
                      await LocalStorage.setBool(LocalStorageKeys.isGuest, true);
                      Get.offAllNamed(AppRoutes.navBarScreen);
                    },
                    child: Text(
                      "Continue with Limited Access",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
