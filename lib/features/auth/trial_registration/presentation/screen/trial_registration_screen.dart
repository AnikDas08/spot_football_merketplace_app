import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/component/text_field/common_text_field.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import '../controller/trial_registration_controller.dart';

class TrialRegistrationScreen extends StatelessWidget {
  const TrialRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: GetBuilder<TrialRegistrationController>(
        init: TrialRegistrationController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: "Get discovered\nby clubs",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  bottom: 12,
                ),
                const CommonText(
                  text: "Create your profile and get trial opportunities.",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  bottom: 24,
                ),

                CommonTextField(
                  title: "Player First Name",
                  controller: controller.firstNameController,
                  hintText: "Enter your player first name here...",
                ),
                SizedBox(height: 16.h),

                CommonTextField(
                  title: "Player Last Name",
                  controller: controller.lastNameController,
                  hintText: "Enter your player last name here...",
                ),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildDatePickerField(context, controller),
                    ),
                    SizedBox(width: 16.w),
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
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        title: "Previous Club",
                        hint: "Select club...",
                        value: controller.selectedPreviousClub,
                        items: controller.previousClubs,
                        onChanged: (val) => controller.setPreviousClub(val!),
                      ),
                    ),

                    SizedBox(width: 16.w),

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
                SizedBox(height: 16.h),

                _buildDropdownField(
                  title: "Strong Foot",
                  hint: "Select",
                  value: controller.selectedStrongFoot,
                  items: controller.strongFeet,
                  onChanged: (val) => controller.setStrongFoot(val!),
                ),
                SizedBox(height: 16.h),

                const CommonText(
                  text: "Profile Photo",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8,
                ),
                GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.profileImage != null)
                          const Icon(Icons.check_circle, color: AppColors.green, size: 40)
                        else ...[
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: const Icon(Icons.cloud_upload_outlined, color: Color(0xFFEABB00)),
                          ),
                          SizedBox(height: 8.h),
                          const CommonText(text: "Upload File", fontWeight: FontWeight.w600),
                          const CommonText(
                            text: "PDF, JPG or PNG (Max 5MB)",
                            fontSize: 10,
                            color: AppColors.color6B6B6B,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                CommonButton(
                  onTap: controller.submitRequest,
                  titleText: "Submit Request",
                  isLoading: controller.isLoading,
                ),
                SizedBox(height: 16.h),

                const Center(
                  child: CommonText(
                    text: "By submitting, you agree to the\nAthlete Terms of Service",
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    color: AppColors.color6B6B6B,
                  ),
                ),
              ],
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
              borderSide:  BorderSide(color: Colors.black),
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

  Widget _buildDatePickerField(BuildContext context, TrialRegistrationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

         CommonText(text: "Date Of Birth", fontSize: 16, fontWeight: FontWeight.w600, bottom: 8),

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
                 Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
