// features/fixtures/presentation/widget/fixtures_filter_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/common_dropdown_field/common_dropdown_field.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../controller/fixtures_controller.dart';

void showFilterSheet(BuildContext context, FixturesController c) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => GetBuilder<FixturesController>(
      builder: (c) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.close, size: 18.r),
                  ),
                ),
                CommonText(
                  text: AppString.filter,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                GestureDetector(
                  onTap: c.resetFilters,
                  child: CommonText(
                    text: AppString.reset,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // TEAM label
            CommonText(
              text: AppString.team,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondaryColor,
            ),
            SizedBox(height: 8.h),

            // All Teams / Specific toggle
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  _SheetTab(
                    label: AppString.allTeam,
                    selected: c.teamTab == 0,
                    onTap: () => c.selectTeamTab(0),
                  ),
                  _SheetTab(
                    label: AppString.specific,
                    selected: c.teamTab == 1,
                    onTap: () => c.selectTeamTab(1),
                  ),
                ],
              ),
            ),

            if (c.teamTab == 1) ...[
              SizedBox(height: 10.h),
              CommonDropdownField<String>(
                hintText: AppString.selectATeam,
                value: c.selectedTeam,
                items: c.teams
                    .map(
                      (t) => DropdownMenuItem(
                        value: t,
                        child: CommonText(text: t, fontSize: 14.sp),
                      ),
                    )
                    .toList(),
                onChanged: c.selectTeam,
              ),
            ],

            SizedBox(height: 20.h),
            CommonText(
              text: AppString.dateRange,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondaryColor,
            ),
            SizedBox(height: 8.h),

            // Date range chips
            Row(
              children: [
                _DateChip(
                  label: AppString.today,
                  selected: c.dateRangeTab == 0,
                  onTap: () => c.selectDateRangeTab(0),
                ),
                SizedBox(width: 8.w),
                _DateChip(
                  label: AppString.thisWeek,
                  selected: c.dateRangeTab == 1,
                  onTap: () => c.selectDateRangeTab(1),
                ),
                SizedBox(width: 8.w),
                _DateChip(
                  label: AppString.thisMonth,
                  selected: c.dateRangeTab == 2,
                  onTap: () => c.selectDateRangeTab(2),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Calendar
            _CalendarWidget(c: c),

            SizedBox(height: 20.h),
            CommonButton(
              titleText: AppString.applyFilters,
              onTap: c.applyFilters,
              buttonWidth: double.infinity,
              buttonColor: AppColors.primaryColor,
              titleColor: AppColors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

class _SheetTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SheetTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: CommonText(
            text: label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _DateChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? AppColors.primaryColor : AppColors.background,
          ),
        ),
        child: CommonText(
          text: label,
          fontSize: 12.sp,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          color: selected ? AppColors.white : AppColors.primaryColor,
        ),
      ),
    );
  }
}

class _CalendarWidget extends StatelessWidget {
  final FixturesController c;
  const _CalendarWidget({required this.c});

  static const _weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    final first = DateTime(c.focusedMonth.year, c.focusedMonth.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(
      c.focusedMonth.year,
      c.focusedMonth.month,
    );
    final startWeekday = first.weekday; // 1=Mon
    final monthName = _monthName(c.focusedMonth.month);

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Month/Year header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: monthName,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  CommonText(
                    text: '${c.focusedMonth.year}',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: c.previousMonth,
                    child: Icon(Icons.chevron_left, size: 20.r),
                  ),
                  GestureDetector(
                    onTap: c.nextMonth,
                    child: Icon(Icons.chevron_right, size: 20.r),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Weekday labels (hidden, just grid)
          _buildGrid(daysInMonth, startWeekday),
        ],
      ),
    );
  }

  Widget _buildGrid(int daysInMonth, int startWeekday) {
    final cells = <Widget>[];
    // leading empty cells (Mon=1, so offset = startWeekday-1)
    for (int i = 1; i < startWeekday; i++) {
      final prevMonth = DateTime(c.focusedMonth.year, c.focusedMonth.month - 1);
      final prevDays = DateUtils.getDaysInMonth(
        prevMonth.year,
        prevMonth.month,
      );
      final day = prevDays - (startWeekday - 1 - i);
      cells.add(
        _DayCell(
          day: day,
          isCurrentMonth: false,
          isSelected: false,
          onTap: () {},
        ),
      );
    }
    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(c.focusedMonth.year, c.focusedMonth.month, d);
      final isSelected =
          c.selectedDate != null &&
          c.selectedDate!.year == date.year &&
          c.selectedDate!.month == date.month &&
          c.selectedDate!.day == date.day;
      final isToday = _isToday(date);
      cells.add(
        _DayCell(
          day: d,
          isCurrentMonth: true,
          isSelected: isSelected,
          isToday: isToday,
          onTap: () => c.selectCalendarDate(date),
        ),
      );
    }
    // trailing
    final trailing = (7 - (cells.length % 7)) % 7;
    for (int i = 1; i <= trailing; i++) {
      cells.add(
        _DayCell(
          day: i,
          isCurrentMonth: false,
          isSelected: false,
          onTap: () {},
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 4.h,
      crossAxisSpacing: 4.w,
      children: cells,
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _monthName(int month) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[month - 1];
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.onTap,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    Color textColor = isCurrentMonth
        ? AppColors.primaryColor
        : AppColors.background;
    FontWeight fw = FontWeight.w400;

    if (isSelected) {
      bg = AppColors.primaryColor;
      textColor = AppColors.white;
      fw = FontWeight.w700;
    } else if (isToday) {
      bg = AppColors.textSecondaryColor.withAlpha(51);
      fw = FontWeight.w700;
    }

    return GestureDetector(
      onTap: isCurrentMonth ? onTap : null,
      child: Container(
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: CommonText(
          text: '$day',
          fontSize: 12.sp,
          color: textColor,
          fontWeight: fw,
        ),
      ),
    );
  }
}
