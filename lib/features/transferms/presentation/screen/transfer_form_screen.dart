import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/component/text_field/common_text_field.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/common_dropdown_field/common_dropdown_field.dart';
import '../controller/transfer_form_controller.dart';
import '../widget/offer_summary_card.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';

class TransferFormScreen extends StatelessWidget {
  TransferFormScreen({super.key});

  final TransferFormController controller = Get.find<TransferFormController>();

  @override
  Widget build(BuildContext context) {

    const String strSeason1 = "1 Season";
    const String strSeason2 = "2 Seasons";
    const String strSeason3 = "3 Seasons";

    const String strTotalCoins = "€1.2M";
    const String strWaceImpact = "€0.5M";
    const String strProbability = "85%";

    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.strAppBarTitle),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonButton(
                buttonWidth: 160.w,
                titleSize: 16,
                buttonHeight: 44,
                titleWeight: FontWeight.w600,
                padding: const EdgeInsets.all(0),
                titleText: AppString.strBtnPermanent,
                buttonColor: AppColors.primaryColor,
                onTap: () {},
              ),
              SizedBox(height: 28.h),

              CommonTextField(
                borderColor: AppColors.white,
                title:AppString. strLblTransferFee,
                hintText:AppString. strHintTransferFee,
                controller: controller.transFeeController,
              ),

              SizedBox(height: 24.h),

              Obx(
                    () => CommonDropdownField<String>(
                  paddingVertical: 14.5.h,
                  title: AppString.strLblContractDuration,
                  hintText: AppString.strHintContractDuration,
                  value: controller.selectedDuration.value.isEmpty
                      ? null
                      : controller.selectedDuration.value,

                  items: [strSeason1, strSeason2, strSeason3].map((
                      String value,
                      ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CommonText(
                      text:   value,

                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,

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
                totalCoins: strTotalCoins,
                waceImpact: strWaceImpact,
                probability: strProbability,
                onSubmit: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}