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

  var newsList = <NewsModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(
        ApiEndPoint.news,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        newsList.value = data.map((json) => NewsModel.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('❌ fetchNews error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
