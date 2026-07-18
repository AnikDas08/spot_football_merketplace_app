import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_icons.dart';
import '../../utils/constants/app_images.dart';

import '../../features/notifications/presentation/controller/notifications_controller.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final NotificationsController notificationsController = Get.put(NotificationsController());

    return AppBar(
      leadingWidth: 110.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Image.asset(AppImages.appLogo, height: 25.h),
      ),
      toolbarHeight: 80.h,
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: CommonText(
        text: title.toUpperCase(),
        color: AppColors.white,
        fontSize: 20.sp,
        maxLines: 1,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      ),

      actions: [
        Obx(() => Stack(
          children: [
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.color373737,
                side: const BorderSide(color: AppColors.colorEABB00, width: 1),
              ),
              color: AppColors.white,
              onPressed: () {
                Get.toNamed(AppRoutes.notifications);
              },
              icon: SvgPicture.asset(AppIcons.notification),
            ),
            if (notificationsController.unreadCount.value > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${notificationsController.unreadCount.value}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        )),
        IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.color373737,
            side: const BorderSide(color: AppColors.colorEABB00, width: 1),
          ),
          color: AppColors.white,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset(AppIcons.menu),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
