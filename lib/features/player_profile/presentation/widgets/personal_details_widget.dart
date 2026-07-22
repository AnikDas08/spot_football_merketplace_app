import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetailsWidget extends StatelessWidget {
  final Map<String, dynamic>? playerData;

  const PersonalDetailsWidget({super.key, this.playerData});

  @override
  Widget build(BuildContext context) {
    if (playerData == null) return const SizedBox.shrink();

    final selectTeam = playerData!['selectTeam'];
    String clubName = 'N/A';
    String nationality = 'N/A';
    String city = 'N/A';

    if (selectTeam is Map) {
      clubName = selectTeam['teamName'] ?? 'N/A';
      nationality = selectTeam['country'] ?? 'N/A';
      city = selectTeam['city'] ?? 'N/A';
    } else if (selectTeam is String) {
      clubName = selectTeam;
    }

    String strongFoot = playerData!['strongFoot']?.toString() ?? 'N/A';
    if (strongFoot.toLowerCase() == 'false' || strongFoot.isEmpty) {
      strongFoot = 'N/A';
    } else {
      strongFoot = strongFoot.toUpperCase();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Personal details',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              if (playerData!['status'] == 'APPROVED')
                Image.asset(AppImages.approved, width: 90.w,fit: .fill,),
            ],
          ),
          SizedBox(height: 16.h),
          _item('Date of Birth', _formatDate(playerData!['dateOfBirth'])),
          _item('Age Group', playerData!['ageGroup'] ?? 'N/A'),
          _item('Nationality', nationality),
          _item('City', city),
          _item('Club', clubName),
          _item('Position', playerData!['position'] ?? 'N/A'),
          _item('ENG Debut', _formatDate(playerData!['createdAt'])),
          _item('Strong Foot', strongFoot),
          _item(
            'ENG Coins',
            playerData!['engCoine']?.toString() ?? '0',
            icon: Image.asset(AppImages.coin, width: 20.w, height: 20.h),
          ),
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

  Widget _item(String title, String value, {Widget? icon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: title,
              fontSize: 15,
              fontWeight: const FontWeight(510),
              color: AppColors.color373737,
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon,
                SizedBox(width: 6.w),
              ],
              CommonText(
                text: value,
                fontSize: 15,
                fontWeight: const FontWeight(510),
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
