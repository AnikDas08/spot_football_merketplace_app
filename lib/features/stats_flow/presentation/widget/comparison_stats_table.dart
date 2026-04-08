import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../model/player_model.dart';

class ComparisonStatsTable extends StatelessWidget {
  final PlayerModel? player1;
  final PlayerModel? player2;

  const ComparisonStatsTable({super.key, this.player1, this.player2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: CommonText(
            text: "OVERVIEW",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        _buildStatRow(
          "Appearances",
          player1?.appearances,
          player2?.appearances,
        ),
        _buildStatRow("Goals", player1?.goals, player2?.goals),
        _buildStatRow("Assists", player1?.assists, player2?.assists),
        _buildStatRow(
          "Clean sheets",
          player1?.cleanSheets,
          player2?.cleanSheets,
        ),
        _buildStatRow("Saves", player1?.saves, player2?.saves),
        _buildStatRow(
          "Yellow cards",
          player1?.yellowCards,
          player2?.yellowCards,
        ),
        _buildStatRow("Red cards", player1?.redCards, player2?.redCards),
      ],
    );
  }

  Widget _buildStatRow(String label, dynamic val1, dynamic val2) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10,right: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Player 1 Stat
          Expanded(
            flex: 2,
            child: CommonText(
              text: val1?.toString() ?? "-",
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.primaryColor,
            ),
          ),

          // Stat Label
          Expanded(
            flex: 5,
            child: CommonText(
              text: label,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.primaryColor,
            ),
          ),

          // Player 2 Stat
          Expanded(
            flex: 2,
            child: val2 != null
                ? CommonText(
                    text: val2.toString(),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    textAlign: TextAlign.right,
                    color: AppColors.primaryColor,
                  )
                : Align(
                    alignment: Alignment.centerRight,
                    child:
                        _buildRectanglePlaceholder(), // SVG bad diye placeholder function
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRectanglePlaceholder() {
    return Container(
      height: 2.h,
      width: 16.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(1.r),
      ),
    );
  }
}
