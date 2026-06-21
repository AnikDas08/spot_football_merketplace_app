import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_event_card.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_string.dart';
import '../controllers/event_controller.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventController());

    return GetBuilder<EventController>(
      builder: (controller) {
        if (controller.isLoading.value && controller.eventList.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomShimmer.rectangular(height: 24.h, width: 180.w),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: List.generate(
                    2,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomShimmer.rectangular(height: 350.h),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (controller.eventList.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonText(
                text: AppString.upcomingEvents.toUpperCase(),
                fontSize: 20.sp,
                fontWeight: const FontWeight(590),
              ),
            ),
            SizedBox(height: 12.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: controller.eventList.length,
              itemBuilder: (context, index) {
                return UpcomingEventCard(event: controller.eventList[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
