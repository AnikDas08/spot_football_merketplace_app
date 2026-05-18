import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';

class ShopController extends GetxController {

  static ShopController get to => Get.find();
  final ApiClient apiClient = DioApiClient();

  int selectedTab = 0;

  void changeTab(int index){
    selectedTab = index;
    update();
  }

  var isLoading = false.obs;

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(
        ApiEndPoint.rewardProducts,
      );

      if (response.statusCode == 200) {

        log("api...........................${response.data}");


        final List<dynamic> data = response.data['data'];
        // newsList.value = data.map((json) => NewsModel.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('❌ fetchNews error: $e');
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

  ///reward-products



}