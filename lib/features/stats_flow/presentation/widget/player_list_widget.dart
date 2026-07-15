import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:untitled/component/image/common_image.dart';

import '../../../../component/text/common_text.dart';
import '../controller/add_player_controller.dart';
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
    final controller = Get.find<AddPlayerController>();
    return ListView.separated(
      controller: controller.scrollController,
      itemCount: players.length,
      padding: EdgeInsets.only(bottom: 20.h),
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
            child: CommonImage(
              imageSrc: player.image,
              height: 60.h,
              width: 60.w,
              fill: BoxFit.cover,
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
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                CommonText(
                  text: player.position,
                  fontSize: 14,
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