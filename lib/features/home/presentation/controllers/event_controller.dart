import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/event_response.dart';

class EventController extends GetxController {
  static EventController get to => Get.find();
  final ApiClient apiClient = DioApiClient();
  final ScrollController scrollController = ScrollController();

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  List<EventModel> eventList = [];

  int currentPage = 1;
  bool hasNextPage = true;

  @override
  void onInit() {
    fetchEvents();
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && !isMoreLoading.value && hasNextPage) {
        loadMoreEvents();
      }
    }
  }

  Future<void> fetchEvents({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        eventList.clear();
      }
      update();

      final response = await apiClient.get("${ApiEndPoint.event}?page=$currentPage&limit=10");

      if (response.statusCode == 200) {
        final dynamic responseData = response.data['data'];
        List<dynamic> data = [];
        
        if (responseData is List) {
          data = responseData;
          hasNextPage = false;
        } else if (responseData is Map) {
          data = responseData['events'] ?? responseData['docs'] ?? [];
          final pagination = responseData['pagination'];
          if (pagination != null) {
            int totalPage = pagination['totalPage'] ?? 1;
            hasNextPage = currentPage < totalPage;
          } else {
            hasNextPage = false;
          }
        }

        final newItems = data.map((e) => EventModel.fromJson(e)).toList();
        
        if (isLoadMore) {
          eventList.addAll(newItems);
        } else {
          eventList = newItems;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchEvents error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreEvents() async {
    currentPage++;
    await fetchEvents(isLoadMore: true);
  }
}
