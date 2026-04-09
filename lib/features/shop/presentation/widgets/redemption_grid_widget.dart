import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/shop/presentation/widgets/redemption_item_widget.dart';

class RedemptionGridWidget extends StatelessWidget {
  const RedemptionGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: .780.h,
      ),
      itemBuilder: (_, __) => const RedemptionItemWidget(),
    );
  }
}