import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import '../controller/record_goal_controller.dart';

class RecordGoalScreen extends StatelessWidget {
  const RecordGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecordGoalController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'RECORD GOAL'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: 'SCORING PLAYER',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Obx(() => DropdownButton<String>(
                            value: controller.selectedTeam.value,
                            items: ['Tigers FC', 'Lions FC'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CommonText(
                                  text: value,
                                  fontSize: 15,
                                  fontWeight: FontWeight(510),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) controller.updateTeam(val);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildPlayerList(controller),
              SizedBox(height: 24.h),
              CommonText(
                text: 'GOAL TYPE',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 16.h),
              _buildGoalTypeGrid(controller),
              SizedBox(height: 24.h),
              _buildAssistSection(controller),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: CommonText(
                    text: 'Confirm Goal',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerList(RecordGoalController controller) {
    return SizedBox(
      height: 100.h,
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.players.length,
            itemBuilder: (context, index) {
              final isSelected = controller.selectedPlayerIndex.value == index;
              return GestureDetector(
                onTap: () => controller.updatePlayerIndex(index),
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Column(
                    children: [
                      Stack(
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
                              backgroundImage: AssetImage(controller.players[index]['image']!),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFFFD54F)
                                    : Color(0xFFF2F1FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CommonText(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                                text: controller.players[index]['number']!,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: controller.players[index]['name']!,
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
            },
          )),
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
        _buildGoalTypeButton(controller, 'Regular Goal', Icons.sports_soccer),
        _buildGoalTypeButton(controller, 'Header', Icons.accessibility_new),
        _buildGoalTypeButton(controller, 'Penalty', Icons.adjust),
        _buildGoalTypeButton(controller, 'Free Kick', Icons.sports_handball),
      ],
    );
  }

  Widget _buildGoalTypeButton(RecordGoalController controller, String type, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedGoalType.value == type;
      return GestureDetector(
        onTap: () => controller.updateGoalType(type),
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
                child: Icon(icon, size: 20, color: Colors.black),
              ),
              SizedBox(width: 8.w),
              CommonText(text: type, fontSize: 16, fontWeight: FontWeight(590)),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAssistSection(RecordGoalController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6ED),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'ASSIST (OPTIONAL)',
            fontSize: 16,
            fontWeight: FontWeight(590),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedAssistPlayer.value,
                    hint: CommonText(
                      text: 'Select player who assisted...',
                      fontSize: 15,
                      color: const Color(0xFF9E9E9E),
                    ),
                    items: controller.players.map((player) {
                      String displayName =
                          "${player['name']} (${player['number']})";
                      return DropdownMenuItem<String>(
                        value: displayName,
                        child: CommonText(
                          text: displayName,
                          fontSize: 15,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => controller.updateAssistPlayer(val),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF9E9E9E),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
