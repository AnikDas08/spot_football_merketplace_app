import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/component/text_field/common_text_field.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/common_dropdown_field/common_dropdown_field.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../home/presentation/widgets/latest_news.dart';
import '../../../home/presentation/widgets/latest_videos.dart';
import '../../../player_profile/presentation/controllers/player_profile_controller.dart';
import '../../../player_profile/presentation/widgets/eng_record_widget.dart';
import '../../../player_profile/presentation/widgets/personal_details_widget.dart';
import '../../../player_profile/presentation/widgets/player_header_widget.dart';
import '../../../player_profile/presentation/widgets/recent_performance.dart';
import '../controller/transfer_form_controller.dart';
import '../widget/customInfo_card.dart';
import '../widget/offer_summary_card.dart';
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
                    titleText: "Submit Offer",
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
