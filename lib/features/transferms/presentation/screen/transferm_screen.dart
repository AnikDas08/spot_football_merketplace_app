import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../drawer/presentation/screen/app_drawer.dart';
import '../controller/transfer_controller.dart';
import '../widget/player_card.dart';
import '../widget/trial_offer_card.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransferController());
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.transfer.toUpperCase()),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: GetBuilder<TransferController>(
          builder: (controller) {
            if (controller.isLoading.value && controller.playerList.isEmpty) {
              return const TransferShimmer();
            }

            return RefreshIndicator(
              onRefresh: () => controller.fetchPlayers(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    //   child: CommonText(
                    //     text: AppString.trending.toUpperCase(),
                    //     color: AppColors.primaryColor,
                    //     fontSize: 20.sp,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    SizedBox(height: 20.h),
                    // SizedBox(
                    //   height: 200.h,
                    //   child: ListView.builder(
                    //     padding: const EdgeInsets.symmetric(horizontal: 16),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: controller.playerList.length,
                    //     itemBuilder: (context, index) {
                    //       final player = controller.playerList[index];
                    //       return Padding(
                    //         padding: EdgeInsets.only(right: 12.w),
                    //         child: PlayerCard(
                    //           imageUrl: player.profile ?? '',
                    //           status: player.verified ? 'VERIFIED' : 'PENDING',
                    //           position: player.role,
                    //           age: 22,
                    //           playerName: player.userName,
                    //           academyName: 'ENG ACADEMY',
                    //           price: '8400',
                    //           onTap: () {
                    //             Get.toNamed(AppRoutes.playerProfileDetailsScreen);
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: 32.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                      child: CommonText(
                        text: AppString.recentOffers.toUpperCase(),
                        color: AppColors.primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.playerList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final player = controller.playerList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: TrialOfferCard(
                            playerImageUrl: player.profile ?? '',
                            title: player.userName,
                            // matchPercentage: '92%',
                            description:
                                'Personal terms agreed. Medical scheduled for final test',
                            onOfferTap: () {
                              Get.toNamed(AppRoutes.playerProfileDetailsScreen,
                                  arguments: player.id);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
