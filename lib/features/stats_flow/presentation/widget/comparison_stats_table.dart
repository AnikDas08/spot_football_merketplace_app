import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../model/player_model.dart';

import 'package:intl/intl.dart';

class ComparisonStatsTable extends StatelessWidget {
  final PlayerModel? player1;
  final PlayerModel? player2;

  const ComparisonStatsTable({super.key, this.player1, this.player2});

  String _formatStrongFoot(String? foot) {
    if (foot == null || foot.toLowerCase() == 'false' || foot.isEmpty) return "N/A";
    return foot.toUpperCase();
  }

  String _calculateAge(String? dob) {
    if (dob == null) return "N/A";
    try {
      final birthDate = DateTime.parse(dob);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age.toString();
    } catch (e) {
      return "N/A";
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "N/A";
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(dateStr));
    } catch (e) {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: CommonText(
            text: "PERSONAL DETAILS",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        _buildStatRow("Club", player1?.teamName, player2?.teamName),
        _buildStatRow("Position", player1?.position, player2?.position),
        _buildStatRow("Age", _calculateAge(player1?.dob), _calculateAge(player2?.dob)),
        _buildStatRow("Strong Foot", _formatStrongFoot(player1?.strongFoot), _formatStrongFoot(player2?.strongFoot)),
        _buildStatRow("ENG Debut", _formatDate(player1?.debutDate), _formatDate(player2?.debutDate)),
        _buildStatRow("ENG Coins", player1?.engCoins, player2?.engCoins),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: CommonText(
            text: "OVERVIEW",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        if (player1?.appearances != null || player2?.appearances != null)
          _buildStatRow(
            "Appearances",
            player1?.appearances,
            player2?.appearances,
          ),
        if (player1?.goals != null || player2?.goals != null)
          _buildStatRow("Goals", player1?.goals, player2?.goals),
        if (player1?.assists != null || player2?.assists != null)
          _buildStatRow("Assists", player1?.assists, player2?.assists),
        if (player1?.cleanSheets != null || player2?.cleanSheets != null)
          _buildStatRow(
            "Clean sheets",
            player1?.cleanSheets,
            player2?.cleanSheets,
          ),
        if (player1?.saves != null || player2?.saves != null)
          _buildStatRow("Saves", player1?.saves, player2?.saves),
        if (player1?.yellowCards != null || player2?.yellowCards != null)
          _buildStatRow(
            "Yellow cards",
            player1?.yellowCards,
            player2?.yellowCards,
          ),
        if (player1?.redCards != null || player2?.redCards != null)
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
              fontSize: 14,
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
              fontSize: 14,
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
                    fontSize: 14,
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
