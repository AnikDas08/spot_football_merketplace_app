import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../controllers/shop_controller.dart';
import '../data/reward_response.dart';

class RedemptionItemWidget extends StatelessWidget {
  final RewardProduct? product;

  const RedemptionItemWidget({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShopController>();
    
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
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
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
          SizedBox(
            height: 20.h,
            child: CommonText(
              text: product?.productType ?? '',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 4.h),
          const Divider(height: 1),
          SizedBox(height: 8.h),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
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
                fontSize: 11,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w400,
              ),
              CommonText(
                text: " ${product?.point ?? 0}",
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.yellow,
                fontFamily: 'Montserrat',
              ),
            ],
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: () {
              if (product?.id != null) {
                controller.redeemProduct(product!.id!);
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.colorEABB00, width: 1.w),
              ),
              child: controller.isRedeeming.value 
                ? SizedBox(height: 14.h, width: 14.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : CommonText(
                    text: AppString.redeem,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
