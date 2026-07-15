import 'dart:async';
import 'package:flutter/material.dart';
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
  final ScrollController scrollController = ScrollController();

  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  List<VideoModel> bannerVideos = [];
  RxInt currentPageIndex = 0.obs;
  Timer? _timer;

  int currentPage = 1;
  bool hasNextPage = true;

  @override
  void onInit() {
    fetchBannerVideos();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page != currentPageIndex.value) {
        currentPageIndex.value = page;
      }
    });
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && !isMoreLoading.value && hasNextPage) {
        loadMoreVideos();
      }
    }
  }

  void _startAutoSlide() {
    _timer?.cancel();
    if (bannerVideos.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (pageController.hasClients) {
          int nextPage = currentPageIndex.value + 1;
          if (nextPage >= bannerVideos.length) {
            nextPage = 0;
            pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          } else {
            pageController.nextPage(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    }
  }

  Future<void> fetchBannerVideos({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        bannerVideos.clear();
      }
      update();

      final response = await apiClient.get("${ApiEndPoint.video}?page=$currentPage&limit=10");

      if (response.statusCode == 200) {
        final dynamic responseData = response.data['data'];
        List<dynamic> data = [];
        
        if (responseData is List) {
          data = responseData;
          hasNextPage = false;
        } else if (responseData is Map) {
          data = responseData['videos'] ?? responseData['docs'] ?? [];
          final pagination = responseData['pagination'];
          if (pagination != null) {
            int totalPage = pagination['totalPage'] ?? 1;
            hasNextPage = currentPage < totalPage;
          } else {
            hasNextPage = false;
          }
        }

        final videoResponse = data.map((e) => VideoModel.fromJson(e)).toList();
        
        if (isLoadMore) {
          bannerVideos.addAll(videoResponse);
        } else {
          bannerVideos = videoResponse;
          _startAutoSlide();
        }
      }
    } catch (e) {
      debugPrint('❌ fetchBannerVideos error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreVideos() async {
    currentPage++;
    await fetchBannerVideos(isLoadMore: true);
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
