import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/features/auth/sign%20up/presentation/controller/verify_player_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';

class VerifyPlayerScreen extends StatelessWidget {
  VerifyPlayerScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: SignupAppbar(),
      body: GetBuilder<VerifyPlayerController>(
        init: VerifyPlayerController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Verify Your\nStatus',
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    bottom: 10,
                  ),
                  const CommonText(
                    text: 'Submit your credentials to unlock official league features, player stats tracking, and roster management tools.',
                    fontSize: 16,
                    maxLines: 5,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    bottom: 32,
                  ),

                  CommonTextField(
                    title: "Player First Name",
                    controller: controller.playerFirstName,
                    hintText: 'Enter your player first name here...',
                  ),
                  SizedBox(height: 24.h),

                  CommonTextField(
                    title: "Player Last Name",
                    controller: controller.playerLastName,
                    hintText: 'Enter your player last name here...',
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      Expanded(
                        child: _buildDatePickerField(context, controller),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDropdownField(
                          title: "Age Group",
                          hint: "Select",
                          value: controller.selectedAgeGroup,
                          items: controller.ageGroups,
                          onChanged: (val) => controller.setAgeGroup(val!),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          title: "Select Team",
                          hint: "Select team...",
                          value: controller.selectedTeam,
                          items: controller.teams,
                          onChanged: (val) => controller.setTeam(val!),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDropdownField(
                          title: "Position",
                          hint: "Forward",
                          value: controller.selectedPosition,
                          items: controller.positions,
                          onChanged: (val) => controller.setPosition(val!),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                  CommonText(
                    text: "Proof / ID (Optional)",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    bottom: 10,
                  ),

                  /// ── Image Upload Section ──
                  GestureDetector(
                    onTap: () => controller.pickIdImage(),
                    child: Container(
                      width: double.infinity,
                      height: 156.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: controller.pickedImage != null
                            ? Image.file(controller.pickedImage!, fit: BoxFit.cover)
                            : Center(
                          child: CommonImage(
                            imageSrc: "assets/images/upload_file_image.png",
                            width: double.infinity,
                            height: 156.h,
                            fill: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),

                  CommonButton(
                    titleText: "Submit Request",
                    //isLoading: controller.isLoading,
                    onTap: () async {
                      await controller.submitVerification();
                      Get.toNamed(AppRoutes.successful_create_account);
                    },
                  ),

                  SizedBox(height: 32.h),
                  const Center(
                    child: CommonText(
                      text: 'By submitting, you agree to the\nAthlete Terms of Service',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      color: Color(0xff373737),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(text: title, fontSize: 16, fontWeight: FontWeight.w600, bottom: 8),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          style: TextStyle(fontSize: 14.sp, color: AppColors.black),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDatePickerField(BuildContext context, VerifyPlayerController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(text: "Date Of Birth", fontSize: 16, fontWeight: FontWeight.w600, bottom: 8),
        InkWell(
          onTap: () => controller.selectDate(context),
          child: Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.selectedDob ?? "dd/mm/yyyy",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}