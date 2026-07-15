import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/features/stats_flow/presentation/model/player_model.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';

class PlayerComparisonController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  var player1 = Rxn<PlayerModel>();
  var player2 = Rxn<PlayerModel>();

  var isLoadingPlayer1 = false.obs;
  var isLoadingPlayer2 = false.obs;

  void selectPlayer(PlayerModel player, int slot) {
    if (slot == 1) {
      player1.value = player;
      fetchPlayerDetails(player.id, 1);
    } else {
      player2.value = player;
      fetchPlayerDetails(player.id, 2);
    }
  }

  Future<void> fetchPlayerDetails(String playerId, int slot) async {
    try {
      if (slot == 1) isLoadingPlayer1.value = true;
      else isLoadingPlayer2.value = true;
      update();

      final response = await apiClient.get("${ApiEndPoint.playerDashboard}$playerId");

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final json = data['player'];
        final stats = data['stats'] ?? {};
        
        final updatedPlayer = PlayerModel(
          id: json['_id'] ?? "",
          name: "${json['firstName'] ?? ""} ${json['lastName'] ?? ""}".trim(),
          position: json['position'] ?? "N/A",
          image: json['profile'] ?? "",
          appearances: stats['appearances'],
          goals: stats['goals'],
          assists: stats['assists'],
          yellowCards: stats['yellowCards'],
          redCards: stats['redCards'],
          cleanSheets: stats['cleanSheets'],
          saves: stats['saves'],
          strongFoot: json['strongFoot']?.toString(),
          engCoins: json['engCoine'],
          dob: json['dateOfBirth'],
          debutDate: json['createdAt'],
          teamName: json['selectTeam'] != null ? json['selectTeam']['teamName'] : null,
        );

        if (slot == 1) {
          player1.value = updatedPlayer;
        } else {
          player2.value = updatedPlayer;
        }
      }
    } catch (e) {
      debugPrint("Error fetching player comparison data: $e");
    } finally {
      if (slot == 1) isLoadingPlayer1.value = false;
      else isLoadingPlayer2.value = false;
      update();
    }
  }

  bool get canShowStats => player1.value != null || player2.value != null;
}
