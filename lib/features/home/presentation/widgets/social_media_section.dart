import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/extensions/extension.dart';

import '../../../../component/image/common_image.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../controllers/club_profile_controller.dart';
import '../../data/social_media_model.dart';

class SocialMediaSection extends StatelessWidget {
  final Color? titleColor;
  const SocialMediaSection({super.key, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClubProfileController>(
      builder: (controller) {
        if (controller.socialMediaList.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Our Social Platforms'.toTitleCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12.w,
                runSpacing: 12.h,
                children: controller.socialMediaList.map((social) {
                  return _SocialCard(social: social);
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SocialCard extends StatelessWidget {
  final SocialMediaModel social;
  const _SocialCard({required this.social});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(social.url);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint('Could not launch ${social.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (social.icon.isNotEmpty)
              CommonImage(
                imageSrc: social.icon,
                width: 36.w,
                height: 36.h,
                fill: BoxFit.contain,
              )
            else
              _buildPlatformIcon(social.platform),
            SizedBox(height: 6.h),
            Text(
              social.platform,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformIcon(String platform) {
    String? assetPath;

    switch (platform.toLowerCase()) {
      case 'facebook':
        assetPath = AppImages.facebook;
        break;
      case 'instagram':
        assetPath = AppImages.instagram;
        break;
      case 'twitter':
      case 'x':
      case 'twitter / x':
        assetPath = AppImages.twitterX;
        break;
      case 'youtube':
        assetPath = AppImages.youtube;
        break;
      case 'tiktok':
        assetPath = AppImages.tiktok;
        break;
      case 'linkedin':
        assetPath = AppImages.linkedin;
        break;
      case 'telegram':
        assetPath = AppImages.telegram;
        break;
      case 'whatsapp':
        assetPath = AppImages.whatsapp;
        break;
    }

    if (assetPath != null) {
      return Image.asset(
        assetPath,
        width: 36.w,
        height: 36.h,
        fit: BoxFit.contain,
      );
    }

    // Fallback icons for other platforms
    IconData iconData = Icons.link;
    Color iconColor = Colors.grey;

    return Icon(iconData, color: iconColor, size: 28.sp);
  }
}
