import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../widget/latest_highlight_card.dart';
import '../../../home/presentation/widgets/latest_video_card.dart';
import '../widget/upcoming_match_card.dart';
import '../widget/video_thumbnail_card.dart';
import 'package:get/get.dart';
import '../../../home/presentation/controllers/banner_controller.dart';
import '../../../../component/image/common_image.dart';
import 'package:intl/intl.dart';

String timeago(DateTime date) {
  Duration diff = DateTime.now().difference(date);
  if (diff.inDays > 365) return "${(diff.inDays / 365).floor()}y ago";
  if (diff.inDays > 30) return "${(diff.inDays / 30).floor()}mo ago";
  if (diff.inDays > 0) return "${diff.inDays}d ago";
  if (diff.inHours > 0) return "${diff.inHours}h ago";
  if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
  return "just now";
}

class EngTvScreen extends StatelessWidget {
  const EngTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
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
        child: GetBuilder<BannerController>(
          builder: (controller) {
            if (controller.isLoading.value && controller.bannerVideos.isEmpty) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
            }

            final videos = controller.bannerVideos;
            if (videos.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => controller.fetchBannerVideos(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: 0.8.sh,
                    child: const Center(child: CommonText(text: "No videos available")),
                  ),
                ),
              );
            }

            final firstVideo = videos.first;

            return RefreshIndicator(
              onRefresh: () => controller.fetchBannerVideos(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: VideoThumbnailCard(
                        thumbnail: firstVideo.thumbnail,
                        title: firstVideo.title,
                        duration: 'LIVE', 
                        onWatchNow: () {
                          Get.toNamed(AppRoutes.videoStreamScreen, arguments: firstVideo.id);
                        },
                      ),
                    ),

                    SizedBox(height: 10.h),
                    LatestVideos(),
                    SizedBox(height: 16.h),

                    LatestVideos( title : "Goal Countdown"),


                    SizedBox(height: 16.h),
                    Container(
                      margin: EdgeInsets.only(left: 16.w),
                      child: CommonText(
                        text: "Scheduled Broadcasts",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
            );
          },
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
          CommonText(
            text: title,
            fontSize: 20,
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
                    fontSize: 16,
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
