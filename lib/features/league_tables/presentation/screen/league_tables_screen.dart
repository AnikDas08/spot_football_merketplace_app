import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/common_dropdown_field/common_dropdown_field.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/league_preview.dart';
import 'package:untitled/utils/constants/app_colors.dart';

import 'package:intl/intl.dart';

class LeagueTablesScreen extends StatefulWidget {
  const LeagueTablesScreen({super.key});

  @override
  State<LeagueTablesScreen> createState() => _LeagueTablesScreenState();
}

class _LeagueTablesScreenState extends State<LeagueTablesScreen> {
  String selectedDateText = '2025/26';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'LEAGUE TABLES'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: CommonDropdownField<String>(
                      hintText: 'Under 12',
                      borderColor: Colors.transparent,
                      fillColor: AppColors.white,
                      borderRadius: 8,
                      paddingVertical: 12,
                      items: ['Under 12', 'Under 14', 'Under 16'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDateText = DateFormat('dd/MM/yyyy').format(picked);
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: CommonDropdownField<String>(
                          hintText: selectedDateText,
                          borderColor: Colors.transparent,
                          fillColor: AppColors.white,
                          borderRadius: 8,
                          paddingVertical: 12,
                          items: [selectedDateText].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const LeaguePreview(isSeeAll: true),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: CommonText(
                  text: 'Last updated: April 24, 2026 • Matchday 25',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color6B6B6B,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
