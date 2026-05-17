import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../controller/sign_up_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../component/text_field/common_pin_code_field.dart';
import '../../../../../../../utils/constants/app_string.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SignUpController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: SignupAppbar(),

      /// Body Section starts here
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  /// Title
                  const CommonText(
                    text: "Verify Account",
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                    color: AppColors.black,
                    bottom: 10,
                  ),

                  /// Subtitle
                  const CommonText(
                    text: 'We sent a code to your email',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    color: AppColors.black,
                    bottom: 32,
                  ),

                  SizedBox(height: 20),

                  /// Card with PIN Code, Timer, and Resend Text
                  Card(
                    margin: .all(0),
                    elevation: 2,
                    color: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        /// PIN Code Fields - 4 boxes only
                        Center(
                          child: CommonPinCodeField(
                            controller: controller.otpController,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        /// Timer Display
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.filledColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time_filled_rounded,
                                color: AppColors.green,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              CommonText(
                                text: controller.time,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        /// Resend Text
                        GestureDetector(
                          onTap: controller.time == '00:00'
                              ? () {
                                  controller.startTimer();
                                  controller.signUpUser();
                                }
                              : () {},
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Didn't receive a code? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "Resend Code",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 36.h),
                        CommonButton(
                          titleText: "Verify",
                          isLoading: controller.isLoading,
                          onTap: () {
                               controller.verifyOtp();
                            // if (_formKey.currentState!.validate()) {
                            //
                            // }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 48.h),

                  ///  Submit Button
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
