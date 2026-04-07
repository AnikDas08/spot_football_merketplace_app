import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/component/text/common_text.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_string.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final bool showLeading;

  const CommonAppbar({
    super.key,
    this.titleText,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,

      leadingWidth: 120.w,
      leading: showLeading
          ? Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Image.asset(
          AppImages.appLogo,
          width: 91.w,
          fit: BoxFit.contain,
        ),
      )
          : null,

      centerTitle: true,
      title: CommonText(
        text: titleText ?? "",
        color: AppColors.white,
        fontSize: 21.sp,
        fontWeight: FontWeight.w600,
      ),

      actions: [
        _buildActionButton(icon: AppIcons.notification, onTap: () {}),
        SizedBox(width: 12.w),
        _buildActionButton(icon: AppIcons.menu, onTap: () {}),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildActionButton({required String icon, required VoidCallback onTap}) {
    return Center(
      child: Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          color: AppColors.color373737,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset(
            icon,
            width: 20.w,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}