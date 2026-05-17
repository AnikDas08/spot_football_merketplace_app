import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/component/text_field/common_text_field.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/helpers/validation.dart';
import '../controller/trial_registration_controller.dart';

class TrialRegistrationScreen extends StatefulWidget {
  const TrialRegistrationScreen({super.key});

  @override
  State<TrialRegistrationScreen> createState() => _TrialRegistrationScreenState();
}

class _TrialRegistrationScreenState extends State<TrialRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: "Get discovered\nby clubs",
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    bottom: 10,
                  ),
                  const CommonText(
                    text: "Create your profile and get trial opportunities to unlock official league features and tracking tools.",
                    fontSize: 16,
                    maxLines: 5,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    bottom: 32,
                  ),

                  /// First Name
                  CommonTextField(
                    title: "First Name",
                    controller: controller.firstNameController,
                    hintText: 'Enter your first name here...',
                    validator: AppValidation.required,
                  ),
                  SizedBox(height: 24.h),

                  /// Last Name
                  CommonTextField(
                    title: "Last Name",
                    controller: controller.lastNameController,
                    hintText: 'Enter your last name here...',
                    validator: AppValidation.required,
                  ),
                  SizedBox(height: 24.h),

                  /// DOB and Phone
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDatePickerField(context, controller),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CommonTextField(
                          title: "Phone Number",
                          controller: controller.phoneController,
                          hintText: 'Enter phone...',
                          validator: AppValidation.required,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  /// Team Selection and Strong Foot
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildTeamDropdown(controller),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildStrongFootDropdown(controller),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                   CommonText(
                    text: "Document / ID Card",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    bottom: 10,
                  ),

                  /// File Upload Section
                  _buildFileUploadSection(
                    file: controller.pickedDocument,
                    onTap: () => controller.pickDocument(),
                  ),

                  /// Upload Progress Indicator
                  if (controller.isLoading)
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        LinearProgressIndicator(
                          value: controller.uploadProgress,
                          backgroundColor: Colors.grey.shade200,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 8.h),
                        Center(
                          child: CommonText(
                            text: "Uploading: ${(controller.uploadProgress * 100).toStringAsFixed(0)}%",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: 40.h),

                  /// Submit Button
                  CommonButton(
                    titleText: "Submit Request",
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.submitRequest();
                      }
                    },
                  ),

                  SizedBox(height: 32.h),
                   Center(
                    child: CommonText(
                      text: "By submitting, you agree to the\nAthlete Terms of Service",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      color: Color(0xff373737),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamDropdown(TrialRegistrationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CommonText(
          text: "Select Team",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          bottom: 8,
        ),
        DropdownButtonFormField<String>(
          value: controller.selectedTeam,
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
          validator: (value) => value == null ? 'Field is required' : null,
        ),
      ],
    );
  }

  Widget _buildStrongFootDropdown(TrialRegistrationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CommonText(
          text: "Strong Foot",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          bottom: 8,
        ),
        DropdownButtonFormField<String>(
          value: controller.selectedStrongFoot,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          style: TextStyle(fontSize: 14.sp, color: AppColors.black),
          decoration: _dropdownDecoration("Select foot..."),
          items: controller.strongFeet.map((foot) {
            return DropdownMenuItem<String>(
              value: foot,
              child: Text(foot, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (val) => controller.setStrongFoot(val!),
          validator: (value) => value == null ? 'Field is required' : null,
        ),
      ],
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
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildFileUploadSection({required File? file, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
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
          child: file != null
              ? (file.path.toLowerCase().endsWith('.pdf') ||
              file.path.toLowerCase().endsWith('.doc') ||
              file.path.toLowerCase().endsWith('.docx')
              ? Container(
            color: Colors.grey.shade50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  file.path.toLowerCase().endsWith('.pdf') ? Icons.picture_as_pdf : Icons.description,
                  size: 48.sp,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    file.path.split(Platform.isWindows ? '\\\\' : '/').last,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )
              : Image.file(file, fit: BoxFit.cover))
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
    );
  }

  Widget _buildDatePickerField(BuildContext context, TrialRegistrationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CommonText(text: "Date Of Birth", fontSize: 16.sp, fontWeight: FontWeight.w500, bottom: 8),
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