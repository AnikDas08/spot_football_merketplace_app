import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/add_player_controller.dart';

import 'package:google_fonts/google_fonts.dart';

class ActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onResetTap;
  final ValueChanged<String>? onSearchChanged;

   ActionAppBar({
    super.key,
    required this.title,
    this.onResetTap,
    this.onSearchChanged,
  });

  final AddPlayerController controller = Get.find<AddPlayerController>();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16.w,
        right: 16.w,
        bottom: 22.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.colorEABB00),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14.sp),
                        SizedBox(width: 6.w),
                        CommonText(text: 'Back', fontSize: 16, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                // Title
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: onResetTap,
                  child: SizedBox(
                    width: 70.w,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CommonText(
                        text: 'Reset',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorEABB00,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.colorEABB00, width: 1.w),
            ),
            child: TextField(
              controller: controller.searchController,
              onChanged: onSearchChanged,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: 'Search for a player',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 22.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(140.h); // Increased height to fit search bar
}