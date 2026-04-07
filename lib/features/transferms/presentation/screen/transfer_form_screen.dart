import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/text_field/common_text_field.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import '../../../../component/common_dropdown_field/common_dropdown_field.dart';
import '../controller/transfer_form_controller.dart';
import '../widget/offer_summary_card.dart';
import '../widget/secondary_appbar.dart';

class TransferFormScreen extends StatelessWidget {
  TransferFormScreen({super.key});

  final TransferFormController controller = Get.find<TransferFormController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'Transfers Form'),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonButton(
              buttonWidth: 160.w,
              titleSize: 16,
              buttonHeight: 44,
              titleWeight: FontWeight.w600,
              padding: EdgeInsets.all(0),
              titleText: "Permanent",
              buttonColor: AppColors.primaryColor,
              onTap: () {},
            ),
            SizedBox(height: 28.h),

            CommonTextField(
              borderColor: AppColors.white,
              title: "Transfer Fee (ENG Coins)",
              hintText: "ENG Coins 0.00",
              controller: controller.transFeeController,
            ),

            SizedBox(height: 24.h),

            Obx(
              () => CommonDropdownField<String>(
                paddingVertical: 14.5.h,
                title: "Contract Duration",
                hintText: "Select Season",
                value: controller.selectedDuration.value.isEmpty
                    ? null
                    : controller.selectedDuration.value,

                items: ["1 Season", "2 Seasons", "3 Seasons"].map((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 15.sp,
                        fontWeight: .w500,
                      ),
                    ),
                  );
                }).toList(),

                onChanged: (newValue) {
                  controller.selectedDuration.value = newValue ?? "";
                },
              ),
            ),
            SizedBox(height: 28.h),

            OfferSummaryCard(
              totalCoins: "€1.2M",
              waceImpact: "€0.5M",
              probability: "85%",
              onSubmit: () {
                Get.toNamed(AppRoutes.transferPendingApproval);
              },
            ),
          ],
        ),
      ),
    );
  }
}
