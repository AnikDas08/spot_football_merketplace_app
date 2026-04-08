import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
import '../widget/leader_boad_card.dart';
import '../widget/season_selector_button.dart';

class SeasonStatsScreen extends StatelessWidget {
  const SeasonStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'season stats'),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),
              SeasonSelectorButton(
                seasonValue: "2024/25",
                onTap: () {
                  // Show season picker or bottom sheet
                },
              ),
          
              SizedBox(height: 24.h),
          
              CommonText(
                text: "goals".toUpperCase(),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
          
              SizedBox(height: 16.h),
          
              LeaderboardCard(
                topPlayerName: "Emerson Royal",
                topPlayerAcademy: "Virtu Academy",
                topPlayerScore: "21",
                topPlayerImage: TempImage.playerProfile2,
                academyPhoto: TempImage.stats3,
                // Image path variable
                otherPlayers: [
                  LeaderboardItemData(academyPhoto:TempImage.stats3 ,rank: "2", name: "Jane Cooper", academy: "Liverpool FC", score: "14"),
                  LeaderboardItemData(academyPhoto:TempImage.stats3,rank: "3", name: "Jane Cooper", academy: "Liverpool FC", score: "12"),
                ],
                onViewFullList: () {},
              ),
          
          
          
              CommonText(
                text: "Most Assists".toUpperCase(),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
          
              SizedBox(height: 16.h),
          
              LeaderboardCard(
                topPlayerName: "Emerson Royal",
                topPlayerAcademy: "Virtu Academy",
                topPlayerScore: "21",
                topPlayerImage: TempImage.playerProfile2,
                academyPhoto: TempImage.stats3,
                // Image path variable
                otherPlayers: [
                  LeaderboardItemData(academyPhoto:TempImage.stats3 ,rank: "2", name: "Jane Cooper", academy: "Liverpool FC", score: "14"),
                  LeaderboardItemData(academyPhoto:TempImage.stats3,rank: "3", name: "Jane Cooper", academy: "Liverpool FC", score: "12"),
                ],
                onViewFullList: () {},
              )
          
          
            ],
          ),
        ),
      ),
    );
  }
}
