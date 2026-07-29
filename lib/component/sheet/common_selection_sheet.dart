import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';
import '../text_field/common_text_field.dart';

void showCommonSelectionSheet<T>(
  BuildContext context, {
  required String title,
  required Function(String) onSearch,
  required VoidCallback onLoadMore,
  required RxList<T> items,
  required RxBool isLoading,
  required RxBool isMoreLoading,
  required String Function(T) itemLabel,
  required Function(T) onSelect,
  String? Function(T)? itemSubLabel,
}) {
  final scrollController = ScrollController();
  scrollController.addListener(() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      onLoadMore();
    }
  });

  Get.bottomSheet(
    Container(
      height: 0.8.sh,
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
          
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: CommonTextField(
              hintText: "Search...",
              prefixIcon: Container(
                width: 40.w,
                alignment: Alignment.center,
                child: Icon(Icons.search, color: Colors.grey, size: 20.sp),
              ),
              onChanged: onSearch,
              fillColor: AppColors.white,
              borderColor: AppColors.colorEABB00,
              paddingVertical: 12,
              isDense: true,
            ),
          ),
          
          Expanded(
            child: Obx(() {
              if (isLoading.value && items.isEmpty) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
              }
              if (items.isEmpty && !isLoading.value) {
                return Center(
                  child: CommonText(
                    text: "No items found.",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                );
              }
              return ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.all(16.w),
                itemCount: items.length + (isMoreLoading.value ? 1 : 0),
                separatorBuilder: (context, index) => Divider(
                  height: 1.h, 
                  color: Colors.grey.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                    );
                  }
                  final item = items[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    title: CommonText(
                      text: itemLabel(item),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                    subtitle: itemSubLabel != null && itemSubLabel(item) != null
                        ? CommonText(
                            text: itemSubLabel(item)!,
                            fontSize: 12,
                            color: Colors.grey,
                            textAlign: TextAlign.start,
                          )
                        : null,
                    trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 18.sp),
                    onTap: () {
                      onSelect(item);
                      Get.back();
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
