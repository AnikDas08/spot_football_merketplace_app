import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Container(
        padding: .all(10),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 10,
          children: [
            Image.asset(AppImages.news),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .start,
                children: [
                  CommonText(
                    text: "Feature",
                    fontSize: 16.sp,
                    fontWeight: FontWeight(590),
                  ),
                  CommonText(
                    textAlign: .start,
                    maxLines: 2,
                    text:
                    "ENG Community Academy Star of the Week-Name:Leo",
                    fontSize: 16.sp,
                    fontWeight: FontWeight(510),
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
