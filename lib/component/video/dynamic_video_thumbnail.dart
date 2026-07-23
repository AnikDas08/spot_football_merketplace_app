import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../image/common_image.dart';
import '../custom_shimmer/custom_shimmer.dart';
import 'thumbnail_controller.dart';
import '../../utils/constants/temp_image.dart';

class DynamicVideoThumbnail extends StatelessWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const DynamicVideoThumbnail({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Check if we have a valid remote thumbnail URL
    final bool hasRemoteThumbnail = thumbnailUrl != null && 
                                    thumbnailUrl!.isNotEmpty && 
                                    thumbnailUrl!.startsWith('http') &&
                                    thumbnailUrl!.length > 35;

    if (hasRemoteThumbnail) {
      return CommonImage(
        imageSrc: thumbnailUrl!,
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        fill: fit,
      );
    }

    // 2. If no valid remote thumbnail, attempt generation using GetX controller
    if (videoUrl.isEmpty || !videoUrl.startsWith('http')) {
       return _buildFallbackWidget();
    }

    return GetBuilder<ThumbnailController>(
      init: ThumbnailController(videoUrl),
      tag: videoUrl,
      builder: (controller) {
        return Obx(() {
          if (controller.localPath.value != null) {
            return Image.file(
              File(controller.localPath.value!),
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              fit: fit,
              errorBuilder: (_, __, ___) => _buildFallbackWidget(),
            );
          } else if (controller.isGenerating.value) {
            return CustomShimmer.rectangular(
              height: height ?? double.infinity,
              width: width ?? double.infinity,
            );
          } else {
            return _buildFallbackWidget();
          }
        });
      },
    );
  }

  Widget _buildFallbackWidget() {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      color: Colors.grey.shade100,
      child: Image.asset(
        TempImage.videoThumbnail,
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        fit: fit,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.videocam_outlined, color: Colors.grey, size: 30),
        ),
      ),
    );
  }
}
