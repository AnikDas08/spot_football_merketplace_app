import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../controller/video_streem_controller.dart';
import '../widget/custom_video_player.dart';
import '../widget/video_news_card.dart';

class VideoStreamScreen extends StatelessWidget {
   VideoStreamScreen({super.key});
  final controller = Get.find<VideoStreamController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomVideoPlayer(
                videoUrl:
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
              ),
          
              SizedBox(height: 24.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
          
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPlayerTag(
                          name: "Richarlison",
                          image: TempImage.playerProfile2,
                          borderColor: AppColors.color6B6B6B,
                        ),
                        SizedBox(width: 6.h),
          
                        _buildPlayerTag(
                          name: "Virtu Arik",
                          image: TempImage.stats3,
                          borderColor: AppColors.color6B6B6B,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
          
                    CommonText(
                      text:
                          "Watch: One moment of Salah magic from every season at Liverpool"
                              .toUpperCase(),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                    ),
          
                    SizedBox(height: 8.h),
          
                    CommonText(
                      text:
                          "Enjoy the Egyptian's best goals from his last nine seasons at Liverpool"
                              .toUpperCase(),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.color6B6B6B,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                    ),
          
                    SizedBox(height: 12.h),
          
                    CommonText(
                      text: "21 Mar 2026".toUpperCase(),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.color6B6B6B,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 24.h),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
          
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "related".toUpperCase(),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 5.h),
          
                          Container(
                            height: 1.h,
                            width: 75.w,
                            decoration: BoxDecoration(color: AppColors.yellow),
                          ),
                          SizedBox(height: 5.h),
          
                          ListView.builder(
                            itemCount: controller.videoList.length,
                            shrinkWrap: true,
          
                            physics:  NeverScrollableScrollPhysics(), 
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            itemBuilder: (context, index) {
                              final item =controller. videoList[index];
          
                              return VideoNewsCard(
                                title: item["title"]!,
                                description: item["description"]!,
                                timeAgo: item["timeAgo"]!,
                                imageUrl: item["image"]!,
                                onTap: () {
                                  print("Tapped on index $index");
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerTag({
    required String name,
    required String image,
    Color borderColor = const Color(0xFFCCCCCC),
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 5.r),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              image,
              height: 14.h,
              width: 14.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 6.w),
          CommonText(
            text: name.toUpperCase(),
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: AppColors.primaryColor,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

PreferredSize buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 20.w,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 10.r),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.color2A2A2A, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    ),
  );
}
