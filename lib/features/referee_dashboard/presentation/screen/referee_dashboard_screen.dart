import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
import '../../../../utils/extensions/extension.dart';
import '../../../home/data/match_model.dart';
import '../controller/referee_dashboard_controller.dart';

class RefereeDashboardScreen extends StatefulWidget {
  const RefereeDashboardScreen({super.key});

  @override
  State<RefereeDashboardScreen> createState() => _RefereeDashboardScreenState();
}

class _RefereeDashboardScreenState extends State<RefereeDashboardScreen> {
  int activeTabIndex = 0;
  final controller = Get.put(RefereeDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Obx(() {
        if (controller.isLoading.value && controller.allMatches.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        return Column(
          children: [
            _buildProfileHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.fetchMyMatches(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTabRow(),
                        SizedBox(height: 20.h),
                        _buildMatchList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMatchList() {
    List<MatchModel> currentMatches = [];
    if (activeTabIndex == 0) {
      currentMatches = controller.allMatches;
    } else if (activeTabIndex == 1) currentMatches = controller.todayMatches;
    else if (activeTabIndex == 2) currentMatches = controller.upcomingMatches;
    else currentMatches = controller.historyMatches;

    if (currentMatches.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: CommonText(
            text: activeTabIndex == 0 
                ? 'No Matches Found'
                : activeTabIndex == 1 
                    ? 'No Matches Today' 
                    : activeTabIndex == 2 
                        ? 'No Upcoming Matches' 
                        : 'No History Available',
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentMatches.length,
      itemBuilder: (context, index) {
        final match = currentMatches[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: _buildMatchCard(match),
        );
      },
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
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: CommonImage(
                    imageSrc: LocalStorage.myImage,
                    width: 48.r,
                    height: 48.r,
                    fill: BoxFit.cover,
                  ),
                ),
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
                      fontWeight: FontWeight.w500,
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
              Expanded(child: _buildStatCard('${controller.todayMatches.length}', 'Matches Today')),
              SizedBox(width: 16.w),
              Expanded(child: _buildStatCard('${controller.historyMatches.length}', 'Total Officiated')),
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
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            fontFamily: 'Montserrat',
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
          _buildTab('All', 0),
          SizedBox(width: 12.w),
          _buildTab('Today\'s Matches', 1),
          SizedBox(width: 12.w),
          _buildTab('Upcoming', 2),
          SizedBox(width: 12.w),
          _buildTab('History', 3),
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

  Widget _buildMatchCard(MatchModel match) {
    final bool isLive = match.status.toLowerCase() == 'live';
    final String formattedTime = match.matchDate != null ? DateFormat('hh:mm a').format(match.matchDate!) : 'TBA';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                    text: 'Live Match',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
                    _buildTeamInfo(match.homeTeam.teamLogo, match.homeTeam.teamName),
                    const CommonText(
                      text: 'Vs',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9E9E9E),
                    ),
                    _buildTeamInfo(match.awayTeam.teamLogo, match.awayTeam.teamName),
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
                        formattedTime,
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        'Venue: ',
                        match.venueName,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(() {
                  final bool isToggling = controller.togglingId.value == match.id;
                  final String status = match.status.toLowerCase();

                  if (status == 'finished') {
                    return SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: const CommonText(
                          text: 'Match Finished',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      if (status == 'upcoming')
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: isToggling
                                ? null
                                : () => controller.toggleMatchStatus(match.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF19CA77),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              elevation: 0,
                            ),
                            child: isToggling
                                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : const CommonText(
                                    text: 'Start Match',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                          ),
                        ),
                      if (status == 'live' || status == 'half_time')
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(AppRoutes.liveMatchControlScreen, arguments: match.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              elevation: 0,
                            ),
                            child: const CommonText(
                              text: 'Manage Match',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      if (status == 'live') ...[
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: isToggling ? null : () => controller.toggleMatchStatus(match.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD54F), // Yellow for Half Time
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              elevation: 0,
                            ),
                            child: isToggling
                                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : const CommonText(
                                    text: 'Half Time',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                          ),
                        ),
                      ] else if (status == 'half_time') ...[
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: isToggling ? null : () => controller.toggleMatchStatus(match.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor, // Changed from Red to Primary Black
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              elevation: 0,
                            ),
                            child: isToggling
                                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : const CommonText(
                                    text: 'Full Time',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                          ),
                        ),
                      ],
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String? logo, String name) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: logo != null && logo.isNotEmpty
              ? CommonImage(imageSrc: logo, width: 56.w, height: 56.h, fill: BoxFit.contain)
              : Image.asset(TempImage.arsenalFlag, width: 56.w, height: 56.h),
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
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
