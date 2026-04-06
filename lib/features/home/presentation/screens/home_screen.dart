import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Image.asset(AppImages.appLogo),
            CommonText(text: AppString.transfers,color: AppColors.white,)
          ],
        ),
        actions: [
          IconButton(color: AppColors.white, onPressed: () {
            
          }, icon: Icon(Icons.notifications_outlined))
        ],
      ),
      body: SafeArea(child: Column(
        children: [
          Text("Home screen")
        ],
      )),
    );
  }
}
