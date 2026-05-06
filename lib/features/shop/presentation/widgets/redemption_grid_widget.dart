import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/shop/presentation/widgets/redemption_item_widget.dart';

import '../../../../utils/constants/app_string.dart';
import '../../../../utils/constants/temp_image.dart';

class RedemptionGridWidget extends StatelessWidget {
  final bool isCoffee;
  const RedemptionGridWidget({super.key, this.isCoffee = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: .90,
      ),
      itemBuilder: (_, index) {
        if (isCoffee) {
          return RedemptionItemWidget(
            title: index % 2 == 0 ? AppString.engWristBand : "ENG COFFEE CUP",
            image: index % 2 == 0
                ? TempImage.product
                : TempImage.product, // Should use coffee image if available
            coins: "5000",
          );
        }
        return const RedemptionItemWidget();
      },
    );
  }
}
