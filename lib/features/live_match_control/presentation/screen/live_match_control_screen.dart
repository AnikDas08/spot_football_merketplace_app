import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
import '../../../home/data/match_model.dart';
import '../controller/live_match_control_controller.dart';

class LiveMatchControlScreen extends StatelessWidget {
  const LiveMatchControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveMatchControlController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: SecondaryAppBar(title: "Live match control"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        final match = controller.match.value;
        if (match == null) {
          return const Center(child: Text("No match data found"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildScoreCard(match),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildTeamActionCard(
                        match.homeTeam.teamName,
                        match.homeTeam.id,
                        match.id,
                        match.league ?? "",
                        const Color(0xFFFFD54F),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildTeamActionCard(
                        match.awayTeam.teamName,
                        match.awayTeam.id,
                        match.id,
                        match.league ?? "",
                        const Color(0xFF19CA77),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildConductRatingCard(controller, match),
                SizedBox(height: 24.h),
                if (match.status.toLowerCase() == 'half_time')
                  _buildReportButton(
                    'FULL-TIME REPORT',
                    AppColors.black,
                    AppColors.white,
                    onTap: () async {
                      await controller.submitRefereeReport();
                      await controller.toggleMatchStatus();
                    },
                  )
                else if (match.status.toLowerCase() == 'live')
                  _buildReportButton(
                    'HALF-TIME REPORT',
                    const Color(0xFFCCCCCC),
                    AppColors.black,
                    onTap: () => controller.toggleMatchStatus(),
                  ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildScoreCard(MatchModel match) {
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
                  text: 'LIVE', // Can be dynamic if duration is tracked
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamHeader(
                match.homeTeam.teamLogo,
                match.homeTeam.teamName,
                match.homeTeam.id,
              ),
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
                          text: match.status.toUpperCase(),
                          fontSize: 10,
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
                        text: '${match.homeScore}',
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: CommonText(
                          text: ':',
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFFCCCCCC),
                        ),
                      ),
                      CommonText(
                        text: '${match.awayScore}',
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              _buildTeamHeader(
                match.awayTeam.teamLogo,
                match.awayTeam.teamName,
                match.awayTeam.id,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamHeader(String? logo, String name, String teamId) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.clubProfileScreen, arguments: teamId),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: logo != null && logo.isNotEmpty
                ? CommonImage(
                    imageSrc: logo,
                    width: 56.w,
                    height: 56.h,
                    fill: BoxFit.contain,
                  )
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
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamActionCard(
    String teamName,
    String teamId,
    String matchId,
    String leagueId,
    Color accentColor,
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.recordGoalScreen,
        arguments: {
          'matchId': matchId,
          'teamId': teamId,
          'teamName': teamName,
          'leagueId': leagueId,
        },
      ),
      child: Container(
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
                color: accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.sports_soccer, color: accentColor, size: 24.sp),
            ),
            SizedBox(height: 16.h),
            CommonText(
              text: teamName,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConductRatingCard(
    LiveMatchControlController controller,
    MatchModel match,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
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
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Home Team Marks
          CommonText(
            text: "add ${match.homeTeam.teamName} Marks",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            bottom: 8,
          ),
          _buildMarkDropdown(controller.homeTeamRating),

          SizedBox(height: 16.h),

          // Away Team Marks
          CommonText(
            text: "add ${match.awayTeam.teamName} Marks",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            bottom: 8,
          ),
          _buildMarkDropdown(controller.awayTeamRating),

          SizedBox(height: 16.h),

          // Player Of The Day
          CommonText(
            text: 'add Player Of The Day',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            bottom: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(
                () => DropdownButton<String>(
                  value: controller.manOfTheMatchId.value.isEmpty
                      ? null
                      : controller.manOfTheMatchId.value,
                  isExpanded: true,
                  hint: Text(
                    "Enter Player Of The Day Name Here...",
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
                  items: controller.allMatchPlayers.map((p) {
                    final details = p['player'] ?? p;
                    final name =
                        "${details['firstName'] ?? ""} ${details['lastName'] ?? ""}"
                            .trim();
                    return DropdownMenuItem(
                      value:
                          details['userId']?.toString() ??
                          details['_id']?.toString(),
                      child: Text(
                        name.isNotEmpty
                            ? name
                            : (details['userName'] ?? "Player"),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) =>
                      controller.manOfTheMatchId.value = val ?? "",
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),
          CommonText(
            text:
                'RATING AFFECTS SEASON FAIR-PLAY BONUSES AND DISCIPLINARY REVIEW PRIORITY.',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF424242),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildMarkDropdown(RxString value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton<String>(
            value: value.value,
            isExpanded: true,
            items: List.generate(101, (index) => index.toString()).map((val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  "Marks 0-100: [$val]",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) => value.value = val ?? "85",
          ),
        ),
      ),
    );
  }
}

Widget _buildReportButton(
  String text,
  Color bgColor,
  Color textColor, {
  VoidCallback? onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 52.h,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
      ),
      child: CommonText(
        text: text,
        fontSize: 18,
        fontWeight: FontWeight(510),
        color: textColor,
      ),
    ),
  );
}
