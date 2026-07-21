import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../model/season_leaderboard_model.dart';

class SeassonStatsController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var selectedSeason = "2026/27".obs;
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
        query: {'season': selectedSeason.value.split('/').first},
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

  Future<void> chooseSeason(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF083E4B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String nextYearShort = (pickedDate.year + 1).toString().substring(2);
      selectedSeason.value = "${pickedDate.year}/$nextYearShort";

      updateDataForSeason(selectedSeason.value);
    }
  }

  void updateDataForSeason(String season) {
    log("Data loading for: $season");
    fetchSeasonLeaderboard();
  }
}
