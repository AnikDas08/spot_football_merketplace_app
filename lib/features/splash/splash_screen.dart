import 'package:flutter/material.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/services/storage/storage_services.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: Center(
          //child: CommonImage(imageSrc: AppImages.noImage, size: 70),
          child: CommonText(text: "Add Value To Your Style", fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black,),
        ),
      ),
    );
  }
}
