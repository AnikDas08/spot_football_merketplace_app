import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/image/common_image.dart';

class SlideableImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const SlideableImageViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  static void show(BuildContext context, List<String> images, int index) {
    Get.dialog(
      SlideableImageViewer(imageUrls: images, initialIndex: index),
      useSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: initialIndex);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background Backdrop (Tap to close)
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
            ),
          ),

          // Slideable Images
          PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CommonImage(
                        imageSrc: imageUrls[index],
                        width: double.infinity,
                        fill: BoxFit.contain,
                        placeholderColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Close Button
          Positioned(
            top: 40.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.black, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
