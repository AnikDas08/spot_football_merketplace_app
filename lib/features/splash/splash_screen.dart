import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import '../../../../config/route/app_routes.dart';
import 'package:get/get.dart';

import '../profile/presentation/controller/profile_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Phase 1: small logo badge scales up into a full-screen colored circle
  late Animation<double> _circleScale;
  late Animation<double> _circleOpacity;

  // Phase 2: final logo mark + text fade/scale in after the reveal
  late Animation<double> _contentOpacity;
  late Animation<double> _contentScale;

  // Blur -> clear animation for the final logo/text
  late Animation<double> _blurSigma;

  // Text slides up from below while it fades in
  late Animation<double> _textOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    // Circle grows from its original size to big enough to cover the whole screen
    _circleScale = Tween<double>(begin: 1.0, end: 35.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOutCubic),
      ),
    );

    // Circle fades out right after it has fully covered the screen
    _circleOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.55, curve: Curves.easeIn),
      ),
    );

    // Final logo + text fade in
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOut),
      ),
    );

    _contentScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOutBack),
      ),
    );

    // Starts blurred (sigma 20), smoothly becomes sharp (sigma 0)
    _blurSigma = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Text starts 24px below its final position and slides up as it fades in
    _textOffset = Tween<double>(begin: 24.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _navigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigate() async {
    await LocalStorage.getAllPrefData();
    await Future.delayed(const Duration(seconds: 3));

    if (LocalStorage.isLogIn) {
      // Refresh profile data to get latest statuses (profileStatus, paymentStatus)
      try {
        final profileController = Get.find<ProfileController>();
        await profileController.getProfileData();
      } catch (e) {
        debugPrint("Splash: Error refreshing profile: $e");
      }

      final String profileStatus = LocalStorage.profileStatus;
      final bool paymentStatus = LocalStorage.paymentStatus;
      final String role = LocalStorage.role.toUpperCase();

      if (profileStatus == "INCOMPLETE" || profileStatus.isEmpty) {
        if (role == "PLAYER") {
          Get.offAllNamed(AppRoutes.verifyPlayerScreen);
        } else if (role == "MANAGER") {
          Get.offAllNamed(AppRoutes.managerRegistrationScreen);
        } else if (role == "REFEREE") {
          Get.offAllNamed(AppRoutes.refereeInfoScreen);
        } else if (role == "OTHER_CLUBS" || role == "TRIAL") {
          Get.offAllNamed(AppRoutes.trialRegistrationScreen);
        } else {
          Get.offAllNamed(AppRoutes.navBarScreen);
        }
      } else if (!paymentStatus) {
        Get.offAllNamed(AppRoutes.mySubscription);
      } else {
        Get.offAllNamed(AppRoutes.navBarScreen);
      }
    } else if (LocalStorage.isGuest) {
      Get.offAllNamed(AppRoutes.navBarScreen);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Growing circle that reveals the primary color across the screen
              Center(
                child: Opacity(
                  opacity: _circleOpacity.value,
                  child: Transform.scale(
                    scale: _circleScale.value,
                    child: Container(
                      width: 90.w,
                      height: 90.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),

              // Solid background locked in once the circle has fully covered the screen
              // (prevents a white flash when the circle above fades out)
              if (_controller.value >= 0.5)
                Container(color: AppColors.primaryColor),

              // Final logo + text — blurred at first, becomes sharp smoothly
              Center(
                child: Opacity(
                  opacity: _contentOpacity.value,
                  child: Transform.scale(
                    scale: _contentScale.value,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: _blurSigma.value,
                        sigmaY: _blurSigma.value,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Spacer(),
                          Image.asset(
                            AppImages.appLogo,
                            width: 180.w,
                          ),
                          SizedBox(height: 16.h),
                          Spacer(),
                          Transform.translate(
                            offset: Offset(0, _textOffset.value),
                            child: Text(
                              'HARDWORKDEDICATION',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.w,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}