import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/news/data/models/news_model.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? subTitle;
  final double? width;
  final double? height;
  final NewsModel? newsModel;
  final bool isLoading;

  const NewsCard({
    super.key,
    this.imagePath,
    this.title,
    this.subTitle,
    this.width,
    this.height,
    this.newsModel,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: width ?? double.infinity,
        height: height ?? 450.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.grey.shade200,
        ),
        child: CustomShimmer.rectangular(
          height: height ?? 450.h,
          width: width ?? double.infinity,
        ),
      );
    }

    final displayImage = newsModel != null
        ? "${ApiEndPoint.imageUrl}${newsModel!.image}"
        : (imagePath ?? TempImage.news);
    
    final displayCategory = newsModel?.category ?? (title ?? "News");
    final displayTitle = newsModel?.title ?? (subTitle ?? "Headline");
    final displayDesc = newsModel?.description ?? "";
    final String formattedDate = newsModel != null 
        ? DateFormat('dd MMM yyyy').format(newsModel!.publishDateTime)
        : "";

    return Container(
      width: width ?? double.infinity,
      height: height ?? 450.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: CommonImage(
                imageSrc: displayImage,
                width: double.infinity,
                height: double.infinity,
                fill: BoxFit.cover,
              ),
            ),

            /// Gradient Overlay (Darker at the bottom)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.95),
                    ],
                    stops: const [0.4, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            /// Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Category & Date
                  CommonText(
                    text: "$displayCategory  •  $formattedDate",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  SizedBox(height: 8.h),

                  /// Headline
                  CommonText(
                    text: displayTitle,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    bottom: 12.h,
                  ),

                  /// Description
                  CommonText(
                    text: displayDesc,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.8),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    bottom: 24.h,
                    fontFamily: 'Montserrat',
                  ),

                  /// Read Button
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.newsDetails, arguments: newsModel),
                    child: Container(
                      width: double.infinity,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                      ),
                      alignment: Alignment.center,
                      child: CommonText(
                        text: "Read",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
