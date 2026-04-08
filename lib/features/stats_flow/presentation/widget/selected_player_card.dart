import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/player_model.dart';

class SelectedPlayerCard extends StatelessWidget {
  final PlayerModel player;
  const SelectedPlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.asset(
              player.image,
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.fill,

            ),          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
            ),
            child: Text(
              player.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}