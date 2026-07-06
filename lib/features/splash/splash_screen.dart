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
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(_animation),
                  child: Image.asset(
                    AppImages.appLogoP,
                    height: 100.h,
                    width: 280.w,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _animation,
                child: Center(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
