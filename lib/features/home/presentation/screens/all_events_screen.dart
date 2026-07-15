import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_event_card.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../controllers/event_controller.dart';

import 'package:untitled/component/blur_reveal/blur_reveal.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    final dynamic args = Get.arguments;
    final String title = (args is Map && args.containsKey('title')) 
        ? args['title'] 
        : AppString.upcomingEvents;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: title.toUpperCase()),
      body: Obx(() {
        if (controller.isLoading.value && controller.eventList.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.eventList.isEmpty) {
          return const Center(child: Text("No events available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchEvents(),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(16.w),
                  itemCount: controller.eventList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final event = controller.eventList[index];
                    return BlurReveal(
                      duration: const Duration(milliseconds: 500),
                      initialBlur: 5,
                      child: UpcomingEventCard(event: event),
                    );
                  },
                ),
              ),
              if (controller.isMoreLoading.value)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                ),
            ],
          ),
        );
      }),
    );
  }
}
