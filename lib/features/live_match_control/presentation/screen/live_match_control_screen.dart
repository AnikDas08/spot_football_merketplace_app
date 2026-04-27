import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class LiveMatchControlScreen extends StatelessWidget {
  const LiveMatchControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: SecondaryAppBar(title: "LIVE MATCH CONTROL'"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              _buildScoreCard(),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTeamActionCard(
                      'TITANS FC',
                      const Color(0xFFFFD54F),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildTeamActionCard(
                      'PHOENIX UTDS',
                      const Color(0xFF19CA77),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildConductRatingCard(),
              SizedBox(height: 24.h),
              _buildReportButton(
                'FULL-TIME REPORT',
                AppColors.black,
                AppColors.white,
              ),
              SizedBox(height: 12.h),
              _buildReportButton(
                'HALF-TIME REPORT',
                const Color(0xFFCCCCCC),
                AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.watch_later_outlined, size: 20),
                SizedBox(width: 8.w),
                CommonText(
                  text: '62:15',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamHeader(TempImage.arsenalFlag, 'TITANS FC'),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF19CA77),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.white),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: 'LIVE 74\'',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      CommonText(
                        text: '2',
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: CommonText(
                          text: ':',
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFFCCCCCC),
                        ),
                      ),
                      CommonText(
                        text: '1',
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              _buildTeamHeader(TempImage.arsenalFlag, 'PHOENIX UTDS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamHeader(String logo, String name) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(logo, width: 56.w, height: 56.h),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 80.w,
          child: CommonText(
            text: name,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamActionCard(String teamName, Color accentColor) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(bottom: BorderSide(color: accentColor, width: 4)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.sports_soccer, color: accentColor, size: 24.sp),
          ),
          SizedBox(height: 16.h),
          CommonText(
            text: teamName,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildConductRatingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6ED),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.assignment_outlined, color: Color(0xFF8E24AA)),
              SizedBox(width: 8.w),
              CommonText(
                text: 'TEAM CONDUCT RATING',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 48.h,
            width: .infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: CommonText(
              text: 'Marks 0-100: [85]',
              fontSize: 15.sp,
              fontWeight: FontWeight(510),
              color: const Color(0xFF9E9E9E),
            ),
          ),
          SizedBox(height: 12.h),
          CommonText(
            text:
                'RATING AFFECTS SEASON FAIR-PLAY BONUSES AND DISCIPLINARY REVIEW PRIORITY.',
            fontSize: 12.sp,
            fontWeight: FontWeight(510),
            color: const Color(0xFF424242),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButton(String text, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: CommonText(
          text: text,
          fontSize: 18.sp,
          fontWeight: FontWeight(510),
          color: textColor,
        ),
      ),
    );
  }
}
