import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixture_card.dart';
import 'package:untitled/features/navbar/controller/navbar_controller.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../component/common_appbar/common_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../controller/fixtures_controller.dart';
import '../widget/fixtures_filter_sheet.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController navBarController = Get.find<NavBarController>();
    return GetBuilder<FixturesController>(
      builder: (c) => Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CommonAppbar(title: AppString.fixture),
        drawer: const AppDrawer(),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            navBarController.selectedIndex.value = 0;
          },
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _TabRow(c: c),
              SizedBox(height: 12.h),
              _FilterBar(c: c),
              SizedBox(height: 8.h),
              Expanded(child: _FixtureList(c: c)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabRow extends StatelessWidget {
  final FixturesController c;
  const _TabRow({required this.c});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: List.generate(c.tabs.length, (i) {
          final selected = c.selectedTab == i;
          return GestureDetector(
            onTap: () => c.selectTab(i),
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryColor : AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.colorEABB00,
                ),
              ),
              child: CommonText(
                text: c.tabs[i],
                fontSize: 16,
                fontWeight: selected ? FontWeight.w700 : const FontWeight(590),
                color: selected ? AppColors.white : AppColors.primaryColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final FixturesController c;
  const _FilterBar({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showFilterSheet(context, c),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                  ),
                  child: SvgPicture.asset(AppIcons.filterSvg),
                ),
                SizedBox(width: 8.w),
                CommonText(
                  text: AppString.filterByLeague,
                  fontSize: 15,
                  color: AppColors.primaryColor,
                  fontWeight: const FontWeight(590),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          CommonText(
            text: '${c.filteredFixtures.length} ${AppString.matchesFound}',
            fontSize: 14,
            color: AppColors.textSecondaryColor,
            fontWeight: const FontWeight(590),
          ),
        ],
      ),
    );
  }
}

class _FixtureList extends StatelessWidget {
  final FixturesController c;
  const _FixtureList({required this.c});

  @override
  Widget build(BuildContext context) {
    if (c.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (c.filteredFixtures.isEmpty) {
      return Center(
        child: CommonText(text: AppString.noMatchesFound, fontSize: 14),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 150.h),
      itemCount: c.filteredFixtures.length,
      itemBuilder: (BuildContext context, int index) {
        final match = c.filteredFixtures[index];
        return UpcomingFixtureCard(
          id: match.id,
          date: match.matchDate != null
              ? DateFormat('MMM dd').format(match.matchDate!).toUpperCase()
              : 'N/A',
          homeTeam: match.homeTeam.teamName,
          awayTeam: match.awayTeam.teamName,
          time: match.matchDate != null
              ? DateFormat('hh:mm a').format(match.matchDate!)
              : 'N/A',
          homeLogo: match.homeTeam.teamLogo,
          awayLogo: match.awayTeam.teamLogo,
          venue: match.venueName,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10.h);
      },
    );
  }
}
