import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/button/common_button.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../widget/contract_duration_result_card.dart';
import '../widget/player_profile_card.dart';
import '../widget/transfer_fee_card.dart';

class TransferPendingApproval extends StatelessWidget {
  const TransferPendingApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: "pending approval"),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,

                child: Column(
                  children: [
                    SizedBox(height: 32.h),

                    SvgPicture.asset(
                      AppIcons.checkMark,
                      width: 90.w,
                      height: 90.w,
                    ),
                    SizedBox(height: 24.h),

                    CommonText(
                      text: "Offer Submitted",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),

                    CommonText(
                      text:
                          "Your transfer offer for Marcus Vancore is pending admin approval and team response.",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      maxLines: 3,
                    ),
                    SizedBox(height: 24.h),

                    PlayerProfileCard(
                      playerName: "Marcus Vancore",
                      playerRole: "Forward |",
                      playerAcademy: "  Manchester City Academy",
                      playerImageUrl: TempImage.playerProfile2,
                      isCheckCard: false,
                    ),

                    SizedBox(height: 16.h),

                    TransferFeeCard(
                      title: "TRANSFER FEE",
                      feeAmount: "ENG Coins 10000",
                      subTitle: "Payable over 3 installments",
                    ),
                    SizedBox(height: 16.h),
                    ContractDurationResultCard(
                      durationTitle: "CONTRACT DURATION",
                      yearsText: "5 YEARS",
                      dateText: "Until June 2029",
                      iconPath: AppIcons.checkMark,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              CommonButton(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                titleText: "Back to Transfers",
                buttonColor: AppColors.transparent,
                borderColor: AppColors.color6B6B6B,
                titleColor: AppColors.primaryColor,
                titleSize: 18,
                titleWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
