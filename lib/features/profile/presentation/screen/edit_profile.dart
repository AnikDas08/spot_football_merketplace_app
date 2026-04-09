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
        final userImage = LocalStorage.user.image;

        return Scaffold(
          /// AppBar
          appBar: SecondaryAppBar(title: AppString.editProfile),

          /// Body
          body: SingleChildScrollView(
            padding: .symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Profile image
                  Stack(
                    alignment: .bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70.r,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: controller.image != null
                              ? Image.file(
                                  File(controller.image!),
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.contain,
                                )
                              : CommonImage(
                                  imageSrc: userImage.isEmpty
                                      ? TempImage.profile
                                      : userImage,
                                  width: 140,
                                  height: 140,
                                ),
                        ),
                      ),

                      /// Edit icon
                      IconButton(
                        onPressed: controller.getProfileImage,
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  30.height,

                  /// Update avatar
                  Align(
                    child: CommonText(
                      text: AppString.updateAvatar.toUpperCase(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight(510),
                      color: AppColors.textSecondaryColor,
                    ),
                  ),

                  /// Fields
                  EditProfileAllFiled(controller: controller),

                  30.height,

                  /// Save button
                  CommonButton(
                    titleText: AppString.saveAndChanges,
                    isLoading: controller.isLoading,
                    onTap: controller.editProfileRepo,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
