import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';

class StatsController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  var selectedAge = "12".obs;
  var isLoading = false.obs;
  var summaryData = Rxn<Map<String, dynamic>>();

  final List<String> ageOptions = ["10", "12", "14", "16", "18"];

  @override
  void onInit() {
    super.onInit();
    fetchLeagueSummary();
  }

  void updateAge(String value) {
    selectedAge.value = value;
    fetchLeagueSummary();
  }

  Future<void> fetchLeagueSummary() async {
    try {
      isLoading.value = true;
      update();

      final leagueName = "Under ${selectedAge.value}";
      final response = await apiClient.get(
        "${ApiEndPoint.leagueSummary}?leagueName=$leagueName",
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        summaryData.value = response.data['data'];
      }
    } catch (e) {
      debugPrint('❌ fetchLeagueSummary error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
