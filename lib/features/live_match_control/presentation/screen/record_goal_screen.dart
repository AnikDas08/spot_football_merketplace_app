import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import '../../../../component/image/common_image.dart';
import '../controller/record_goal_controller.dart';

class RecordGoalScreen extends StatelessWidget {
  const RecordGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecordGoalController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'RECORD MATCH EVENT'),
      body: Obx(() {
        if (controller.isLoading.value && controller.teamPlayers.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: 'SELECTED TEAM',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CommonText(
                        text: controller.selectedTeam.value,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildPlayerList(controller),
                SizedBox(height: 24.h),
                CommonText(
                  text: 'EVENT TYPE',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 16.h),
                _buildGoalTypeGrid(controller),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.submitEvent(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : CommonText(
                            text: 'Confirm Event',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPlayerList(RecordGoalController controller) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.teamPlayers.length,
        itemBuilder: (context, index) {
          final player = controller.teamPlayers[index];
          final name = "${player['firstName'] ?? ""} ${player['lastName'] ?? ""}".trim();
          final initial = (player['firstName']?[0] ?? player['userName']?[0] ?? "P").toUpperCase();

          return Obx(() {
            final isSelected = controller.selectedPlayerIndex.value == index;
            return GestureDetector(
              onTap: () => controller.updatePlayerIndex(index),
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF0056D2)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 28.r,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: CommonImage(
                            imageSrc: player['profile'] ?? "",
                            fill: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CommonText(
                      text: name.isNotEmpty ? name : (player['userName'] ?? "Player"),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? const Color(0xFF000000)
                          : const Color(0xFF9E9E9E),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildGoalTypeGrid(RecordGoalController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.8,
      children: [
        _buildGoalTypeButton(controller, 'Goal', 'goal', Icons.sports_soccer),
        _buildGoalTypeButton(controller, 'Assist', 'assist', Icons.handshake),
        _buildGoalTypeButton(controller, 'Yellow Card', 'yellow_card', Icons.square),
        _buildGoalTypeButton(controller, 'Red Card', 'red_card', Icons.square),
        _buildGoalTypeButton(controller, 'Foul', 'foul', Icons.front_hand),
        _buildGoalTypeButton(controller, 'Substitution', 'substitution', Icons.sync),
      ],
    );
  }

  Widget _buildGoalTypeButton(RecordGoalController controller, String label, String value, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedGoalType.value == value;
      Color iconColor = Colors.black;
      if (value == 'yellow_card') iconColor = Colors.yellow;
      if (value == 'red_card') iconColor = Colors.red;

      return GestureDetector(
        onTap: () => controller.updateGoalType(value),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFD54F) : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              SizedBox(width: 8.w),
              CommonText(text: label, fontSize: 13.sp, fontWeight: FontWeight(590)),
            ],
          ),
        ),
      );
    });
  }
}
