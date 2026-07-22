import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
            child: CommonText(
              text: AppString.prizeRedemptionFeed,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: GetBuilder<ShopController>(
              builder: (controller) {
                if (controller.isLoading.value && controller.productList.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
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
}
