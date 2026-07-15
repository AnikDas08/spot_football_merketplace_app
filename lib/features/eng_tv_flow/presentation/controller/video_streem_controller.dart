import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../home/data/video_model.dart';
import '../../../../utils/constants/temp_image.dart';

class VideoStreamController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  var isRelatedLoading = false.obs;
  var videoDetail = Rxn<VideoModel>();
  RxString videoLink = "".obs;
  final RxList<VideoModel> relatedVideos = <VideoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final String? videoId = Get.arguments;
    if (videoId != null) {
      fetchVideoById(videoId);
    }
  }

  Future<void> fetchVideoById(String id) async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get("${ApiEndPoint.videoDetails}$id");

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          videoDetail.value = VideoModel.fromJson(response.data['data']);
          
          String rawPath = videoDetail.value?.videoUrl ?? "";
          if (rawPath.isNotEmpty) {
            String cleanPath = rawPath.startsWith('/') ? rawPath : '/$rawPath';
            videoLink.value = "${ApiEndPoint.videoUrl}${Uri.encodeFull(cleanPath)}";
          }

          // Fetch related videos based on category
          if (videoDetail.value?.category != null) {
            fetchRelatedVideos(videoDetail.value!.category);
          }
        }
      }
    } catch (e) {
      debugPrint('❌ fetchVideoById error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchRelatedVideos(String category) async {
    try {
      isRelatedLoading.value = true;
      update();

      final response = await apiClient.get("${ApiEndPoint.video}?category=$category");

      if (response.statusCode == 200) {
        final videoResponse = VideoResponse.fromJson(response.data);
        // Filter out the current video from the related list
        relatedVideos.value = videoResponse.data
            .where((v) => v.id != videoDetail.value?.id)
            .toList();
      }
    } catch (e) {
      debugPrint('❌ fetchRelatedVideos error: $e');
    } finally {
      isRelatedLoading.value = false;
      update();
    }
  }
}
