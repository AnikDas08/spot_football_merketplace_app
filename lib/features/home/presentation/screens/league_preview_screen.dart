import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/common_dropdown_field/common_dropdown_field.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../widgets/league_preview.dart';

import 'package:intl/intl.dart';

class LeaguePreviewScreen extends StatefulWidget {
  const LeaguePreviewScreen({super.key});

  @override
  State<LeaguePreviewScreen> createState() => _LeaguePreviewScreenState();
}

class _LeaguePreviewScreenState extends State<LeaguePreviewScreen> {
  String selectedDateText = '2025/26';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.leaguePreview),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonDropdownField<String>(
                        hintText: 'Under 12',
                        borderColor: Colors.transparent,
                        fillColor: AppColors.white,
                        borderRadius: 8,
                        paddingVertical: 12,
                        items: ['Under 12', 'Under 14', 'Under 16']
                            .map((String value) {
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
                            items: [selectedDateText]
                                .map((String value) {
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
            ],
          ),
        ),
      ),
    );
  }
}
