import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../home/data/video_model.dart';
import '../../../home/presentation/widgets/latest_videos.dart';
import '../widget/video_thumbnail_card.dart';
import 'package:get/get.dart';
import '../../../home/presentation/controllers/banner_controller.dart';

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
    final Map<String, String> categoryTitles = {
      'goals_of_the_week': 'Goals Of The Week',
      'league_highlights': 'League Highlights',
      'save_of_the_week': 'Save Of The Week',
      'ref_cam': 'Ref Cam',
      'coach_cam': 'Coach Cam',
      'eng_sln_binge': 'ENG SIn Bin',
    };

    final List<String> categoryOrder = [
      'goals_of_the_week',
      'league_highlights',
      'save_of_the_week',
      'ref_cam',
      'coach_cam',
      'eng_sln_binge',
    ];

    final List<Color> sectionBgColors = [
      AppColors.black,
      const Color(0xFFF9F9F9),
      Colors.white,
    ];

    return SafeArea(
      child: GetBuilder<BannerController>(
        builder: (controller) {
          if (controller.isLoading.value && controller.bannerVideos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          final videos = controller.bannerVideos;
          if (videos.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => controller.fetchBannerVideos(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 0.8.sh,
                  child: const Center(
                    child: CommonText(text: "No videos available"),
                  ),
                ),
              ),
            );
          }

          final firstVideo = videos.first;

          // Group videos by category
          Map<String, List<VideoModel>> groupedVideos = {};
          for (var video in videos) {
            String cat = video.category;
            if (!groupedVideos.containsKey(cat)) groupedVideos[cat] = [];
            groupedVideos[cat]!.add(video);
          }

          // Decide the order of display
          // 1. Predefined categories in order
          // 2. Any other categories found in data
          List<String> displayOrder = [];
          for (var key in categoryOrder) {
            // Match case-insensitively
            String? actualKey;
            for (var k in groupedVideos.keys) {
              if (k.toLowerCase().replaceAll(' ', '_') == key.toLowerCase() || 
                  k.toLowerCase() == categoryTitles[key]?.toLowerCase()) {
                actualKey = k;
                break;
              }
            }
            
            if (actualKey != null && groupedVideos[actualKey]!.isNotEmpty) {
              displayOrder.add(actualKey);
            }
          }

          // Add categories that were not in the predefined list
          for (var cat in groupedVideos.keys) {
            if (!displayOrder.contains(cat)) {
              displayOrder.add(cat);
            }
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchBannerVideos(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    backgroundColor: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: CommonText(
                            text: "FEATURED",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: VideoThumbnailCard(
                            thumbnail: firstVideo.thumbnail,
                            title: firstVideo.title,
                            duration: '0:0',
                            onWatchNow: () {
                              Get.toNamed(
                                AppRoutes.videoStreamScreen,
                                arguments: firstVideo.id,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dynamic categories
                  ...List.generate(displayOrder.length, (index) {
                    final catName = displayOrder[index];
                    final videosInCat = groupedVideos[catName]!;
                    
                    final bgColor = sectionBgColors[index % sectionBgColors.length];
                    final titleColor = bgColor == AppColors.black ? Colors.white : null;

                    // Get a friendly title if predefined, else use raw name
                    String displayTitle = catName;
                    String? predefinedKey;
                    for (var entry in categoryTitles.entries) {
                      if (entry.value.toLowerCase() == catName.toLowerCase()) {
                        predefinedKey = entry.key;
                        break;
                      }
                    }

                    if (predefinedKey != null) {
                      displayTitle = categoryTitles[predefinedKey]!;
                    }

                    return _buildSection(
                      backgroundColor: bgColor,
                      child: LatestVideos(
                        title: displayTitle,
                        titleColor: titleColor,
                        videos: videosInCat,
                      ),
                    );
                  }),
                  
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required Widget child,
    required Color backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h),
      child: child,
    );
  }
}
