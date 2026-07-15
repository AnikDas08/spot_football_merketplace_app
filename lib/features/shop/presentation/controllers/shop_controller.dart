import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../data/reward_response.dart';

class ShopController extends GetxController {
  static ShopController get to => Get.find();
  final ApiClient apiClient = DioApiClient();
  final ScrollController scrollController = ScrollController();

  int selectedTab = 0;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  List<RewardProduct> productList = [];
  
  int currentPage = 1;
  bool hasNextPage = true;

  @override
  void onInit() {
    fetchProducts();
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && !isMoreLoading.value && hasNextPage) {
        loadMoreProducts();
      }
    }
  }

  void changeTab(int index) {
    selectedTab = index;
    currentPage = 1;
    productList.clear();
    update();
    fetchProducts();
  }

  Future<void> fetchProducts({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        productList.clear();
      }
      update();

      String productTypeParam = (selectedTab == 0) ? 'nonCoffee' : 'Coffee';

      final response = await apiClient.get(
        "${ApiEndPoint.rewardProducts}?productType=$productTypeParam&page=$currentPage&limit=10",
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data['data'];
        List<dynamic> data = [];
        
        if (responseData is List) {
          data = responseData;
          hasNextPage = false;
        } else if (responseData is Map) {
          data = responseData['products'] ?? responseData['docs'] ?? [];
          final pagination = responseData['pagination'];
          if (pagination != null) {
            int totalPage = pagination['totalPage'] ?? 1;
            hasNextPage = currentPage < totalPage;
          } else {
            hasNextPage = false;
          }
        }

        final rewardResponse = data.map((e) => RewardProduct.fromJson(e)).toList();
        
        if (isLoadMore) {
          productList.addAll(rewardResponse);
        } else {
          productList = rewardResponse;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchProducts error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreProducts() async {
    currentPage++;
    await fetchProducts(isLoadMore: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
