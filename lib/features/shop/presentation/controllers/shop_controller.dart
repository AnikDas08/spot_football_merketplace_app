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

  int selectedTab = 0;
  var isLoading = false.obs;

  List<RewardProduct> productList = [];

  void changeTab(int index) {
    selectedTab = index;
    update();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      update();

      String brandParam = (selectedTab == 0) ? 'Nike' : 'Coffee';

      final response = await apiClient.get(
        "${ApiEndPoint.rewardProducts}?brand=$brandParam",
      );

      if (response.statusCode == 200) {
        log("api...........................${response.data}");

        final rewardResponse = RewardResponse.fromJson(response.data);
        productList = rewardResponse.data;
      }
    } catch (e) {
      debugPrint('❌ fetchProducts error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
}