import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/extensions/extension.dart';

import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

import '../../../../utils/helpers/validation.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';

import '../controller/profile_controller.dart';

class EditProfileAllFiled extends StatelessWidget {
  final ProfileController controller;

  const EditProfileAllFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final role = LocalStorage.role.toUpperCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// First Name
        CommonTextField(
          title: "First Name",
          controller: controller.firstNameController,
          validator: AppValidation.required,
          hintText: "Enter first name",
          borderColor: AppColors.black,
          fillColor: AppColors.transparent,
        ),
        20.height,

        /// Last Name
        CommonTextField(
          title: "Last Name",
          controller: controller.lastNameController,
          validator: AppValidation.required,
          hintText: "Enter last name",
          borderColor: AppColors.black,
          fillColor: AppColors.transparent,
        ),
        20.height,

        /// Email
        CommonTextField(
          title: AppString.email,
          controller: controller.emailController,
          validator: AppValidation.email,
          hintText: "Enter email",
          borderColor: AppColors.black,
          fillColor: AppColors.transparent,
        ),
        20.height,

        /// Phone Number
        CommonTextField(
          title: AppString.phoneNumber,
          controller: controller.phoneController,
          validator: AppValidation.required,
          hintText: "Enter phone number",
          borderColor: AppColors.black,
          fillColor: AppColors.transparent,
        ),
        20.height,

        /// Date of Birth
        _buildLabel("Date Of Birth"),
        InkWell(
          onTap: () => controller.selectDate(context),
          child: Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.dobController.text.isEmpty
                      ? "yyyy-mm-dd"
                      : controller.dobController.text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.dobController.text.isEmpty
                        ? Colors.grey
                        : AppColors.black,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Colors.black54),
              ],
            ),
          ),
        ),
        20.height,

        /// Role Specific Fields
        if (role == 'PLAYER' || role == 'OTHER_CLUBS' || role == 'TRIAL' || role == 'MANAGER') ...[
          /// Team Selection
          _buildLabel(role == 'MANAGER' ? "Your Team" : "Select Team"),
          DropdownButtonFormField<String>(
            value: controller.teams.any((t) => t['_id'] == controller.selectedTeam)
                ? controller.selectedTeam
                : null,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            style: TextStyle(fontSize: 14.sp, color: AppColors.black),
            decoration: _dropdownDecoration("Select team..."),
            items: controller.teams.map((team) {
              return DropdownMenuItem<String>(
                value: team['_id'],
                child: Text(team['teamName'] ?? "", overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (val) => controller.setTeam(val!),
          ),
          20.height,
        ],

        if (role == 'PLAYER' || role == 'OTHER_CLUBS' || role == 'TRIAL') ...[
          /// Age Group
          _buildLabel("Age Group"),
          DropdownButtonFormField<String>(
            value: controller.selectedAgeGroup,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            style: TextStyle(fontSize: 14.sp, color: AppColors.black),
            decoration: _dropdownDecoration("Select group..."),
            items: controller.ageGroups.map((group) {
              return DropdownMenuItem<String>(
                value: group,
                child: Text(group),
              );
            }).toList(),
            onChanged: (val) => controller.setAgeGroup(val!),
          ),
          20.height,

          /// Position
          _buildLabel("Position"),
          DropdownButtonFormField<String>(
            value: controller.selectedPosition,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            style: TextStyle(fontSize: 14.sp, color: AppColors.black),
            decoration: _dropdownDecoration("Select position..."),
            items: controller.positions.map((pos) {
              return DropdownMenuItem<String>(
                value: pos,
                child: Text(pos),
              );
            }).toList(),
            onChanged: (val) => controller.setPosition(val!),
          ),
          20.height,
        ],
      ],
    );
  }

  Widget _buildLabel(String text) {
    return CommonText(
      text: text,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      bottom: 8,
    );
  }

  InputDecoration _dropdownDecoration(String hint) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    );
  }
}
