import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/common_appbar/common_appbar.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/common_dropdown_field/common_dropdown_field.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../controllers/club_profile_controller.dart';
import '../../data/point_table_model.dart';

class LeaguePreviewScreen extends StatefulWidget {
  final bool fromBottomNav;
  const LeaguePreviewScreen({super.key, this.fromBottomNav = false});

  @override
  State<LeaguePreviewScreen> createState() => _LeaguePreviewScreenState();
}

class _LeaguePreviewScreenState extends State<LeaguePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClubProfileController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.fromBottomNav
          ? CommonAppbar(title: AppString.leaguePreview)
          : SecondaryAppBar(title: AppString.leaguePreview),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchPointTable(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: GetBuilder<ClubProfileController>(
                    builder: (controller) {
                      final currentLeague = controller.allLeagues.isNotEmpty 
                          ? controller.allLeagues[controller.selectedLeagueIndex].league 
                          : null;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CommonDropdownField<int>(
                                      hintText: currentLeague?.leagueName ?? 'Select League',
                                      borderColor: Colors.transparent,
                                      fillColor: AppColors.white,
                                      borderRadius: 8,
                                      paddingVertical: 12,
                                      value: controller.allLeagues.isNotEmpty ? controller.selectedLeagueIndex : null,
                                      items: List.generate(
                                        controller.allLeagues.length,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(
                                            controller.allLeagues[index].league.leagueName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.selectLeague(value);
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: CommonDropdownField<String>(
                                      hintText: currentLeague?.season ?? 'Season',
                                      borderColor: Colors.transparent,
                                      fillColor: AppColors.white,
                                      borderRadius: 8,
                                      paddingVertical: 12,
                                      value: currentLeague?.season,
                                      items: controller.allLeagues.isNotEmpty 
                                          ? [DropdownMenuItem<String>(
                                              value: currentLeague?.season,
                                              child: Text(
                                                currentLeague?.season ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )]
                                          : [],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            if (currentLeague != null)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                child: CommonText(
                                  text: '${currentLeague.leagueName} ${currentLeague.season}',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.color6B6B6B,
                                ),
                              ),

                            SizedBox(height: 8.h),

                            if (controller.isLoading.value)
                              const TableShimmer()
                            else if (controller.pointTable.isEmpty)
                              _buildNoData(controller.pointTableMessage)
                            else
                              _buildStandingsTable(controller.pointTable),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _buildNoData(String message) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: CommonText(
          text: message.isNotEmpty ? message : "No data available",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.color6B6B6B,
        ),
      ),
    );
  }

  Widget _buildStandingsTable(List<PointTableModel> standings) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.colorEABB00, width: 1.w),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: CommonText(
                        text: 'Pos',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 22.w),
                        child: CommonText(
                          text: 'Club',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: CommonText(
                        text: 'PL',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 36.w,
                      child: CommonText(
                        text: 'GD',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 36.w,
                      child: CommonText(
                        text: 'PTS',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Rows
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: standings.length,
              separatorBuilder: (_, _) => Divider(height: 1, color: AppColors.background),
              itemBuilder: (context, index) {
                final item = standings[index];
                final gdText = item.goalDifference >= 0
                    ? '+${item.goalDifference}'
                    : '${item.goalDifference}';

                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.clubProfileScreen, arguments: item.team.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                          child: CommonText(
                            text: '${index + 1}.',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CommonImage(
                                imageSrc: item.team.teamLogo ?? '',
                                width: 20.w,
                                height: 20.h,
                                fill: BoxFit.contain,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: CommonText(
                                  text: item.team.teamName,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                          child: CommonText(
                            text: '${item.played}',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 36.w,
                          child: CommonText(
                            text: gdText,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 36.w,
                          child: CommonText(
                            text: '${item.points}',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
