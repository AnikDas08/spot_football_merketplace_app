import 'dart:io';
import 'package:flutter/material.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../services/storage/storage_services.dart';
import '../controller/profile_controller.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../widgets/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        final userImage = LocalStorage.myImage;

        return Scaffold(
          backgroundColor: const Color(0xFFF3F3F3),
          /// AppBar
          appBar: SecondaryAppBar(title: AppString.editProfile),

          /// Body
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Profile image
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: controller.image != null
                                ? Image.file(
                                    File(controller.image!),
                                    width: 120.r,
                                    height: 120.r,
                                    fit: BoxFit.cover,
                                  )
                                : CommonImage(
                                    imageSrc: userImage.isEmpty
                                        ? TempImage.profile
                                        : userImage,
                                    width: 120.r,
                                    height: 120.r,
                                    fill: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),

                      /// Edit icon
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: controller.getProfileImage,
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  24.height,

                  /// Update avatar
                  CommonText(
                    text: AppString.updateAvatar.toUpperCase(),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  32.height,

                  /// Fields
                  EditProfileAllFiled(controller: controller),

                  40.height,

                  /// Save button
                  CommonButton(
                    titleText: AppString.saveAndChanges,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.editProfileRepo();
                      }
                    },
                  ),
                  24.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
