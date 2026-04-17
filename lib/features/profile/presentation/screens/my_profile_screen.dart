import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../player_profile/presentation/widgets/eng_record_widget.dart';
import '../../../player_profile/presentation/widgets/personal_details_widget.dart';
import '../../../player_profile/presentation/widgets/player_header_widget.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: AppString.myProfile),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PlayerHeaderWidget(),
            SizedBox(height: 16.h),
            const PersonalDetailsWidget(),
            SizedBox(height: 16.h),
            const EngRecordWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 250.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E9BFF), Color(0xFFF2A3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
