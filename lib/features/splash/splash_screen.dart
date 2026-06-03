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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await LocalStorage.getAllPrefData();
    await Future.delayed(const Duration(seconds: 2));

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
    } else {
      Get.offAllNamed(AppRoutes.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child:
           Image.asset(AppImages.appLogoP,height: 72.h,width: 206.w,
          ),
        ),
      ),
    );
  }
}
