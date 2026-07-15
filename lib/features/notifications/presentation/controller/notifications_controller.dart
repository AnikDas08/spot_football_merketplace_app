import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/notification_model.dart';
import '../../repository/notification_repository.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasNoData = false.obs;
  
  int page = 1;
  int totalPage = 0;

  final ScrollController scrollController = ScrollController();

  @override 
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    getNotifications();
  }

  void _onScroll() {
    if (isLoading.value || isLoadingMore.value || totalPage == 0 || page > totalPage) return;

    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      loadMore();
    }
  }

  Future<void> getNotifications() async {
    if (isLoading.value) return;
    
    try {
      isLoading.value = true;
      hasNoData.value = false;
      page = 1;
      
      final result = await notificationRepository(page);
      final List<NotificationModel> list = result['notifications'] ?? [];
      totalPage = result['totalPage'] ?? 1;

      notifications.assignAll(list);
      
      if (notifications.isEmpty) {
        hasNoData.value = true;
      } else {
        page++;
      }
    } catch (e) {
      debugPrint('❌ getNotifications error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoading.value || isLoadingMore.value || page > totalPage) return;

    try {
      isLoadingMore.value = true;
      
      final result = await notificationRepository(page);
      final List<NotificationModel> list = result['notifications'] ?? [];
      totalPage = result['totalPage'] ?? 1;

      if (list.isNotEmpty) {
        notifications.addAll(list);
        page++;
      }
    } catch (e) {
      debugPrint('❌ loadMore error: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    page = 1;
    totalPage = 0;
    await getNotifications();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
