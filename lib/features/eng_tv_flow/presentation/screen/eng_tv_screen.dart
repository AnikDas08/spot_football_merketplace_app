import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import '../../../../utils/constants/app_colors.dart';
import '../widget/latest_highlight_card.dart';
import '../widget/upcoming_match_card.dart';
import '../widget/video_thumbnail_card.dart';
import 'package:get/get.dart';

class EngTvScreen extends StatelessWidget {
  const EngTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> upcomingMatches = [
      {
        'date': 'Oct 24',
        'time': '21:00 PM',
        'matchTitle': 'ROGUE CITY VS UNITED',
        'coverageTime': '20:45 GMT • LIVE COVERAGE',
      },
      {
        'date': 'Oct 25',
        'time': '19:30 PM',
        'matchTitle': 'TITAN ATHLETIC VS VOLTAGE FC',
        'coverageTime': '19:15 GMT • LIVE COVERAGE',
      },
      {
        'date': 'Oct 26',
        'time': '22:00 PM',
        'matchTitle': 'LEAGUE LEVELLERS VS ROGUE CITY',
        'coverageTime': '21:45 GMT • LIVE COVERAGE',
      },
    ];

    return Scaffold(
      appBar: CommonAppbar(title: "ENG TV"),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoThumbnailCard(
                thumbnail: TempImage.thumbnail,
                title: 'Voltage FC vs Titan Athletic',
                duration: '1h 13m',
                onWatchNow: () {
                  Get.toNamed(AppRoutes.videoStreamScreen);
                },
              ),

              SizedBox(height: 28.h),
              _buildSectionHeader("Latest Highlights", () {}),

              SizedBox(height: 10.h),

              SizedBox(
                height: 190.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  padding: EdgeInsets.only(left: 16.w),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.videoStreamScreen);
                        },

                        child: LatestHighlightCard(
                          isCheck: true,
                          imagePath: TempImage.stats1,
                          title: 'Top 10 Goals: Week 24',
                          time: '3h ago',
                          source: 'ENG Original',
                          duration: '7m',
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildSectionHeader("Goal Countdowns", () {}),

              SizedBox(height: 10.h),

              SizedBox(
                height: 190.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  padding: EdgeInsets.only(left: 16.w),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.videoStreamScreen);
                        },
                        child: LatestHighlightCard(
                          isCheck: false,
                          imagePath: TempImage.player2,
                          title: 'Top 20 late ENG ',
                          time: '3h ago',
                          source: '',
                          leagueName: 'league Levellers',
                          duration: '10m',
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16.h),

              Container(
                margin: EdgeInsets.only(left: 16.w),
                child: CommonText(
                  text: "Scheduled Broadcasts",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.h),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: upcomingMatches.length,
                itemBuilder: (context, index) {
                  final match = upcomingMatches[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                    child: UpcomingMatchCard(
                      date: match['date']!,
                      time: match['time']!,
                      matchTitle: match['matchTitle']!,
                      coverageTime: match['coverageTime']!,
                      onNotificationTap: () {},
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Section Title
          CommonText(
            text: title,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            maxLines: 1,
            color: AppColors.primaryColor,
          ),

          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: "View All",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    color: AppColors.primaryColor,
                  ),

                  SizedBox(width: 4.w),

                  SvgPicture.asset(
                    AppIcons.arrowR,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
