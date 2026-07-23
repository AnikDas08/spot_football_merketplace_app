import 'package:flutter/material.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
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
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: SignupAppbar(),

      /// Body Section Starts Here
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<SignUpController>(
            builder: (controller) {
              return SingleChildScrollView(
                padding: .symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100.h),
                      /// Sign UP Instructions here
                      const CommonText(
                        text: AppString.createYourAccount,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                        color: Colors.white,
                        bottom: 10,
                      ),

                      /// ── Subtitle ──
                      const CommonText(
                        text: 'Register For the ENG App Today',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        color: Colors.white70,
                      ),

                      SizedBox(height: 48.h,),

                      /// All Text Filed here
                      SignUpAllField(
                        controller: controller,
                        titleColor: Colors.white,
                      ),

                      48.height,

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
        ],
      ),
    );
  }
}
