import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/image/common_image.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controllers/club_profile_controller.dart';

import '../widgets/slideable_image_viewer.dart';

class AllGalleryScreen extends StatelessWidget {
  const AllGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: 'Gallery'),
      body: GetBuilder<ClubProfileController>(
        builder: (controller) {
          if (controller.galleryList.isEmpty) {
            return const Center(child: Text("No items found."));
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.w,
              crossAxisSpacing: 8.w,
              childAspectRatio: 1,
            ),
            itemCount: controller.galleryList.length,
            itemBuilder: (context, index) {
              final item = controller.galleryList[index];
              return GestureDetector(
                onTap: () => SlideableImageViewer.show(
                  context, 
                  controller.galleryList.map((e) => e.image).toList(), 
                  index
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                  ),
                  child: CommonImage(
                    imageSrc: item.image,
                    fill: BoxFit.cover,
                    borderRadius: 8.r,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
