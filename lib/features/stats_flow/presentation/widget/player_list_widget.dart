import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../model/player_model.dart';

class PlayerListWidget extends StatelessWidget {
  final List<PlayerModel> players;
  final Function(PlayerModel) onAddTap;

  const PlayerListWidget({
    super.key,
    required this.players,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Scroll handling
      itemCount: players.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey.shade200,
        height: 1,
        indent: 16.w, // Screenshot onujayi divider ektu bame gap thake
      ),
      itemBuilder: (context, index) {
        final player = players[index];
        return _buildPlayerRow(player);
      },
    );
  }

  Widget _buildPlayerRow(PlayerModel player) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // 1. Player Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              player.image,
              height: 60.h,
              width: 60.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 16.w),

          // 2. Player Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: player.name,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                CommonText(
                  text: player.position,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          // 3. Add Button
          GestureDetector(
            onTap: () => onAddTap(player),
            child: Icon(
              Icons.add_circle_outline,
              size: 28.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}