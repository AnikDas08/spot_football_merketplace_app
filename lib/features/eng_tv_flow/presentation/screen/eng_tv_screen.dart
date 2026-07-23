import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/helpers/video_metadata_helper.dart';
import '../../../home/data/video_model.dart';
import '../../../home/presentation/controllers/banner_controller.dart';
import '../../../home/presentation/widgets/latest_videos.dart';
import '../widget/video_thumbnail_card.dart';

class EngTvScreen extends StatelessWidget {
  const EngTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> sectionBgColors =  [
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
            String cat = VideoMetadataHelper.formatCategory(video.category);
            if (!groupedVideos.containsKey(cat)) groupedVideos[cat] = [];
            groupedVideos[cat]!.add(video);
          }

          final List<String> displayOrder = groupedVideos.keys.toList();

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
                          child: Text(
                            "Featured",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: VideoThumbnailCard(
                            thumbnail: firstVideo.thumbnail.isNotEmpty
                                ? "${ApiEndPoint.imageUrl}${firstVideo.thumbnail}"
                                : '',
                            videoUrl: "${ApiEndPoint.videoUrl}${firstVideo.videoUrl}",
                            title: firstVideo.title,
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

                    return _buildSection(
                      backgroundColor: bgColor,
                      child: LatestVideos(
                        title: catName,
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
