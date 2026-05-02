import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import 'package:untitled/utils/extensions/extension.dart';

class RefereeDashboardScreen extends StatefulWidget {
  const RefereeDashboardScreen({super.key});

  @override
  State<RefereeDashboardScreen> createState() => _RefereeDashboardScreenState();
}

class _RefereeDashboardScreenState extends State<RefereeDashboardScreen> {
  int activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTabRow(),
                    SizedBox(height: 20.h),
                    if (activeTabIndex == 0) ...[
                      _buildMatchCard(isLive: true),
                      SizedBox(height: 16.h),
                      _buildMatchCard(isLive: false),
                      SizedBox(height: 16.h),
                      _buildMatchCard(isLive: false),
                    ] else if (activeTabIndex == 1) ...[
                      const Center(
                        child: CommonText(text: 'No Upcoming Matches'),
                      ),
                    ] else ...[
                      const Center(
                        child: CommonText(text: 'No History Available'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 50.h,
        bottom: 16.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: 24.sp,
                ),
              ),
              10.width,
              CircleAvatar(
                radius: 24.r,
                backgroundImage: const AssetImage(TempImage.profile),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: LocalStorage.myName.isEmpty
                          ? 'John Smith'
                          : LocalStorage.myName,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    const CommonText(
                      text: 'Referee',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9E9E9E),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(child: _buildStatCard('5', 'Matches Today')),
              SizedBox(width: 16.w),
              Expanded(child: _buildStatCard('42', 'Total Officiated')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CommonText(
            text: value,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          CommonText(
            text: label,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9E9E9E),
          ),
        ],
      ),
    );
  }

  Widget _buildTabRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTab('Today\'s Matches', 0),
          SizedBox(width: 12.w),
          _buildTab('Upcoming', 1),
          SizedBox(width: 12.w),
          _buildTab('History', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isActive = activeTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: CommonText(
          text: label,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }

  Widget _buildMatchCard({required bool isLive}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isLive)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const CommonText(
                    text: 'LIVE MATCH',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTeamInfo(TempImage.arsenalFlag, 'TITANS FC'),
                    const CommonText(
                      text: 'VS',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9E9E9E),
                    ),
                    _buildTeamInfo(TempImage.arsenalFlag, 'PHOENIX UTDS'),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        Icons.watch_later_outlined,
                        'Time: ',
                        '2:00 PM',
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        'Venue: ',
                        'Main Ground',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLive) {
                        Get.toNamed(AppRoutes.live_match_control_screen);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLive
                          ? AppColors.black
                          : const Color(0xFF19CA77),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: CommonText(
                      text: isLive ? 'Manage Match' : 'Start Match',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String logo, String name) {
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
            fontSize: 12,
            fontWeight: FontWeight.w700,
            maxLines: 2,
            color: AppColors.black,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFFFFD54F)),
        SizedBox(width: 8.w),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: label,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: value,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
