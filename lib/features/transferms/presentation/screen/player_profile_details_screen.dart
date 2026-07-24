import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/button/common_button.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../player_profile/presentation/controllers/player_profile_controller.dart';
import '../../../player_profile/presentation/widgets/player_header_widget.dart';
import '../widget/customInfo_card.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';

class PlayerProfileDetailsScreen extends StatelessWidget {
  const PlayerProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(PlayerProfileController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.playerProfile),
      body: GetBuilder<PlayerProfileController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.playerData == null) {
            return const Center(child: Text("No player details found"));
          }

          final data = controller.playerData!;
          final firstName = data['firstName'] ?? "";
          final lastName = data['lastName'] ?? "";
          final fullName = "$firstName $lastName";

          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerHeaderWidget(
                  playerName: fullName,
                  position: data['position'] ?? "N/A",
                  profileImage: data['profile'],
                ),
                SizedBox(height: 16.h),
                CustomInfoCard(
                  title: 'Personal Details',
                  statusImage: AppImages.approved,
                  details: {
                    'Player Name': fullName,
                    'Date Of Birth': data['dateOfBirth'] != null
                        ? data['dateOfBirth'].toString().split('T')[0]
                        : 'N/A',
                    'Team': data['selectTeam'] ?? 'N/A',
                    'Strong Foot': data['strongFoot'] ?? 'N/A',
                    'Phone': data['phone'] ?? 'N/A',
                    'Status': data['status'] ?? 'N/A',
                  },
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CommonButton(
                    titleText: "Offer Trial",
                    isLoading: controller.isOfferingTrial,
                    buttonColor: AppColors.primaryColor,
                    onTap: () {
                      controller.offerTrial();
                    },
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
