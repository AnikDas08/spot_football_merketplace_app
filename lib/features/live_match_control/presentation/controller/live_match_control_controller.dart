import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../home/data/match_model.dart';

class LiveMatchControlController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  var isLoading = false.obs;
  var match = Rxn<MatchModel>();

  // Report Data
  final homeTeamRating = "85".obs;
  final awayTeamRating = "85".obs;
  final manOfTheMatchId = "".obs;
  final RxList<dynamic> allMatchPlayers = <dynamic>[].obs;

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
        if (match.value != null) {
          fetchBothTeamLineups(id, match.value!.homeTeam.id, match.value!.awayTeam.id);
        }
      }
    } catch (e) {
      debugPrint('❌ fetchMatchDetails error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchBothTeamLineups(String matchId, String homeId, String awayId) async {
    try {
      final responses = await Future.wait([
        apiClient.get("${ApiEndPoint.playerSelectionFilter}?matchId=$matchId&teamId=$homeId"),
        apiClient.get("${ApiEndPoint.playerSelectionFilter}?matchId=$matchId&teamId=$awayId"),
      ]);

      List<dynamic> combinedPlayers = [];
      if (responses[0].statusCode == 200 && responses[0].data['data'] != null) {
        combinedPlayers.addAll(responses[0].data['data']['players'] ?? []);
      }
      if (responses[1].statusCode == 200 && responses[1].data['data'] != null) {
        combinedPlayers.addAll(responses[1].data['data']['players'] ?? []);
      }

      allMatchPlayers.assignAll(combinedPlayers);
    } catch (e) {
      debugPrint('❌ fetchBothTeamLineups error: $e');
    }
  }

  Future<void> submitRefereeReport() async {
    final m = match.value;
    if (m == null) return;

    if (manOfTheMatchId.isEmpty) {
      AppSnackbar.error(message: "Please select Man of the Match");
      return;
    }

    try {
      isLoading.value = true;
      update();

      final body = {
        "match": m.id,
        "referee": LocalStorage.userId,
        "homeTeam": m.homeTeam.id,
        "awayTeam": m.awayTeam.id,
        "homeTeamRating": int.tryParse(homeTeamRating.value) ?? 85,
        "awayTeamRating": int.tryParse(awayTeamRating.value) ?? 85,
        "manOfTheMatch": manOfTheMatchId.value,
        "winningTeam": null, // Removed from UI
        "notes": "", // Removed from UI
      };

      final response = await apiClient.post(
        ApiEndPoint.refereeReport,
        body: body,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(title: "Success", message: "Match report submitted successfully");
        // Optionally toggle match status to finished here if not already done
      }
    } catch (e) {
      debugPrint('❌ submitRefereeReport error: $e');
      AppSnackbar.error(title: "Error", message: "Failed to submit report");
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
          message: response.message,
        );
        } else {
        AppSnackbar.success(
          title: 'Success',
          message: response.message,
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
