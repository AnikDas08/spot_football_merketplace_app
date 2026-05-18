import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/event_response.dart';

class EventController extends GetxController {
  static EventController get to => Get.find();
  final ApiClient apiClient = DioApiClient();

  var isLoading = false.obs;
  List<EventModel> eventList = [];

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.event);

      if (response.statusCode == 200) {
        final eventResponse = EventResponse.fromJson(response.data);
        eventList = eventResponse.data;
      }
    } catch (e) {
      debugPrint('❌ fetchEvents error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
