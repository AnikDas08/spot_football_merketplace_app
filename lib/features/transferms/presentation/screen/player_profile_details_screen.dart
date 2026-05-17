import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../player_profile/presentation/controllers/player_profile_controller.dart';
import '../../../player_profile/presentation/widgets/player_header_widget.dart';
import '../widget/customInfo_card.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';

class PlayerProfileDetailsScreen extends StatelessWidget {
  const PlayerProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.playerProfile),
      body: GetBuilder<PlayerProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                PlayerHeaderWidget(),
                SizedBox(height: 16.h),
                CustomInfoCard(
                  title: 'Personal Details',
                  statusImage: AppImages.approved,
                  details: {
                    'Player Name': 'Emerson Royal',
                    'Date Of Birth': '04/03/2026',
                    'Age Group': 'Under 12',
                    'Previous Club': 'TITANS FC',
                    'Position': 'Forward',
                    'Strong Foot': 'Left',
                  },
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),

                  child: CommonButton(
                    titleText: "Offer Trial",
                    buttonColor: AppColors.primaryColor,
                  onTap: (){
                      Get.toNamed(AppRoutes.transferPendingApproval);
                  },),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
