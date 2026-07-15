import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/add_player_controller.dart';
import '../controller/player_comparison_controlller.dart';
import '../widget/action_appbar.dart';
import '../widget/filter_selector_card.dart';
import '../widget/player_list_widget.dart';
import '../../../../utils/constants/app_colors.dart';

class AddPlayerScreen extends StatelessWidget {
  const AddPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller-ti put korle eita properly initialized hobe
    final AddPlayerController controller = Get.put(AddPlayerController());

    return Scaffold(
      appBar: ActionAppBar(
        title: 'SELECT PLAYER', 
        onResetTap: () => controller.resetFilters(),
        onSearchChanged: (value) => controller.onSearch(value),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  // Club Filter Dropdown
                  Expanded(
                    child: Obx(() => PopupMenuButton<Map<String, dynamic>>(
                      onSelected: (value) => controller.updateClub(value['id'], value['name']),
                      itemBuilder: (context) {
                        List<PopupMenuEntry<Map<String, dynamic>>> items = [
                          const PopupMenuItem(
                            value: {'id': '', 'name': 'All Clubs'},
                            child: Text('All Clubs'),
                          ),
                        ];
                        items.addAll(controller.clubList.map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e['name']),
                        )).toList());
                        return items;
                      },
                      child: FilterSelectorCard(
                        label: "Club",
                        value: controller.selectedClubName.value,
                        onTap: null, // FilterSelectorCard handled internally by PopupMenuButton
                      ),
                    )),
                  ),
                  SizedBox(width: 12.w),
                  // Position Filter Dropdown
                  Expanded(
                    child: Obx(() => PopupMenuButton<String>(
                      onSelected: (value) => controller.updatePosition(value),
                      itemBuilder: (context) => controller.positions.map((e) =>
                          PopupMenuItem(value: e, child: Text(e))).toList(),
                      child: FilterSelectorCard(
                        label: "Position",
                        value: controller.selectedPosition.value,
                        onTap: null,
                      ),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                }
                
                if (controller.filteredPlayerList.isEmpty) {
                  return const Center(child: Text("No players found"));
                }

                return PlayerListWidget(
                  players: controller.filteredPlayerList,
                  onAddTap: (player) {
                    int slot = Get.arguments ?? 1;
                    Get.find<PlayerComparisonController>().selectPlayer(player, slot);
                    Get.back();
                  },
                );
              }),
            ),
            Obx(() {
              if (controller.isMoreLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
