import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../home/data/match_model.dart';

class RefereeDashboardController extends GetxController {
  final ApiClient apiClient = DioApiClient();

  final RxList<MatchModel> allMatches = <MatchModel>[].obs;
  final RxList<MatchModel> todayMatches = <MatchModel>[].obs;
  final RxList<MatchModel> upcomingMatches = <MatchModel>[].obs;
  final RxList<MatchModel> historyMatches = <MatchModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString togglingId = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyMatches();
  }

  Future<void> fetchMyMatches() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(
        ApiEndPoint.myMatches,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        allMatches.assignAll(data.map((e) => MatchModel.fromJson(e)).toList());
        _filterMatches();
      }
    } catch (e) {
      debugPrint('❌ fetchMyMatches error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> toggleMatchStatus(String matchId) async {
    try {
      togglingId.value = matchId;
      update();

      final response = await apiClient.patch(
        "${ApiEndPoint.toggleMatchStatus}$matchId",
        body: {},
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        await fetchMyMatches(); // Refresh the list
        AppSnackbar.success(
          title: 'Success',
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint('❌ toggleMatchStatus error: $e');
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      togglingId.value = "";
      update();
    }
  }

  void _filterMatches() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    todayMatches.assignAll(allMatches.where((m) {
      if (m.matchDate == null) return false;
      final mDate = DateTime(m.matchDate!.year, m.matchDate!.month, m.matchDate!.day);
      return mDate.isAtSameMomentAs(today) && m.status.toLowerCase() != 'finished';
    }).toList());

    upcomingMatches.assignAll(allMatches.where((m) {
      if (m.matchDate == null) return false;
      final mDate = DateTime(m.matchDate!.year, m.matchDate!.month, m.matchDate!.day);
      return mDate.isAfter(today) && m.status.toLowerCase() != 'finished';
    }).toList());

    historyMatches.assignAll(allMatches.where((m) {
      return m.status.toLowerCase() == 'finished';
    }).toList());
  }
}
