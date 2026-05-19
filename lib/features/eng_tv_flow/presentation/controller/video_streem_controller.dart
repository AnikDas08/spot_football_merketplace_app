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
  var videoDetail = Rxn<VideoModel>();
  RxString videoLink = "".obs;

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

      final response = await apiClient.get("${ApiEndPoint.video}/$id");

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          videoDetail.value = VideoModel.fromJson(response.data['data']);
          
          String rawPath = videoDetail.value?.videoUrl ?? "";
          if (rawPath.isNotEmpty) {

            String cleanPath = rawPath.startsWith('/') ? rawPath : '/$rawPath';
            videoLink.value = "${ApiEndPoint.videoUrl}${Uri.encodeFull(cleanPath)}";



            debugPrint("✅ Full Video Links: ${videoLink.value}");

          }

          debugPrint("✅ Full Video Link: ${videoLink.value}");
        }
      }
    } catch (e) {
      debugPrint('❌ fetchVideoById error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  final List<Map<String, String>> videoList = [
    {
      "title": "Ref Cam: Brobbey's Dramatic Tyne-Wear Derby Goal",
      "description": "See Anthony Taylor's view of Brian Brobbey's late winner against Newcastle",
      "timeAgo": "2 days ago",
      "image": TempImage.playerVideo,
      "videoLink": 'https://github.com/mdarif3499/video/raw/refs/heads/main/AngelDiMaria.mp4'
    },
    {
      "title": "Match Highlights: Arsenal vs Man City",
      "description": "Catch up on all the action from the thrilling 2-2 draw at the Emirates",
      "timeAgo": "1 day ago",
      "image": TempImage.playerVideo,
      "videoLink": 'https://github.com/mdarif3499/video/raw/refs/heads/main/videoplayback.mp4'
    },
    {
      "title": "Top 10 Goals of the Week",
      "description": "A countdown of the most spectacular strikes across Europe's top leagues",
      "timeAgo": "5 hours ago",
      "image": TempImage.playerVideo,
      "videoLink": 'https://raw.githubusercontent.com/mdarif3499/video/main/AngelDiMaria.mp4'
    },
  ];
}
