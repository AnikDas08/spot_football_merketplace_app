import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../component/blur_reveal/blur_reveal.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import '../controllers/event_controller.dart';
import 'upcoming_event_card.dart';

class UpcomingEvents extends StatefulWidget {
  final Color? titleColor;
  const UpcomingEvents({super.key, this.titleColor});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  final RxInt _currentPage = 0.obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_pageController.hasClients) {
        final eventController = Get.find<EventController>();
        final int totalItems = eventController.eventList.length > 5 ? 5 : eventController.eventList.length;

        if (totalItems > 1) {
          int nextPage = _currentPage.value + 1;
          if (nextPage >= totalItems) {
            nextPage = 0;
            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          } else {
            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlurReveal(
      key: const ValueKey('upcoming_events_reveal'),
      duration: const Duration(milliseconds: 800),
      initialBlur: 10,
      child: GetBuilder<EventController>(
        builder: (controller) {
          return Obx(() {
            if (controller.isLoading.value && controller.eventList.isEmpty) {
              return _buildShimmer();
            }

            if (controller.eventList.isEmpty) {
              return const SizedBox.shrink();
            }

            final displayList = controller.eventList.length > 5 ? controller.eventList.take(5).toList() : controller.eventList;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Expanded(
                        child: Text(
                          AppString.upcomingEvents,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: widget.titleColor ?? AppColors.primaryColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.allEvents, arguments: {'title': AppString.upcomingEvents});
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppString.viewAll,
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: widget.titleColor == AppColors.white ? AppColors.yellow : AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              AppIcons.arrowRight,
                              height: 18.h,
                              colorFilter: ColorFilter.mode(
                                widget.titleColor == AppColors.white ? AppColors.yellow : AppColors.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                /// Carousel Slider using PageView
                SizedBox(
                  width: double.infinity,
                  height: 460.h,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: displayList.length,
                    onPageChanged: (index) => _currentPage.value = index,
                    itemBuilder: (context, index) {
                      final event = displayList[index];
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          try {
                            if (_pageController.hasClients && _pageController.page != null) {
                              value = _pageController.page! - index;
                              value = (1 - (value.abs() * 0.05)).clamp(0.0, 1.0);
                            }
                          } catch (_) {}
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: SizedBox(
                                height: Curves.easeOut.transform(value) * 450.h,
                                width: double.infinity,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: UpcomingEventCard(
                          event: event,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                /// Custom Pagination Dots
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        displayList.length,
                        (index) => _buildDot(index == _currentPage.value),
                      ),
                    )),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    final bool isDarkBackground = widget.titleColor == AppColors.white;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive
            ? (isDarkBackground ? AppColors.yellow : AppColors.primaryColor)
            : (isDarkBackground
                ? AppColors.white.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomShimmer.rectangular(height: 24.h, width: 150.w),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 450.h,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.92),
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: const UpcomingEventCard(isLoading: true),
            ),
          ),
        ),
      ],
    );
  }
}
