import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/video_model.dart';

class BannerController extends GetxController {
  late final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  List<VideoModel> bannerVideos = [];
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    fetchBannerVideos();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page != currentPage.value) {
        currentPage.value = page;
      }
    });
    super.onInit();
  }

  Future<void> fetchBannerVideos() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.video);

      if (response.statusCode == 200) {
        final videoResponse = VideoResponse.fromJson(response.data);
        bannerVideos = videoResponse.data;
      }
    } catch (e) {
      debugPrint('❌ fetchBannerVideos error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
