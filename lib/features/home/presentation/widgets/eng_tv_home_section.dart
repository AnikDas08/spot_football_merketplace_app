import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../eng_tv_flow/presentation/widget/video_thumbnail_card.dart';
import '../../../navbar/controller/navbar_controller.dart';
import '../controllers/banner_controller.dart';

class EngTvHomeSection extends StatelessWidget {
  final Color? titleColor;
  final Color? viewAllColor;
  const EngTvHomeSection({super.key, this.titleColor, this.viewAllColor});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());
    final navBarController = Get.find<NavBarController>();

    return Obx(() {
      if (bannerController.isLoading.value && bannerController.bannerVideos.isEmpty) {
        return const SizedBox.shrink();
      }

      if (bannerController.bannerVideos.isEmpty) {
        return const SizedBox.shrink();
      }

      final firstVideo = bannerController.bannerVideos.first;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Eng TV",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: titleColor ?? AppColors.primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    navBarController.selectedIndex.value = 3; // Index for ENG TV tab in NavBarController
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppString.viewAll,
                        style: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: viewAllColor ?? AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        AppIcons.arrowRight,
                        height: 18.h,
                        colorFilter: viewAllColor != null
                            ? ColorFilter.mode(viewAllColor!, BlendMode.srcIn)
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: VideoThumbnailCard(
              thumbnail: firstVideo.thumbnail.isNotEmpty
                  ? "${ApiEndPoint.imageUrl}${firstVideo.thumbnail}"
                  : '',
              videoUrl: "${ApiEndPoint.videoUrl}${firstVideo.videoUrl}",
              title: firstVideo.title,
              onWatchNow: () {
                Get.toNamed(AppRoutes.videoStreamScreen, arguments: firstVideo.id);
              },
            ),
          ),
        ],
      );
    });
  }
}
