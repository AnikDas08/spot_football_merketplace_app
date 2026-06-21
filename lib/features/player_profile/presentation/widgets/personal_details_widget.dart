import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

class PersonalDetailsWidget extends StatelessWidget {
  final Map<String, dynamic>? playerData;

  const PersonalDetailsWidget({super.key, this.playerData});

  @override
  Widget build(BuildContext context) {
    if (playerData == null) return const SizedBox.shrink();

    final selectTeam = playerData!['selectTeam'];
    String clubName = 'N/A';
    if (selectTeam is Map) {
      clubName = selectTeam['teamName'] ?? 'N/A';
    } else if (selectTeam is String) {
      clubName = selectTeam;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'PERSONAL DETAILS',
                fontSize: 20.sp,
                fontWeight: const FontWeight(590),
                color: AppColors.primaryColor,
              ),
              if (playerData!['status'] == 'APPROVED')
                Image.asset(AppImages.approved, width: 54.w, height: 32.h),
            ],
          ),
          SizedBox(height: 16.h),
          _item('Nationality', playerData!['country'] ?? 'N/A'),
          _item('Club', clubName),
          _item('Position', playerData!['position'] ?? 'N/A'),
          _item('ENG Debut', _formatDate(playerData!['createdAt'])),
          _item('Strong Foot', playerData!['strongFoot'] ?? 'N/A'),
          // _item('Market Value', "N/A"),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      return "${date.day} ${months[date.month - 1]} ${date.year}";
    } catch (e) {
      return dateStr;
    }
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: title,
              fontSize: 15.sp,
              fontWeight: const FontWeight(510),
              color: AppColors.color373737,
              textAlign: TextAlign.start,
            ),
          ),
          CommonText(
            text: value,
            fontSize: 15.sp,
            fontWeight: const FontWeight(510),
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
