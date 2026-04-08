// features/fixtures/presentation/screen/fixtures_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';


import '../../../../component/common_appbar/common_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../data/model/fixture_model.dart';
import '../controller/fixtures_controller.dart';
import '../widget/fixtures_filter_sheet.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FixturesController>(
      builder: (c) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: SecondaryAppBar(title: AppString.fixture),
        body: Column(
          children: [
            SizedBox(height: 12.h),
            _TabRow(c: c),
            SizedBox(height: 12.h),
            _FilterBar(c: c),
            SizedBox(height: 8.h),
            Expanded(child: _FixtureList(c: c)),
          ],
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
    return Padding(
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
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: selected
                      ? AppColors.primaryColor
                      : AppColors.background,
                ),
              ),
              child: CommonText(
                text: c.tabs[i],
                fontSize: 13.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.tune, color: AppColors.white, size: 16.r),
                  SizedBox(width: 6.w),
                  CommonText(
                    text: AppString.filterByLeague,
                    fontSize: 13.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          CommonText(
            text: '${c.filteredFixtures.length} ${AppString.matchesFound}',
            fontSize: 13.sp,
            color: AppColors.textSecondaryColor,
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
    final groups = c.groupedFixtures;
    if (groups.isEmpty) {
      return Center(
        child: CommonText(text: AppString.noMatchesFound, fontSize: 14.sp),
      );
    }
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      children: groups.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Row(
              children: [
                CommonText(
                  text: entry.key,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8.w),
                CommonText(
                  text: c.groupSubLabel(entry.key),
                  fontSize: 12.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ...entry.value.map((f) => _FixtureCard(fixture: f)),
          ],
        );
      }).toList(),
    );
  }
}

class _FixtureCard extends StatelessWidget {
  final FixtureModel fixture;
  const _FixtureCard({required this.fixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: fixture.date,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
              CommonText(
                text: fixture.time,
                fontSize: 11.sp,
                color: AppColors.textSecondaryColor,
              ),
            ],
          ),
          Container(
            width: 1.w,
            height: 32.h,
            color: AppColors.textSecondaryColor,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: fixture.homeTeam,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: CommonText(
                    text: AppString.vs,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                CommonText(
                  text: fixture.awayTeam,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.confirmation_number_outlined,
              color: AppColors.white,
              size: 16.r,
            ),
          ),
        ],
      ),
    );
  }
}
