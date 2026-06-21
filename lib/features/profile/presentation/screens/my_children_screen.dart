import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/profile/presentation/controller/profile_controller.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/image/common_image.dart';

class MyChildrenScreen extends StatelessWidget {
  const MyChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: AppString.myPlayer),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          if (controller.isProfileLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          }

          final data = controller.profileData;
          final String firstName = controller.firstNameController.text;
          final String lastName = controller.lastNameController.text;
          final String fullName = "$firstName $lastName".trim();
          final String imageUrl = data['profile'] ?? "";
          final String clubName = controller.teamController.text;
          final String position = controller.positionController.text;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                _buildActiveAthletesHeader(),
                SizedBox(height: 24.h),
                _buildChildCard(
                  userId: data['userId'] ?? LocalStorage.userId,
                  name: fullName.isEmpty ? (data['userName'] ?? "Player") : fullName,
                  image: imageUrl,
                  club: clubName.isEmpty ? "No Club" : clubName,
                  position: position.isEmpty ? "N/A" : position,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveAthletesHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: AppString.activeAthletes,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            bottom: 8,
          ),
          CommonText(
            text: AppString.manageYourChildrenSports,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard({
    required String userId,
    required String name,
    required String image,
    required String club,
    required String position,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: CommonImage(
                    imageSrc: image.isEmpty ? TempImage.profile : image,
                    width: 70.r,
                    height: 70.r,
                    fill: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: name,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _buildBadge(position),
                        SizedBox(width: 8.w),
                        _buildBadge(club, isTeam: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.nextGame,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondaryColor,
                    ),
                    CommonText(
                      text: "TBA",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.playerProfile, arguments: {
                      'userId': userId,
                      'isFromMyChildren': true,
                    });
                  },
                  child: Row(
                    children: [
                      CommonText(
                        text: AppString.viewProfile,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 4.w),
                      const Icon(Icons.arrow_forward, size: 16, color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, {bool isTeam = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isTeam ? const Color(0xFFE8F9F1) : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isTeam) ...[
            const Icon(Icons.sports_soccer, size: 14, color: Color(0xFF19CA77)),
            SizedBox(width: 4.w),
          ],
          CommonText(
            text: text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isTeam ? const Color(0xFF19CA77) : AppColors.textSecondaryColor,
          ),
        ],
      ),
    );
  }
}
