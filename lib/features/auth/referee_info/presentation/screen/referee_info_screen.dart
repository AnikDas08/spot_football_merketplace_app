import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/component/text_field/common_text_field.dart';
import 'package:untitled/features/auth/referee_info/presentation/controller/referee_info_controller.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/helpers/validation.dart';

class RefereeInfoScreen extends StatefulWidget {
  const RefereeInfoScreen({super.key});

  @override
  State<RefereeInfoScreen> createState() => _RefereeInfoScreenState();
}

class _RefereeInfoScreenState extends State<RefereeInfoScreen> {
  final RefereeInfoController controller = Get.put(RefereeInfoController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                const CommonText(
                  text: 'Referee Info',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  bottom: 8,
                ),
                const CommonText(
                  text:
                      'Set your officiating preferences to get matched with the right games.',
                  fontSize: 16,
                  maxLines: 2,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color373737,
                  bottom: 24,
                  textAlign: TextAlign.start,
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
                    Expanded(child: _buildDatePickerField(context, controller)),
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

                const CommonText(
                  text: "ID Card",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  bottom: 8,
                ),

                /// ── ID Card Upload Section ──
                GetBuilder<RefereeInfoController>(
                  builder: (controller) {
                    return _buildFileUploadSection(
                      file: controller.pickedIdCard,
                      onTap: () => controller.pickIdCard(),
                    );
                  },
                ),

                /// Upload Progress Indicator
                Obx(() {
                  if (controller.isLoading.value) {
                    return Column(
                      children: [
                        SizedBox(height: 20.h),
                        LinearProgressIndicator(
                          value: controller.uploadProgress.value,
                          backgroundColor: Colors.grey.shade200,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 8.h),
                        Center(
                          child: CommonText(
                            text:
                                "Uploading: \${(controller.uploadProgress.value * 100).toStringAsFixed(0)}%",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),

                SizedBox(height: 40.h),

                /// Continue Button
                Obx(
                  () => CommonButton(
                    titleText: "Continue",
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.completeProcess();
                      }
                    },
                  ),
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadSection({
    required File? file,
    required VoidCallback onTap,
  }) {
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
                              file.path.toLowerCase().endsWith('.pdf')
                                  ? Icons.picture_as_pdf
                                  : Icons.description,
                              size: 48.sp,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                file.path
                                    .split(Platform.isWindows ? '\\\\' : '/')
                                    .last,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
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

  Widget _buildDatePickerField(
    BuildContext context,
    RefereeInfoController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          text: "Date Of Birth",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          bottom: 8,
        ),
        GetBuilder<RefereeInfoController>(
          builder: (controller) {
            return InkWell(
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
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
