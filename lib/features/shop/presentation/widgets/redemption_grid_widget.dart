import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../data/reward_response.dart';
import 'redemption_item_widget.dart';

class RedemptionGridWidget extends StatelessWidget {
  final List<RewardProduct> products;
  final bool isLoading;

  const RedemptionGridWidget({
    super.key,
    required this.products,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerGridLoading();
    }

    if (products.isEmpty) {
      return const Center(
        child: Text("No products available"),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.75, // Adjusted for professional look with image and button
      ),
      itemBuilder: (_, index) {
        return RedemptionItemWidget(
          product: products[index],
        );
      },
    );
  }
}
