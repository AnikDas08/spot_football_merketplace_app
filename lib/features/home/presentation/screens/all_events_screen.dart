import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_event_card.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../controllers/event_controller.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.upcomingEvents.toUpperCase()),
      body: Obx(() {
        if (controller.isLoading.value && controller.eventList.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.eventList.isEmpty) {
          return const Center(child: Text("No events available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchEvents(),
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.eventList.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final event = controller.eventList[index];
              return UpcomingEventCard(event: event);
            },
          ),
        );
      }),
    );
  }
}
