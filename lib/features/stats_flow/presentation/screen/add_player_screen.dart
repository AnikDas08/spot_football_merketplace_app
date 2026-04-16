import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/add_player_controller.dart';
import '../controller/player_comparison_controlller.dart';
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
        child: Column(
          children: [
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Obx(() => PopupMenuButton<String>(
                    onSelected: (value) => controller.selectedSeason.value = value,
                    itemBuilder: (context) => controller.seasons.map((e) =>
                        PopupMenuItem(value: e, child: Text(e))).toList(),
                    child: FilterSelectorCard(
                      label: "Season",
                      value: controller.selectedSeason.value,
                      onTap: null,
                    ),
                  )),
                  SizedBox(width: 8.w),

                  Obx(() => PopupMenuButton<String>(
                    onSelected: (value) => controller.selectedClub.value = value,
                    itemBuilder: (context) => controller.clubs.map((e) =>
                        PopupMenuItem(value: e, child: Text(e))).toList(),
                    child: FilterSelectorCard(
                      label: "Club",
                      value: controller.selectedClub.value,
                      onTap: null,
                    ),
                  )),
                  SizedBox(width: 8.w),

                  Obx(() => PopupMenuButton<String>(
                    onSelected: (value) => controller.selectedPosition.value = value,
                    itemBuilder: (context) => controller.positions.map((e) =>
                        PopupMenuItem(value: e, child: Text(e))).toList(),
                    child: FilterSelectorCard(
                      label: "Position",
                      value: controller.selectedPosition.value,
                      onTap: null,
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 28.h),
        PlayerListWidget(
          players: controller.playerList,
          onAddTap: (player) {
            int slot = Get.arguments ?? 1;
            Get.find<PlayerComparisonController>().selectPlayer(player, slot);
          },
        ),
          ],
        ),
      ),
    );
  }
}
