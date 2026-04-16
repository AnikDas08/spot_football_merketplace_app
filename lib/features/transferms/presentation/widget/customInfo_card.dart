import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class CustomInfoCard extends StatelessWidget {
  final String title;
  final String statusImage;
  final Map<String, String> details;

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.statusImage,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final entries = details.entries.toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
          color: const Color(0xFFF2F2F2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: title.toUpperCase(),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),

            ],
          ),

          Divider(color: Colors.grey.shade200, height: 32.h, thickness: 1),

          Column(
            children: List.generate(entries.length, (index) {
              final entry = entries[index];
              return Column(
                children: [
                  _buildItem(entry.key, entry.value),
                  SizedBox(height: 14.h),
                  if (index != entries.length - 1)
                    Divider(
                        color: Colors.grey.shade200,
                        height: 1.h,
                        thickness: 1
                    ),
                  if (index != entries.length - 1)
                    SizedBox(height: 14.h),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: label,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.color373737,
              textAlign: TextAlign.start,
            ),
          ),
          CommonText(
            text: value,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}