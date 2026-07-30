import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/video_model.dart';

import '../../data/video_category_model.dart';

class BannerController extends GetxController {
  late final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );
  final ScrollController scrollController = ScrollController();

  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  
  // Dynamic Categories Data
  final RxList<VideoCategoryModel> allCategories = <VideoCategoryModel>[].obs;
  final RxMap<String, List<VideoModel>> categoryVideosMap = <String, List<VideoModel>>{}.obs;
  final RxMap<String, bool> categoryLoadingMap = <String, bool>{}.obs;

  // Specific Home Screen Categories
  final RxList<VideoModel> leagueHighlightsVideos = <VideoModel>[].obs;
  final RxList<VideoModel> goalsOfTheWeekVideos = <VideoModel>[].obs;
  final RxList<VideoModel> refCamVideos = <VideoModel>[].obs;
  final RxList<VideoModel> featuredVideos = <VideoModel>[].obs;

  // Legacy field for backward compatibility
  List<VideoModel> bannerVideos = [];
  
  RxInt currentPageIndex = 0.obs;
  Timer? _timer;

  int currentPage = 1;
  bool hasNextPage = true;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page != currentPageIndex.value) {
        currentPageIndex.value = page;
      }
    });
    scrollController.addListener(_onScroll);
    
    // Fetch specific home screen content and dynamic categories in parallel
    fetchInitialHomeData();
    fetchEngTvCategories();
  }

  Future<void> fetchInitialHomeData() async {
    isLoading.value = true;
    update();

    // Directly fetch by literal names as requested
    await Future.wait([
      fetchHomeCategoryVideos("League Highlights", leagueHighlightsVideos),
      fetchHomeCategoryVideos("Goals of the Week", goalsOfTheWeekVideos),
      fetchHomeCategoryVideos("Ref Cam", refCamVideos),
      fetchHomeCategoryVideos("Featured", featuredVideos),
    ]);

    // Update banner videos strictly from League Highlights
    if (leagueHighlightsVideos.isNotEmpty) {
      bannerVideos = leagueHighlightsVideos;
      _startAutoSlide();
    } else {
      // If still empty, clear banner to avoid showing random videos 
      // or keep it empty as per requirement for specific category.
      bannerVideos = [];
    }
    
    isLoading.value = false;
    update();
  }

  Future<void> fetchEngTvCategories() async {
    try {
      final response = await apiClient.get(ApiEndPoint.engTvCategory);
      if (response.statusCode == 200) {
        final categoryResponse = VideoCategoryResponse.fromJson(response.data);
        allCategories.assignAll(categoryResponse.data);
        
        // Fetch videos for all categories for Eng TV screen using category NAME
        for (var cat in allCategories) {
          fetchVideosForCategory(cat.id, cat.name);
        }
      }
    } catch (e) {
      debugPrint('❌ fetchEngTvCategories error: $e');
    }
  }

  Future<void> fetchHomeCategoryVideos(String categoryName, RxList<VideoModel> targetList) async {
    try {
      final encodedName = Uri.encodeComponent(categoryName);
      final response = await apiClient.get("${ApiEndPoint.video}?category=$encodedName&limit=5");
      if (response.statusCode == 200) {
        final videoResponse = VideoResponse.fromJson(response.data);
        targetList.assignAll(videoResponse.data);
      }
    } catch (e) {
      debugPrint('❌ fetchHomeCategoryVideos error: $e');
    }
  }

  Future<void> fetchVideosForCategory(String categoryId, String categoryName) async {
    if (categoryLoadingMap[categoryId] == true) return;
    if (categoryVideosMap.containsKey(categoryId) && categoryVideosMap[categoryId]!.isNotEmpty) return;
    
    try {
      categoryLoadingMap[categoryId] = true;
      update();
      
      final encodedName = Uri.encodeComponent(categoryName);
      final response = await apiClient.get("${ApiEndPoint.video}?category=$encodedName&limit=10");
      if (response.statusCode == 200) {
        final videoResponse = VideoResponse.fromJson(response.data);
        categoryVideosMap[categoryId] = videoResponse.data;
      }
    } catch (e) {
      debugPrint('❌ fetchVideosForCategory error: $e');
    } finally {
      categoryLoadingMap[categoryId] = false;
      update();
    }
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
