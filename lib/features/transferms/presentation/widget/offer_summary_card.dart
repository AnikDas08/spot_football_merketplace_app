import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class OfferSummaryCard extends StatelessWidget {
  final String totalCoins;
  final String waceImpact;
  final String probability;
  final VoidCallback onSubmit;

  const OfferSummaryCard({
    super.key,
    this.totalCoins = "€0.0M",
    this.waceImpact = "€0.0M",
    this.probability = "--",
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Offer Summary",
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 15.h),

          _buildSummaryRow("Total ENG Coins", totalCoins),
          _buildDivider(),
          _buildSummaryRow("WACE Impact", waceImpact),
          _buildDivider(),
          _buildSummaryRow("Probability", probability, isProbability: true),

          SizedBox(height: 32.h),

          // Submit Button
          CommonButton(
            titleText: "Submit Offer",
            buttonColor: AppColors.black,
            onTap: onSubmit,
            buttonWidth: double.infinity,
            buttonHeight: 48,
            titleWeight: FontWeight.w500,
            titleSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value, {
    bool isProbability = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
          CommonText(
            text: value,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: isProbability ? const Color(0xFF00C566) : AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.withOpacity(0.1), thickness: 1);
  }
}
