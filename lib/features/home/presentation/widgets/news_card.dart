import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/news/data/models/news_model.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

import 'package:untitled/component/image/common_image.dart';

class NewsCard extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? subTitle;
  final double? width;
  final double? height;
  final NewsModel? newsModel;

  const NewsCard({
    super.key,
    this.imagePath,
    this.title,
    this.subTitle,
    this.width,
    this.height,
    this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    final displayImage = newsModel != null
        ? "${ApiEndPoint.imageUrl}${newsModel!.image}"
        : (imagePath ?? TempImage.news);
    
    final displayCategory = newsModel?.category ?? (title ?? AppString.feature);
    final displayTitle = newsModel?.description ?? (subTitle ?? AppString.engCommunityAcademyStarOfTheWeek);

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.newsDetails, arguments: newsModel);
      },
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 248.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            CommonImage(
              imageSrc: displayImage,
              width: double.infinity,
              height: double.infinity,
              fill: BoxFit.cover,
              borderRadius: 12.r,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.white.withAlpha(100),
                          width: 1.5.w,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText(
                          text: displayCategory,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          text: displayTitle,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
