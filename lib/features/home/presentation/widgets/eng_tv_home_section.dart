import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/eng_tv_flow/presentation/widget/video_thumbnail_card.dart';
import 'package:untitled/features/home/presentation/controllers/banner_controller.dart';
import 'package:untitled/features/navbar/controller/navbar_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/text/common_text.dart';

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
                CommonText(
                  text: "ENG TV",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: titleColor,
                ),
                InkWell(
                  onTap: () {
                    navBarController.selectedIndex.value = 3; // Index for ENG TV tab in NavBarController
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonText(
                        text: "View All",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: viewAllColor ?? AppColors.primaryColor,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        AppIcons.arrowRight,
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
              thumbnail: "${ApiEndPoint.imageUrl}${firstVideo.thumbnail}",
              title: firstVideo.title,
              duration: 'LIVE',
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
