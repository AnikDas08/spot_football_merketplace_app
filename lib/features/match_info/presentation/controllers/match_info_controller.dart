import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../home/data/match_model.dart';

class MatchInfoController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  var match = Rxn<MatchModel>();

  Future<void> fetchMatchDetails(String id) async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get("${ApiEndPoint.match}$id");

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          match.value = MatchModel.fromJson(response.data['data']);
        }
      }
    } catch (e) {
      debugPrint('❌ fetchMatchDetails error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
