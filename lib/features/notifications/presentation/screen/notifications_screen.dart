import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import '../controller/notifications_controller.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (LocalStorage.isGuest) {
      return const Scaffold(body: Center(child: Text("Login Required")));
    }

    final controller = Get.put(NotificationsController());
    controller.getUnreadCount(); // Refresh count when screen opens
    
    return Scaffold(
      appBar: SecondaryAppBar(
        title: AppString.notifications,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.notifications.isEmpty) {
          return const Center(child: Text("No notifications available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshNotifications(),
          child: Column(
            children: [
              if (controller.unreadCount.value > 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => controller.markAllAsRead(),
                      child: const CommonText(
                        text: "Mark all as read",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.yellow,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  controller: controller.scrollController, 
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  itemBuilder: (context, index) {
                    if (index < controller.notifications.length) {
                      final notification = controller.notifications[index];
                      return GestureDetector(
                        onTap: () {
                          if (!notification.isRead) {
                            controller.markAsRead(notification.id);
                          }
                        },
                        child: Opacity(
                          opacity: notification.isRead ? 0.6 : 1.0,
                          child: NotificationCard(
                            alertType: notification.type,
                            timeAgo: notification.timeAgo,
                            title: notification.title,
                            subtitle: notification.message,
                            color: index % 2 == 0 ? AppColors.color19CA77 : AppColors.colorB6A0FF,
                            iconImage: index % 2 == 0 ? AppIcons.iconPeople : AppIcons.iconReload,
                            onViewDetails: () {
                              if (!notification.isRead) {
                                controller.markAsRead(notification.id);
                              }
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: controller.isLoadingMore.value 
                      ? controller.notifications.length + 1 
                      : controller.notifications.length,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
