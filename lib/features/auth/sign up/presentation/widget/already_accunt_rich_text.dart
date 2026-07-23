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
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            /// Sign Up Button here
            TextSpan(
              text: AppString.loginText,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.signIn);
                },
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,      // underline
                decorationColor: AppColors.yellow,   // underline color
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
