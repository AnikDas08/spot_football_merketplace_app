import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/temp_image.dart';
import '../widget/player_card.dart';
import '../widget/trial_offer_card.dart';
import 'package:get/get.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: AppString.transfer.toUpperCase()),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 16,),
                child: CommonText(
                  text:AppString.trending.toUpperCase(),
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  padding: .symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: PlayerCard(
                        imageUrl: TempImage.player,
                        status: AppString.liveStadium,
                        position: 'Striker',
                        age: 9,
                        playerName: 'Marcus Vance',
                        academyName: 'ENG ACADEMY',
                        price: '8400',
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 32.h),

              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 0,),
                child: CommonText(
                  text: AppString.recentOffers.toUpperCase(),
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),

              ListView.builder(
                padding: .symmetric(horizontal: 16),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: TrialOfferCard(
                      playerImageUrl: TempImage.playerProfile,
                      title: 'Amateur',
                      matchPercentage: '92%',
                      description:
                          'Personal terms agreed. Medical scheduled for Friday.',
                      onOfferTap: () {
                        // Get.toNamed(AppRoutes.transferPendingApproval);
                        Get.toNamed(AppRoutes.playerProfileDetailsScreen);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
