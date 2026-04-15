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
import '../../../sign in/presentation/widgets/signup_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';

class SuccessfulCreateAccount extends StatelessWidget {
  SuccessfulCreateAccount({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
        appBar: const SignupAppbar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonImage(
                  imageSrc: "assets/images/successful_image.png",
                  height: 128.h,
                  width: 128.w,
                ),
                SizedBox(height: 20.sp,),
                const CommonText(
                  text: 'Account\nCreated',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                  color: AppColors.black,
                  bottom: 10,
                ),

                /// ── Subtitle ──
                const CommonText(
                  text: 'Welcome to the League. Your arena is ready.',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  color: AppColors.primaryColor,
                  bottom: 32,
                ),

                const SizedBox(height: 40,),
                CommonButton(
                    onTap: () async {
                      // Mark as logged in
                      await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
                      LocalStorage.isLogIn = true;
                      Get.offAllNamed(AppRoutes.navBarScreen);
                    },
                    titleText: "Continue to App"
                ),

                SizedBox(height: 30.h,),
              ],
            ),
          ),
        )
    );
  }
}
