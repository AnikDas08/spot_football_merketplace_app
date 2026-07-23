import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../component/button/common_button.dart';
import '../../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final String supportEmail = 'contact@engsportsevents.com';

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(ClipboardData(text: supportEmail));
    Get.snackbar(
      "Copied",
      "Email address copied to clipboard",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _sendDeletionEmail() async {
    final String userEmail = LocalStorage.myEmail;
    final String reason = _reasonController.text.trim();

    if (reason.isEmpty) {
      Get.snackbar(
        "Input Required",
        "Please provide a reason for deletion",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Account Deletion Request',
        'body': 'User Email: $userEmail\n\nReason for deletion:\n$reason',
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Fallback: Try opening in web if mailto fails
      final Uri webUri = Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=$supportEmail&su=Account%20Deletion%20Request&body=User%20Email:%20$userEmail%0A%0AReason%20for%20deletion:%0A$reason');
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          "Notice",
          "Could not open email app. Please manually email $supportEmail",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: AppString.deleteAccount),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.deleteAccount,
              style: GoogleFonts.playfairDisplay(
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            const CommonText(
              text: AppString.accountDeletionInstructions,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.color6B6B6B,
              maxLines: 4,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 32.h),

            /// User Email (ReadOnly)
            CommonTextField(
              title: AppString.emailAddress,
              controller: TextEditingController(text: LocalStorage.myEmail),
              readOnly: true,
              fillColor: Colors.grey.shade100,
            ),
            SizedBox(height: 24.h),

            /// Deletion Reason
            CommonTextField(
              title: AppString.reasonForDeletion,
              controller: _reasonController,
              hintText: "Enter your reason here...",
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 32.h),

            CommonButton(
              titleText: AppString.sendRequest,
              onTap: _sendDeletionEmail,
              buttonWidth: double.infinity,
            ),

            SizedBox(height: 24.h),

            /// Warning & Copyable Email
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20),
                      SizedBox(width: 8.w),
                      const Expanded(
                        child: CommonText(
                          text: "If the button doesn't open your email app, please email us manually at:",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color373737,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  InkWell(
                    onTap: _copyEmail,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.colorEABB00.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.copy_rounded, size: 16, color: AppColors.colorEABB00),
                          SizedBox(width: 8.w),
                          Text(
                            supportEmail,
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const CommonText(
                    text: "(Tap to copy email)",
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
