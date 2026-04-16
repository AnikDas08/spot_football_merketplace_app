import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_event_card.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_string.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CommonText(
            text: AppString.upcomingEvents.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: FontWeight(590),
          ),
        ),
        ListView(

          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: .symmetric(horizontal: 16),
          children: [
            UpcomingEventCard(),
            UpcomingEventCard(),
            UpcomingEventCard(),
            UpcomingEventCard(),
          ],
        ),
      ],
    );
  }
}
