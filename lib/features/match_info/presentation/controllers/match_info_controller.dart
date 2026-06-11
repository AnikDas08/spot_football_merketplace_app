import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../home/data/match_model.dart';
import '../../../team_sheet/data/team_sheet_models.dart';

class MatchInfoController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  var match = Rxn<MatchModel>();
  var selectedTeamIndex = 0.obs;
  var homeSelection = Rxn<SelectionData>();
  var awaySelection = Rxn<SelectionData>();

  Future<void> fetchMatchDetails(String id) async {
    try {
      isLoading.value = true;
      update();

      // 1. Fetch match details
      final matchResponse = await apiClient.get("${ApiEndPoint.match}/$id");
      if (matchResponse.statusCode == 200 && matchResponse.data['success'] == true) {
        final matchData = MatchModel.fromJson(matchResponse.data['data']);
        match.value = matchData;

        // 2. Fetch selection data for both teams using Filter API
        await _fetchSelections(id, matchData.homeTeam.id, matchData.awayTeam.id);
      }
    } catch (e) {
      debugPrint('❌ fetchMatchDetails error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> _fetchSelections(String matchId, String homeId, String awayId) async {
    try {
      final responses = await Future.wait([
        apiClient.get("${ApiEndPoint.playerSelectionFilter}?matchId=$matchId&teamId=$homeId"),
        apiClient.get("${ApiEndPoint.playerSelectionFilter}?matchId=$matchId&teamId=$awayId"),
      ]);

      if (responses[0].statusCode == 200 && responses[0].data['data'] != null) {
        homeSelection.value = SelectionData.fromJson(responses[0].data['data']);
      }

      if (responses[1].statusCode == 200 && responses[1].data['data'] != null) {
        awaySelection.value = SelectionData.fromJson(responses[1].data['data']);
      }
    } catch (e) {
      debugPrint('❌ _fetchSelections error: $e');
    }
  }

  void changeSelectedTeam(int index) {
    selectedTeamIndex.value = index;
    update();
  }
}
