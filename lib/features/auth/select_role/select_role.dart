import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../sign in/presentation/widgets/signup_appbar.dart';

class SelectRole extends StatelessWidget {
  SelectRole({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.h,),
              const CommonText(
                text: 'Select Your Role',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                color: AppColors.black,
                bottom: 10,
              ),

              /// ── Subtitle ──
              const CommonText(
                text: 'Please Select One Of The Following Which Applies To You - All Registrations Pending ENG Admin Approval',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                maxLines: 3,
                color: AppColors.black,
                bottom: 32,
              ),

              SizedBox(height: 20,),
              CommonImage(
                  imageSrc: "assets/images/select_player.png",
                height: 124.h,
                width: double.infinity,
                fill: BoxFit.cover,
              ),
              SizedBox(height: 20,),

              CommonImage(
                imageSrc: "assets/images/select_manager.png",
                height: 124.h,
                width: double.infinity,
                fill: BoxFit.cover,
              ),

              SizedBox(height: 40,),
              CommonButton(
                  onTap: (){
                    Get.toNamed(AppRoutes.player_registration_screen);
                  },
                  titleText: "Continue"
              ),

              SizedBox(height: 20.h,),

              Center(
                child: CommonText(
                    text: "You can switch your primary role\nlater in settings.",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  color: AppColors.black,
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}

/// ── Social Login Button ──────────────────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.black.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 22.h,
              width: 22.w,
            ),
            12.width,
            CommonText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}