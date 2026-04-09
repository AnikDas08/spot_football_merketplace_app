import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoutes.newsDetails);
      },
      child: Card(
        color: AppColors.white,
        child: Container(
          padding: .all(10),
          child: Row(
            crossAxisAlignment: .start,
            spacing: 10,
            children: [
              Image.asset(TempImage.news),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    CommonText(
                      text: AppString.feature,
                      fontSize: 16.sp,
                      fontWeight: FontWeight(590),
                    ),
                    CommonText(
                      textAlign: .start,
                      maxLines: 2,
                      text:
                      AppString.engCommunityAcademyStarOfTheWeek,
                      fontSize: 16.sp,
                      fontWeight: FontWeight(510),
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
}
