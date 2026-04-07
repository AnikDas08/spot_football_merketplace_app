import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/notifications/presentation/widgets/notification_item.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.notifications),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          padding: .symmetric(horizontal: 16, vertical: 10),
          itemBuilder: (context, index) => index % 2 == 0
              ? NotificationCard(
                  alertType: AppString.transfer,
                  timeAgo: AppString.twoMinutesAgo,
                  title: AppString.neonUnitedAddsNewMidfielder,
                  subtitle:
                      AppString.grealishOfficialjoinsTheStartingXIforSunday,
                  color: AppColors.color19CA77,
                  iconImage: AppIcons.iconPeople,
                )
              : NotificationCard(
                  alertType: AppString.feature,
                  timeAgo: AppString.twoMinutesAgo,
                  title: AppString.neonUnitedAddsNewMidfielder,
                  subtitle:
                      AppString.grealishOfficialjoinsTheStartingXIforSunday,
                  color: AppColors.colorB6A0FF,
                  iconImage: AppIcons.iconReload,
                ),
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemCount: 10,
        ),
      ),
    );
  }
}
