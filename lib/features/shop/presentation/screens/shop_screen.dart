import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../../utils/extensions/extension.dart';
import '../controllers/shop_controller.dart';
import '../widgets/redemption_grid_widget.dart';
import '../widgets/shop_tab_widget.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final controller = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: 'Shop'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          const ShopTabWidget(),
          20.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() => CommonText(
              text: controller.selectedTab.value == 2 ? "My Order History" : AppString.prizeRedemptionFeed,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            )),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: GetBuilder<ShopController>(
              builder: (controller) {
                if (controller.isLoading.value && 
                    (controller.selectedTab.value == 2 ? controller.myOrdersList.isEmpty : controller.productList.isEmpty)) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                }

                if (controller.selectedTab.value == 2) {
                  return _buildOrdersList(controller);
                }

                return SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      RedemptionGridWidget(
                        products: controller.productList,
                        isLoading: false,
                      ),
                      if (controller.isMoreLoading.value)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(ShopController controller) {
    if (controller.myOrdersList.isEmpty) {
      return const Center(child: CommonText(text: "No orders found."));
    }

    return ListView.separated(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: controller.myOrdersList.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final order = controller.myOrdersList[index];
        final product = order['rewardProduct'];
        final dateStr = order['createdAt'] ?? "";
        String formattedDate = "N/A";
        if (dateStr.isNotEmpty) {
          try {
            final date = DateTime.parse(dateStr);
            formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(date);
          } catch (_) {}
        }

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.colorEABB00.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: product?['brand'] ?? 'Reward',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: CommonText(
                      text: order['status']?.toString().toUpperCase() ?? 'PENDING',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey),
                  SizedBox(width: 8.w),
                  CommonText(
                    text: formattedDate,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              const Divider(),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: "Points Redeemed",
                    fontSize: 13,
                    color: AppColors.color6B6B6B,
                  ),
                  CommonText(
                    text: "${product?['point'] ?? 0} Coins",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.yellow,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
