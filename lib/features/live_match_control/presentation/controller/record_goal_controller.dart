import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/api_service.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/app_snackbar.dart';

class RecordGoalController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  final selectedTeam = ''.obs;
  final selectedTeamId = ''.obs;
  final selectedMatchId = ''.obs;
  
  final selectedPlayerIndex = 0.obs;
  final selectedGoalType = 'goal'.obs; // Default to enum value
  final selectedAssistPlayerId = RxnString();
  
  final RxList<dynamic> teamPlayers = <dynamic>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final dynamic args = Get.arguments;
    if (args != null) {
      selectedMatchId.value = args['matchId'] ?? '';
      selectedTeamId.value = args['teamId'] ?? '';
      selectedTeam.value = args['teamName'] ?? '';
      
      if (selectedTeamId.isNotEmpty && selectedMatchId.isNotEmpty) {
        fetchMatchLineup();
      }
    }
  }

  Future<void> fetchMatchLineup() async {
    try {
      isLoading.value = true;
      update();
      
      final response = await apiClient.get(
        "${ApiEndPoint.playerSelectionFilter}?matchId=${selectedMatchId.value}&teamId=${selectedTeamId.value}",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> players = response.data['data']['players'] ?? [];
        
        // Transform the selection players into a consistent format for the UI
        final List<Map<String, dynamic>> formattedPlayers = players.map((p) {
          // Handle both nested and flat player structures
          final dynamic playerDetails = p['player'] ?? p;
          return {
            '_id': playerDetails['_id'] ?? p['_id'],
            'userId': playerDetails['userId'] ?? playerDetails['_id'] ?? p['_id'],
            'firstName': playerDetails['firstName'],
            'lastName': playerDetails['lastName'],
            'userName': playerDetails['userName'],
            'profile': playerDetails['profile'] ?? p['profile'],
            'position': p['position'] ?? playerDetails['position'],
          };
        }).toList();

        teamPlayers.assignAll(formattedPlayers);
      }
    } catch (e) {
      debugPrint('❌ fetchMatchLineup error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void updatePlayerIndex(int index) {
    selectedPlayerIndex.value = index;
  }
  
  void updateGoalType(String type) {
    selectedGoalType.value = type;
  }
  
  void updateAssistPlayer(String? playerId) {
    selectedAssistPlayerId.value = playerId;
  }

  Future<void> submitEvent({String? eventId}) async {
    if (teamPlayers.isEmpty || selectedPlayerIndex.value >= teamPlayers.length) return;

    try {
      isLoading.value = true;
      update();

      final player = teamPlayers[selectedPlayerIndex.value];
      final body = {
        "match": selectedMatchId.value,
        "team": selectedTeamId.value,
        "player": player['userId'] ?? player['_id'],
        "eventType": selectedGoalType.value,
        "minute": 0, // Placeholder, usually would be from a timer
      };

      final response = eventId != null 
          ? await apiClient.patch(
              "${ApiEndPoint.matchResult}$eventId",
              body: body,
              headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
            )
          : await apiClient.post(
              ApiEndPoint.matchResult, // Assuming POST for new events
              body: body,
              headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
            );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(
          title: 'Success',
          message: response.data['message'] ?? 'Match event recorded',
        );
        Get.back();
      }
    } catch (e) {
      debugPrint('❌ submitEvent error: $e');
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
