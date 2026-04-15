import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import '../../../../config/route/app_routes.dart';
import 'package:get/get.dart';

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
      Get.offAllNamed(AppRoutes.navBarScreen);
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
          //child: CommonImage(imageSrc: AppImages.noImage, size: 70),
          child:
           Image.asset(AppImages.appLogoP,height: 72.h,width: 206.w,
          ),
        ),
      ),
    );
  }
}
