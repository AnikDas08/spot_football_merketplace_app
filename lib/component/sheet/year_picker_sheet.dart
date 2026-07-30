import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

void showYearPickerSheet(
  BuildContext context, {
  required String title,
  required String selectedYear,
  required Function(String) onSelect,
}) {
  final int currentYear = DateTime.now().year;
  final List<String> years = List.generate(10, (index) => (currentYear - index).toString());

  Get.bottomSheet(
    Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h, bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.colorEABB00, width: 1),
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 20.sp),
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 44), 
              ],
            ),
          ),
          
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: years.length,
              separatorBuilder: (context, index) => Divider(
                height: 1.h, 
                color: Colors.grey.withValues(alpha: 0.1),
              ),
              itemBuilder: (context, index) {
                final year = years[index];
                final isSelected = year == selectedYear;

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  title: CommonText(
                    text: year,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? AppColors.primaryColor : Colors.black,
                    textAlign: TextAlign.start,
                  ),
                  trailing: isSelected 
                      ? const Icon(Icons.check_circle, color: AppColors.colorEABB00)
                      : Icon(Icons.chevron_right, color: Colors.grey, size: 18.sp),
                  onTap: () {
                    onSelect(year);
                    Get.back();
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
