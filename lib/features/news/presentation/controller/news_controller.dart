import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/api_service.dart';
import 'package:untitled/services/storage/storage_services.dart';
import '../../data/models/news_model.dart';

class NewsController extends GetxController {
  static NewsController get instance => Get.find<NewsController>();
  final ApiClient apiClient = DioApiClient();
  final ScrollController scrollController = ScrollController();

  var newsList = <NewsModel>[].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var singleNews = Rxn<NewsModel>();
  var isDetailLoading = false.obs;

  int currentPage = 1;
  bool hasNextPage = true;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && !isMoreLoading.value && hasNextPage) {
        loadMoreNews();
      }
    }
  }

  Future<void> fetchNews({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        newsList.clear();
      }
      update();

      final response = await apiClient.get(
        "${ApiEndPoint.news}?page=$currentPage&limit=10",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data['data'];
        List<dynamic> data = [];
        
        if (responseData is List) {
          data = responseData;
          hasNextPage = false;
        } else if (responseData is Map) {
          data = responseData['news'] ?? responseData['docs'] ?? [];
          final pagination = responseData['pagination'] ?? responseData['meta'];
          if (pagination != null) {
            int totalPage = pagination['totalPage'] ?? pagination['totalPages'] ?? 1;
            hasNextPage = currentPage < totalPage;
          } else {
            hasNextPage = false;
          }
        }

        final newItems = data.map((json) => NewsModel.fromJson(json)).toList();
        
        if (isLoadMore) {
          newsList.addAll(newItems);
        } else {
          newsList.assignAll(newItems);
        }
      }
    } catch (e) {
      debugPrint('❌ fetchNews error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreNews() async {
    currentPage++;
    await fetchNews(isLoadMore: true);
  }

  Future<void> fetchSingleNews(String id) async {
    try {
      isDetailLoading.value = true;
      update();

      final response = await apiClient.get(
        '${ApiEndPoint.news}/$id',
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        singleNews.value = NewsModel.fromJson(response.data['data']);
      }
    } catch (e) {
      debugPrint('❌ fetchSingleNews error: $e');
    } finally {
      isDetailLoading.value = false;
      update();
    }
  }
}
