import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/add_player_controller.dart';
import '../widget/action_appbar.dart';
import '../widget/filter_selector_card.dart';
import '../widget/player_list_widget.dart';

class AddPlayerScreen extends StatelessWidget {
  AddPlayerScreen({super.key});

  final AddPlayerController controller = Get.find<AddPlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ActionAppBar(title: '', onResetTap: () {}),

      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    FilterSelectorCard(
                      label: "Season",
                      value: "2024/25",
                      onTap: () => print("Season tapped"),
                    ),
                    SizedBox(width: 8.w),
                    FilterSelectorCard(
                      label: "Club",
                      value: "All Clubs",
                      onTap: () => print("Club tapped"),
                    ),
                    SizedBox(width: 8.w),
                    FilterSelectorCard(
                      label: "Position",
                      value: "All Positions",
                      onTap: () => print("Position tapped"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              PlayerListWidget(
                players: controller.playerList,
                onAddTap: (player) {
                  print("Added player: ${player.name}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
