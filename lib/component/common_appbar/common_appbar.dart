import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_string.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 120.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: Image.asset(AppImages.appLogo),
      ),
      toolbarHeight: 80.h,
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: CommonText(
        text: AppString.community,
        color: AppColors.white,
        fontSize: 21.sp,
      ),

      actions: [
        IconButton.filled(
          style: IconButton.styleFrom(backgroundColor: AppColors.color373737),
          color: AppColors.white,
          onPressed: () {
            Get.toNamed(AppRoutes.notifications);
          },
          icon: SvgPicture.asset(AppIcons.notification),
        ),
        IconButton.filled(
          style: IconButton.styleFrom(backgroundColor: AppColors.color373737),
          color: AppColors.white,
          onPressed: () {},
          icon: SvgPicture.asset(AppIcons.menu),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
