// features/fixtures/presentation/widget/fixtures_filter_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

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
      builder: (c) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: Colors.black,
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 40, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Custom Close Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.colorEABB00,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),

                  // 2. Centered Title
                  Text(
                    AppString.filter,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      c.resetFilters();
                    },
                    child: Text(
                      AppString.reset,
                      style: GoogleFonts.playfairDisplay(
                        color: AppColors.yellow,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // TEAM label
                  Text(
                    AppString.team,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // All Teams / Specific toggle
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                    ),
                    child: Row(
                      children: [
                        _SheetTab(
                          label: AppString.allTeam,
                          selected: c.teamTab == 0,
                          onTap: () => c.selectTeamTab(0),
                        ),
                        SizedBox(width: 8.w),
                        _SheetTab(
                          label: AppString.specific,
                          selected: c.teamTab == 1,
                          onTap: () => c.selectTeamTab(1),
                        ),
                      ],
                    ),
                  ),

                  if (c.teamTab == 1) ...[
                    SizedBox(height: 12.h),
                    CommonDropdownField<String>(
                      hintText: AppString.selectATeam,
                      value: c.selectedTeam,
                      items: c.teams
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: CommonText(text: t, fontSize: 14),
                            ),
                          )
                          .toList(),
                      onChanged: c.selectTeam,
                    ),
                  ],

                  SizedBox(height: 24.h),
                  Text(
                    AppString.dateRange,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Date range chips
                  Row(
                    children: [
                      _DateChip(
                        label: AppString.all,
                        selected: c.dateRangeTab == 0,
                        onTap: () => c.selectDateRangeTab(0),
                      ),
                      SizedBox(width: 8.w),
                      _DateChip(
                        label: AppString.today,
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
                  SizedBox(height: 16.h),

                  // Calendar
                  _CalendarWidget(c: c),

                  SizedBox(height: 24.h),
                  CommonButton(
                    titleText: AppString.applyFilters,
                    onTap: c.applyFilters,
                    buttonWidth: double.infinity,
                    buttonColor: AppColors.primaryColor,
                    titleColor: AppColors.white,
                    buttonHeight: 50,
                    buttonRadius: 12.r,
                  ),
                ],
              ),
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
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w500,
              color: selected ? AppColors.white : AppColors.primaryColor,
            ),
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
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? AppColors.primaryColor : AppColors.colorEABB00,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: selected ? FontWeight.w500 : FontWeight.w500,
            color: selected ? AppColors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class _CalendarWidget extends StatelessWidget {
  final FixturesController c;
  const _CalendarWidget({required this.c});

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
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$monthName ${c.focusedMonth.year}',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: c.previousMonth,
                    child: Icon(Icons.chevron_left, size: 24.r, color: AppColors.primaryColor),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: c.nextMonth,
                    child: Icon(Icons.chevron_right, size: 24.r, color: AppColors.primaryColor),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 12.h),
          _buildGrid(daysInMonth, startWeekday),
        ],
      ),
    );
  }

  Widget _buildGrid(int daysInMonth, int startWeekday) {
    final cells = <Widget>[];
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
      final isSelected = (c.startDate != null && _isSameDay(c.startDate, date)) ||
                        (c.endDate != null && _isSameDay(c.endDate, date));
      final isInRange = c.startDate != null && c.endDate != null && 
                        date.isAfter(c.startDate!) && date.isBefore(c.endDate!);
      
      final isToday = _isToday(date);
      cells.add(
        _DayCell(
          day: d,
          isCurrentMonth: true,
          isSelected: isSelected,
          isInRange: isInRange,
          isToday: isToday,
          onTap: () => c.selectCalendarDate(date),
        ),
      );
    }
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

  bool _isSameDay(DateTime? d1, DateTime? d2) {
    if (d1 == null || d2 == null) return false;
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
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
  final bool isInRange;
  final bool isToday;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    this.isInRange = false,
    required this.onTap,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    Color textColor = isCurrentMonth
        ? AppColors.primaryColor
        : AppColors.background;
    FontWeight fw = FontWeight.w500;

    if (isSelected) {
      bg = AppColors.primaryColor;
      textColor = AppColors.white;
      fw = FontWeight.w700;
    } else if (isInRange) {
      bg = AppColors.primaryColor.withAlpha(50);
      textColor = AppColors.primaryColor;
    } else if (isToday) {
      bg = AppColors.textSecondaryColor.withAlpha(51);
      fw = FontWeight.w700;
    }

    return GestureDetector(
      onTap: isCurrentMonth ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: bg, 
          shape: isSelected ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: !isSelected && isInRange ? BorderRadius.circular(0) : (isSelected ? null : BorderRadius.circular(12.r)),
        ),
        alignment: Alignment.center,
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: 14.sp,
            color: textColor,
            fontWeight: fw,
          ),
        ),
      ),
    );
  }
}
