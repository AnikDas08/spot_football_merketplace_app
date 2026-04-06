import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/component/text/common_text.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_string.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      bottom: null,
      backgroundColor: AppColors.primaryColor,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Image.asset(AppImages.appLogo, width: 91.w),
          Spacer(),
          CommonText(
            text: AppString.community,
            color: AppColors.white,
            fontSize: 21.sp,
          ),
          Spacer(),
        ],
      ),
      actions: [
        IconButton.filled(
          style: IconButton.styleFrom(backgroundColor: AppColors.color373737),
          color: AppColors.white,
          onPressed: () {},
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
