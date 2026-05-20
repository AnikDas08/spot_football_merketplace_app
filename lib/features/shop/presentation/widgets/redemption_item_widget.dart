import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../data/reward_response.dart';

class RedemptionItemWidget extends StatelessWidget {
  final RewardProduct? product;

  const RedemptionItemWidget({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    // ইমেজ URL হ্যান্ডেল করা
    String imageUrl = product?.image ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = '${ApiEndPoint.imageUrl}$imageUrl';
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CommonText(
            text: product?.productType ?? '',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          const Divider(),
          SizedBox(height: 8.h),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              // লোডার এর পরিবর্তে শুধুমাত্র শিমার ব্যবহার করা হয়েছে
              placeholder: (context, url) => CustomShimmer.rectangular(
                height: 70.h,
                width: double.infinity,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error_outline),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: AppString.totalCoins,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w400,
              ),
              CommonText(
                text: " ${product?.point ?? 0}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.yellow,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CommonText(
              text: AppString.redeem,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
