import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../services/storage/storage_services.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';
import '../controller/tournament_player_register_controller.dart';

class TournamentPlayerRegisterScreen extends StatelessWidget {
  TournamentPlayerRegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (Navigator.canPop(context)) {
          Get.back();
        } else {
          if (LocalStorage.isLogIn) {
            Get.offAllNamed(AppRoutes.navBarScreen);
          } else {
            Get.offAllNamed(AppRoutes.signIn);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: const SignupAppbar(),
      body: GetBuilder<TournamentPlayerRegisterController>(
        init: TournamentPlayerRegisterController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Tournament\nPlayer Details',
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    bottom: 10,
                  ),
                  const CommonText(
                    text: 'Complete your profile to participate in upcoming tournaments and track your stats.',
                    fontSize: 16,
                    maxLines: 5,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    bottom: 32,
                  ),

                  CommonTextField(
                    title: "First Name",
                    controller: controller.playerFirstName,
                    hintText: 'Enter your first name here...',
                  ),
                  SizedBox(height: 24.h),

                  CommonTextField(
                    title: "Last Name",
                    controller: controller.playerLastName,
                    hintText: 'Enter your last name here...',
                  ),
                  SizedBox(height: 24.h),

                  CommonTextField(
                    title: "Phone Number",
                    controller: controller.phoneController,
                    hintText: 'Enter your phone number here...',
                    keyboardType: TextInputType.phone,
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
                          title: "Position",
                          hint: "Forward",
                          value: controller.selectedPosition,
                          items: controller.positions,
                          onChanged: (val) => controller.setPosition(val!),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDropdownField(
                          title: "Strong Foot",
                          hint: "Select",
                          value: controller.selectedStrongFoot,
                          items: controller.strongFootOptions,
                          onChanged: (val) => controller.setStrongFoot(val!),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                  const CommonText(
                    text: "Proof / Id (Optional)",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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
                            ? (controller.pickedImage!.path.toLowerCase().endsWith('.pdf')
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
                                        SizedBox(height: 8.h),
                                        Text(
                                          controller.pickedImage!.path.split('/').last,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  )
                                : Image.file(controller.pickedImage!, fit: BoxFit.cover))
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

                  if (controller.isLoading) ...[
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
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],

                  SizedBox(height: 40.h),

                  CommonButton(
                    titleText: "Submit Registration",
                    isLoading: controller.isLoading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.submitRegistration();
                      }
                    },
                  ),

                  SizedBox(height: 32.h),
                  const Center(
                    child: CommonText(
                      text: 'By submitting, you agree to the\nTournament Player Terms of Service',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
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
    )
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
        CommonText(text: title, fontSize: 16, fontWeight: FontWeight.w400, bottom: 8),
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

  Widget _buildDatePickerField(BuildContext context, TournamentPlayerRegisterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(text: "Date Of Birth", fontSize: 16, fontWeight: FontWeight.w400, bottom: 8),
        InkWell(
          onTap: () => controller.selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
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
