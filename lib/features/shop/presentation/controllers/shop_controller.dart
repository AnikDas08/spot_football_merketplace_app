import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../data/reward_response.dart';

class ShopController extends GetxController {
  static ShopController get to => Get.find();
  final ApiClient apiClient = DioApiClient();
  final ScrollController scrollController = ScrollController();

  var selectedTab = 0.obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var redeemingProductId = "".obs;

  List<RewardProduct> productList = [];
  List<dynamic> myOrdersList = [];
  
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
        if (selectedTab.value == 0 || selectedTab.value == 1) {
          loadMoreProducts();
        } else {
          loadMoreOrders();
        }
      }
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
    currentPage = 1;
    productList.clear();
    myOrdersList.clear();
    update();
    if (index == 0 || index == 1) {
      fetchProducts();
    } else {
      fetchMyOrders();
    }
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

      String productTypeParam = (selectedTab.value == 0) ? 'nonCoffee' : 'Coffee';

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

  Future<void> fetchMyOrders({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        myOrdersList.clear();
      }
      update();

      final response = await apiClient.get(
        "${ApiEndPoint.myOrders}?page=$currentPage&limit=10",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data['data'];
        List<dynamic> data = [];
        
        if (responseData is List) {
          data = responseData;
          hasNextPage = false;
        } else if (responseData is Map) {
          data = responseData['orders'] ?? responseData['docs'] ?? [];
          final pagination = responseData['pagination'];
          if (pagination != null) {
            int totalPage = pagination['totalPage'] ?? 1;
            hasNextPage = currentPage < totalPage;
          } else {
            hasNextPage = false;
          }
        }
        
        if (isLoadMore) {
          myOrdersList.addAll(data);
        } else {
          myOrdersList = data;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchMyOrders error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> redeemProduct(String productId) async {
    try {
      redeemingProductId.value = productId;

      final response = await apiClient.post(
        ApiEndPoint.rewardOrder,
        body: {"rewardProduct": productId},
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(title: 'Success', message: 'Product redeemed successfully!');
        // Refresh profile to update coin balance
        Get.find<ProfileController>().getProfileData();
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      redeemingProductId.value = "";
    }
  }

  Future<void> loadMoreProducts() async {
    currentPage++;
    await fetchProducts(isLoadMore: true);
  }

  Future<void> loadMoreOrders() async {
    currentPage++;
    await fetchMyOrders(isLoadMore: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
