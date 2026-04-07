import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../widget/add_player_placeholder.dart';
import '../widget/compareInfo_card.dart';

class PlayerComparisonScreen extends StatelessWidget {
  const PlayerComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'player comparison'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: CommonText(
                    text: "Select two players to compare their stats"
                        .toUpperCase(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(child: AddPlayerPlaceholder(onTap: () {
                    Get.toNamed(AppRoutes.addPlayerScreen);

                  })),
                  SizedBox(width: 16.h),

                  Expanded(child: AddPlayerPlaceholder(onTap: () {
                    Get.toNamed(AppRoutes.addPlayerScreen);

                  })),
                ],
              ),

              SizedBox(height: 24.w),

              CompareInfoCard(

              ),
            ],
          ),
        ),
      ),
    );
  }
}
