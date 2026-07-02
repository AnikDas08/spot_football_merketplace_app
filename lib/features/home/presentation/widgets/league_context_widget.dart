import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class LeagueContextWidget extends StatelessWidget {
  final int position;
  final int points;
  final int gd;

  const LeagueContextWidget({
    super.key,
    required this.position,
    required this.points,
    required this.gd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'LEAGUE CONTEXT',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildContextItem(
                  value: _formatPosition(position),
                  label: 'POSITION',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildContextItem(
                  value: '$points',
                  label: 'POINTS',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildContextItem(
                  value: '${gd >= 0 ? '+' : ''}$gd',
                  label: 'GD',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatPosition(int pos) {
    if (pos <= 0) return 'N/A';
    if (pos == 1) return '1st';
    if (pos == 2) return '2nd';
    if (pos == 3) return '3rd';
    return '${pos}th';
  }

  Widget _buildContextItem({required String value, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText(
          text: value,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFEABB00),
        ),
        CommonText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40.h,
      width: 1.w,
      color: Colors.grey.withValues(alpha: 0.2),
    );
  }
}
