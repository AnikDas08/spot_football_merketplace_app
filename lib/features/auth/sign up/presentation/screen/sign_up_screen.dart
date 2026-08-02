import 'package:flutter/material.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../widget/already_accunt_rich_text.dart';
import '../widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

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

        /// Body Section Starts Here
        body: GetBuilder<SignUpController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    /// Sign UP Instructions here
                    const CommonText(
                      text: AppString.createYourAccount,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      color: AppColors.black,
                      bottom: 10,
                    ),

                    /// ── Subtitle ──
                    const CommonText(
                      text: 'Register For the ENG App Today',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      color: AppColors.primaryColor,
                    ),

                    SizedBox(height: 32.h),

                    /// All Text Filed here
                    SignUpAllField(controller: controller),

                    40.height,

                    /// Submit Button Here
                    CommonButton(
                      titleText: AppString.signUp,
                      isLoading: controller.isLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.goToRoleSelection();
                        }
                      },
                    ),
                    24.height,

                    ///  Sign In Instruction here
                    const AlreadyAccountRichText(),
                    30.height,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
