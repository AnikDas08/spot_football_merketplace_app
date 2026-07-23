import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/route/app_routes.dart';
import 'package:get/get.dart';

import '../../services/storage/storage_services.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';
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

  // Phase 2: logo sweep + blur -> clear reveal
  late Animation<double> _contentOpacity;
  late Animation<double> _contentScale;
  late Animation<double> _blurSigma;
  late Animation<double> _sweepPosition;

  // Phase 3: Slogan fades up sequentially after logo is sharp
  late Animation<double> _sloganOpacity;
  late Animation<double> _textOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    // Phase 1: Background Circle Reveal (0.0 - 0.25)
    // Faster coverage to avoid any white gap
    _circleScale = Tween<double>(begin: 1.0, end: 40.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOutCubic),
      ),
    );

    _circleOpacity = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.linear),
      ),
    );

    // Phase 2: Logo Sharpness & Sweep Reveal (0.3 - 0.85)
    // Starting later and lasting longer for more "delay" and smoothness
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.45, curve: Curves.easeIn),
      ),
    );

    // Logo grows from 0.5 to 1.0 during the reveal
    _contentScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Blur goes from 20 to 0 (more delay, slower reveal)
    _blurSigma = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.85, curve: Curves.easeOut),
      ),
    );

    // Controls the left-to-right sweep mask
    _sweepPosition = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.85, curve: Curves.easeInOutSine),
      ),
    );

    // Phase 3: Slogan Reveal (Synchronized with Logo Phase 2)
    _sloganOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.75, curve: Curves.easeIn),
      ),
    );

    _textOffset = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.75, curve: Curves.easeOut),
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
    // Adjusted delay to match the 5s duration
    await Future.delayed(const Duration(milliseconds: 5200));

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
              // 0. Solid background visible after circle covers
              if (_controller.value >= 0.2)
                Container(color: AppColors.primaryColor),

              // 1. Growing circle that reveals the primary color across the screen
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

              // Final logo + text — blurred at first, becomes sharp smoothly
              Center(
                child: Opacity(
                  opacity: _contentOpacity.value,
                  child: Transform.scale(
                    scale: _contentScale.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo Section with Sweep Reveal
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // 1. Bottom Layer: Blurred Logo
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: _blurSigma.value,
                                sigmaY: _blurSigma.value,
                              ),
                              child: Image.asset(
                                AppImages.appLogo,
                                width: 180.w,
                              ),
                            ),
                            // 2. Top Layer: Sharp Logo revealed by Sweep
                            ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: const [
                                    Colors.white,
                                    Colors.white,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  stops: [
                                    0.0,
                                    _sweepPosition.value,
                                    _sweepPosition.value + 0.1,
                                    1.0,
                                  ],
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.asset(
                                AppImages.appLogo,
                                width: 180.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        // 3. Slogan: Revealed together with logo (Higher position)
                        Opacity(
                          opacity: _sloganOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, _textOffset.value),
                            child: Text(
                              'Welcome to The Official Eng Sports App!',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.w,
                              ),
                            ),
                          ),
                        ),
                      ],
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