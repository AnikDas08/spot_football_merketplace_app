import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/shop/presentation/controllers/shop_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/extensions/extension.dart';
import '../widgets/redemption_grid_widget.dart';
import '../widgets/shop_tab_widget.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final controller = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: 'SHOP'),
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
                return RedemptionGridWidget(
                  products: controller.productList,
                  isLoading: controller.isLoading.value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
