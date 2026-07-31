import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../component/image/common_image.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controllers/club_profile_controller.dart';
import '../../data/gallery_model.dart';

import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/extensions/extension.dart';

import 'slideable_image_viewer.dart';

class GallerySection extends StatelessWidget {
  final Color? titleColor;
  const GallerySection({super.key, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClubProfileController>(
      builder: (controller) {
        if (controller.galleryList.isEmpty) {
          return const SizedBox.shrink();
        }

        // Limit to 6 items for the home screen grid
        final displayList = controller.galleryList.length > 6 
            ? controller.galleryList.take(6).toList() 
            : controller.galleryList;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Pictures Of The Week'.toTitleCase(),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? AppColors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.allGallery);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppString.viewAll,
                          style: GoogleFonts.playfairDisplay(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: titleColor == AppColors.primaryColor ? AppColors.primaryColor : AppColors.yellow,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(
                          AppIcons.arrowRight,
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            titleColor == AppColors.primaryColor ? AppColors.primaryColor : AppColors.yellow,
                            BlendMode.srcIn,
                          ),
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
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.w,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 1,
                ),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final item = displayList[index];
                  final isLast = index == 5 && controller.galleryList.length > 6;

                  return GestureDetector(
                    onTap: () {
                      if (isLast) {
                        Get.toNamed(AppRoutes.allGallery);
                      } else {
                        SlideableImageViewer.show(
                          context, 
                          controller.galleryList.map((e) => e.image).toList(), 
                          index
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CommonImage(
                              imageSrc: item.image,
                              fill: BoxFit.cover,
                              borderRadius: 8.r,
                            ),
                          ),
                          if (isLast)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '+${controller.galleryList.length - 5}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'MORE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
