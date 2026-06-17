import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/app_snackbar.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../home/data/match_model.dart';

class LiveMatchControlController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  var isLoading = false.obs;
  var match = Rxn<MatchModel>();

  @override
  void onInit() {
    super.onInit();
    final String? matchId = Get.arguments;
    if (matchId != null) {
      fetchMatchDetails(matchId);
    }
  }

  Future<void> fetchMatchDetails(String id) async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(
        "${ApiEndPoint.match}/$id",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        match.value = MatchModel.fromJson(response.data['data']);
      }
    } catch (e) {
      debugPrint('❌ fetchMatchDetails error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> toggleMatchStatus() async {
    final matchId = match.value?.id;
    if (matchId == null) return;

    try {
      isLoading.value = true;
      update();

      final response = await apiClient.patch(
        "${ApiEndPoint.toggleMatchStatus}$matchId",
        body: {},
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final newStatus = response.data['data']['status'];
        if (newStatus == 'finished') {
          Get.back(); // Go back to dashboard if finished
          AppSnackbar.success(
            title: 'Success',
            message: response.data['message'] ?? 'Match finished successfully',
          );
        } else {
          AppSnackbar.success(
            title: 'Success',
            message: response.data['message'] ?? 'Status updated to ${newStatus.toUpperCase()}',
          );
          await fetchMatchDetails(matchId); // Refresh details for current screen
        }
      }
    } catch (e) {
      debugPrint('❌ toggleMatchStatus error: $e');
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
