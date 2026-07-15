import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/notification_model.dart';
import '../../repository/notification_repository.dart';

import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../config/api/api_end_point.dart';

class NotificationsController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  var unreadCount = 0.obs;
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
    getUnreadCount();
  }

  void _onScroll() {
    if (isLoading.value || isLoadingMore.value || totalPage == 0 || page > totalPage) return;

    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      loadMore();
    }
  }

  Future<void> getUnreadCount() async {
    try {
      final response = await apiClient.get(
        ApiEndPoint.unreadNotificationCount,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );
      if (response.statusCode == 200) {
        unreadCount.value = response.data['data']['unreadCount'] ?? 0;
      }
    } catch (e) {
      debugPrint('❌ getUnreadCount error: $e');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final response = await apiClient.patch(
        ApiEndPoint.readAllNotifications,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );
      if (response.statusCode == 200) {
        unreadCount.value = 0;
        for (var n in notifications) {
          // Note: NotificationModel is immutable, but we can update list if needed
          // For simplicity, we can refresh or just update the UI state
        }
        refreshNotifications();
      }
    } catch (e) {
      debugPrint('❌ markAllAsRead error: $e');
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      final response = await apiClient.patch(
        "${ApiEndPoint.markAsRead}$id/read",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );
      if (response.statusCode == 200) {
        getUnreadCount();
        // Locally update the item if found
        int index = notifications.indexWhere((n) => n.id == id);
        if (index != -1) {
          final n = notifications[index];
          notifications[index] = NotificationModel(
            id: n.id,
            type: n.type,
            title: n.title,
            message: n.message,
            receiver: n.receiver,
            isRead: true,
            createdAt: n.createdAt,
            updatedAt: DateTime.now(),
          );
        }
      }
    } catch (e) {
      debugPrint('❌ markAsRead error: $e');
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
