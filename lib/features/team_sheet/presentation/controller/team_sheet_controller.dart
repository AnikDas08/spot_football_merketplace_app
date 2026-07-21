import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../home/data/match_model.dart';
import '../../data/team_sheet_models.dart';

class TeamSheetController extends GetxController {
  final ApiClient apiClient = DioApiClient();

  // Selection state
  final RxString selectedTeamId = "".obs;
  final RxString selectedMatchId = "".obs;
  final RxString selectedFormation = "9".obs; // Default to 9 aside
  final RxString existingSelectionId = "".obs;

  // Data lists
  final RxList<MatchModel> upcomingMatches = <MatchModel>[].obs;
  final RxList<dynamic> teamSquad = <dynamic>[].obs;
  final List<String> formations = ['5', '7', '9'];

  // UI state
  final RxBool isLoading = false.obs;
  final RxBool isSquadLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  // Lineup maps
  // Key: Node index on the field
  final RxMap<int, Map<String, dynamic>?> fieldPlayers = <int, Map<String, dynamic>?>{}.obs;
  // Key: Bench index
  final RxMap<int, Map<String, dynamic>?> substitutes = <int, Map<String, dynamic>?>{
    0: null, 1: null, 2: null, 3: null,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingMatches();
  }

  Future<void> fetchUpcomingMatches() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(
        ApiEndPoint.managerUpcomingMatches,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        upcomingMatches.assignAll(data.map((e) => MatchModel.fromJson(e)).toList());
        
        if (upcomingMatches.isNotEmpty) {
          // Unique teams from matches
          final List<TeamModel> teams = [];
          final Set<String> seenIds = {};
          
          for (var match in upcomingMatches) {
            // We need to know which team belongs to the manager. 
            // For now, let's just collect all teams involved in these matches.
            if (!seenIds.contains(match.homeTeam.id)) {
              teams.add(match.homeTeam);
              seenIds.add(match.homeTeam.id);
            }
            if (!seenIds.contains(match.awayTeam.id)) {
              teams.add(match.awayTeam);
              seenIds.add(match.awayTeam.id);
            }
          }
          
          // Filter: only keep teams that appear as homeTeam in the manager's matches
          // (Backend usually returns matches where manager's team is homeTeam for manager context)
          // For now, let's just use the first match's home team as the default.
          selectedTeamId.value = upcomingMatches.first.homeTeam.id;
          updateVenue(upcomingMatches.first.id);
        }
      }
    } catch (e) {
      debugPrint('❌ fetchUpcomingMatches error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void updateTeam(String teamId) {
    selectedTeamId.value = teamId;
    // Find first match for this team and select it
    final firstMatch = upcomingMatches.firstWhere(
      (m) => m.homeTeam.id == teamId || m.awayTeam.id == teamId,
      orElse: () => upcomingMatches.first
    );
    updateVenue(firstMatch.id);
  }

  void updateVenue(String matchId) {
    selectedMatchId.value = matchId;
    
    // Reset lineup
    fieldPlayers.clear();
    substitutes.assignAll({0: null, 1: null, 2: null, 3: null});
    
    fetchTeamSquad(selectedTeamId.value);
    fetchExistingSelection();
    update();
  }

  Future<void> fetchTeamSquad(String teamId) async {
    try {
      isSquadLoading.value = true;
      update();
      final response = await apiClient.get("${ApiEndPoint.teamDashboard}$teamId");
      if (response.statusCode == 200) {
        teamSquad.assignAll(response.data['data']['players'] ?? []);
      }
    } catch (e) {
      debugPrint('❌ fetchTeamSquad error: $e');
    } finally {
      isSquadLoading.value = false;
      update();
    }
  }

  Future<void> fetchExistingSelection() async {
    try {
      final response = await apiClient.get(
        "${ApiEndPoint.playerSelectionFilter}?matchId=${selectedMatchId.value}&teamId=${selectedTeamId.value}",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final selection = SelectionData.fromJson(response.data['data']);
        existingSelectionId.value = selection.id;
        selectedFormation.value = selection.teamFormation;
        
        // Map players back to UI nodes
        // This is tricky because we need to know WHICH node they were in.
        // For now, we will fill nodes sequentially based on position.
        _prefillLineup(selection.players);
      } else {
        existingSelectionId.value = "";
      }
    } catch (e) {
      debugPrint('❌ fetchExistingSelection error: $e');
    }
  }

  void _prefillLineup(List<SelectedPlayer> players) {
    fieldPlayers.clear();
    substitutes.assignAll({0: null, 1: null, 2: null, 3: null});
    
    for (var p in players) {
      final fullName = "${p.player.firstName ?? ""} ${p.player.lastName ?? ""}".trim();
      final data = {
        'id': p.player.id,
        'userId': p.player.id,
        'name': fullName.isNotEmpty ? fullName : (p.player.userName ?? "Player"),
        'initial': (p.player.firstName?[0] ?? p.player.userName?[0] ?? "P").toUpperCase(),
        'profile': p.player.profile,
        'pos': p.position,
      };

      if (p.substitute) {
        substitutes[p.positionIndex] = data;
      } else {
        fieldPlayers[p.positionIndex] = data;
      }
    }
    update();
  }

  void updateFormation(String formation) {
    selectedFormation.value = formation;
    fieldPlayers.clear();
    update();
  }

  void assignPlayer(int index, dynamic player, {bool isSub = false}) {
    final String playerId = player['userId'] ?? player['_id'];

    // Validation: Check if player is already selected in field or bench
    bool alreadySelected = false;
    fieldPlayers.forEach((idx, p) {
      if (p != null && p['id'] == playerId) alreadySelected = true;
    });
    substitutes.forEach((idx, p) {
      if (p != null && p['id'] == playerId) alreadySelected = true;
    });

    if (alreadySelected) {
      AppSnackbar.error(message: "Player is already selected in the lineup.");
      return;
    }

    final Map<String, dynamic> playerData = {
      'id': playerId, // Using userId as requested
      'userId': playerId,
      'name': "${player['firstName'] ?? ""} ${player['lastName'] ?? ""}".trim().isNotEmpty 
          ? "${player['firstName'] ?? ""} ${player['lastName'] ?? ""}".trim() 
          : (player['userName'] ?? "Player"),
      'initial': (player['firstName']?[0] ?? player['userName']?[0] ?? "P").toUpperCase(),
      'profile': player['profile'],
      'pos': player['position'] ?? 'Other',
    };

    if (isSub) {
      substitutes[index] = playerData;
    } else {
      fieldPlayers[index] = playerData;
    }
    update();
  }

  void removePlayer(int index, {bool isSub = false}) {
    if (isSub) {
      substitutes[index] = null;
    } else {
      fieldPlayers[index] = null;
    }
    update();
  }

  List<dynamic> get filteredSquad {
    final Set<String> selectedIds = {};
    fieldPlayers.forEach((_, p) { if (p != null) selectedIds.add(p['id']); });
    substitutes.forEach((_, p) { if (p != null) selectedIds.add(p['id']); });

    return teamSquad.where((p) {
      final String id = p['userId'] ?? p['_id'] ?? "";
      return !selectedIds.contains(id);
    }).toList();
  }

  List<List<String>> getFormationLayout() {
    final count = int.tryParse(selectedFormation.value) ?? 9;
    if (count == 5) {
      return [
        ['Forward'],
        ['Midfielder', 'Midfielder'],
        ['Defender'],
        ['Goalkeeper'],
      ];
    } else if (count == 7) {
      return [
        ['Forward'],
        ['Midfielder', 'Midfielder', 'Midfielder'],
        ['Defender', 'Defender'],
        ['Goalkeeper'],
      ];
    } else {
      // 9 Aside
      return [
        ['Forward', 'Forward'],
        ['Midfielder', 'Midfielder', 'Midfielder'],
        ['Defender', 'Defender', 'Defender'],
        ['Goalkeeper'],
      ];
    }
  }

  Future<void> confirmLineup() async {
    if (selectedMatchId.isEmpty || selectedTeamId.isEmpty) {
      AppSnackbar.error(message: "Please select a match first.");
      return;
    }

    try {
      isSubmitting.value = true;
      update();

      final List<Map<String, dynamic>> playersPayload = [];

      // Construct players list from nodes
      final layout = getFormationLayout();
      int globalIndex = 0;
      for (var row in layout) {
        for (var pos in row) {
          final nodeIndex = globalIndex++;
          final p = fieldPlayers[nodeIndex];
          if (p != null && p['id'] != null && p['id'].toString().isNotEmpty) {
            playersPayload.add({
              "player": p['id'],
              "position": pos, // Using the node's assigned position
              "substitute": false,
              "positionIndex": nodeIndex
            });
          }
        }
      }

      // Add substitutes
      substitutes.forEach((index, p) {
        if (p != null && p['id'] != null && p['id'].toString().isNotEmpty) {
          playersPayload.add({
            "player": p['id'],
            "position": p['pos'], // Use their natural position for bench
            "substitute": true,
            "positionIndex": index
          });
        }
      });

      final Map<String, dynamic> body = {
        "match": selectedMatchId.value,
        "team": selectedTeamId.value,
        "teamFormation": selectedFormation.value,
        "players": playersPayload,
      };

      final response = existingSelectionId.isNotEmpty
          ? await apiClient.patch(
              "${ApiEndPoint.playerSelection}${existingSelectionId.value}",
              body: body,
              headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
            )
          : await apiClient.post(
              ApiEndPoint.playerSelection,
              body: body,
              headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
            );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(
          title: 'Success',
          message: existingSelectionId.isNotEmpty ? 'Selection updated' : 'Players selected successfully',
        );
        fetchExistingSelection(); // Refresh ID and data
      }
    } catch (e) {
      debugPrint('❌ confirmLineup error: $e');
      AppSnackbar.error(message: e.toString());
    } finally {
      isSubmitting.value = false;
      update();
    }
  }
}
