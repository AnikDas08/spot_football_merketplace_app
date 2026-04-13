import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_string.dart';

class AlreadyAccountRichText extends StatelessWidget {
  const AlreadyAccountRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppString.alreadyHaveAccount,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.secondary,
                fontSize: 16,
                fontWeight: .w500,
              ),
            ),

            /// Sign Up Button here
            TextSpan(
              text: AppString.login_text,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.signIn);
                },
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,      // underline
                decorationColor: AppColors.primaryColor,   // underline color
                decorationThickness: 2,                    // optional thickness
              ),
            ),
          ],
        ),
        textAlign: .center,
      ),
    );
  }
}
