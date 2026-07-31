import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../model/season_leaderboard_model.dart';

class SeassonStatsController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var selectedYear = DateTime.now().year.toString().obs;
  var isLoading = false.obs;
  var leaderboardData = Rxn<LeaderboardData>();

  @override
  void onInit() {
    super.onInit();
    fetchSeasonLeaderboard();
  }

  Future<void> fetchSeasonLeaderboard() async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(
        ApiEndPoint.seasonLeaderboard,
        query: {'season': selectedYear.value},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        SeasonLeaderboardModel model = SeasonLeaderboardModel.fromJson(response.data);
        leaderboardData.value = model.data;
      }
    } catch (e) {
      log('❌ fetchSeasonLeaderboard error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateYear(String year) {
    selectedYear.value = year;
    fetchSeasonLeaderboard();
  }
}
