import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../profile/presentation/controller/profile_controller.dart';

class PlayerProfileController extends GetxController {
  static PlayerProfileController get instance => Get.find<PlayerProfileController>();

  final ApiClient apiClient = DioApiClient();
  
  bool isLoading = false;
  bool isOfferingTrial = false;
  Map<String, dynamic>? playerData;

  @override
  void onInit() {
    super.onInit();
    final String? playerId = Get.arguments;
    if (playerId != null) {
      fetchPlayerDetails(playerId);
    }
  }

  Future<void> fetchPlayerDetails(String playerId) async {
    try {
      isLoading = true;
      update();

      final response = await apiClient.get(
        "${ApiEndPoint.playerDetails}$playerId",
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        playerData = response.data['data'];
      }
    } catch (e) {
      debugPrint("Error fetching player details: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> offerTrial() async {
    if (playerData == null) return;

    try {
      isOfferingTrial = true;
      update();

      // Get teamId from LocalStorage
      String teamId = LocalStorage.teamId;
      
      // Fallback: Try to get it from ProfileController if LocalStorage is empty
      if (teamId.isEmpty) {
        try {
          final profileCtrl = Get.find<ProfileController>();
          teamId = profileCtrl.selectedTeam ?? "";
        } catch (_) {}
      }

      if (teamId.isEmpty) {
        AppSnackbar.error(
          title: 'Error', 
          message: 'Manager team ID not found. Please ensure your profile is complete with a team selected.',
        );
        return;
      }

      final String playerUserId = playerData!['userId'] ?? "";
      final String playerProfileId = playerData!['_id'] ?? "";
      
      // Prefer userId, then fallback to Get.arguments (which is the ID used for fetching), then _id
      final String effectivePlayerId = playerUserId.isNotEmpty 
          ? playerUserId 
          : (Get.arguments is String ? Get.arguments : playerProfileId);

      final Map<String, dynamic> body = {
        "player": effectivePlayerId,
        "toTeam": teamId
      };

      // Add fromTeam if the player has a selected team
      final dynamic fromTeamData = playerData!['selectTeam'];
      final String? selectTeamId = playerData!['selectTeamId'];

      if (selectTeamId != null && selectTeamId.isNotEmpty) {
        body['fromTeam'] = selectTeamId;
      } else if (fromTeamData != null) {
        if (fromTeamData is Map) {
          body['fromTeam'] = fromTeamData['id'] ?? fromTeamData['_id'];
        } else if (fromTeamData is String && fromTeamData.isNotEmpty && fromTeamData.length == 24) {
          body['fromTeam'] = fromTeamData;
        }
      }

      debugPrint("🚀 Sending Trial Offer Payload: $body");

      final response = await apiClient.post(
        ApiEndPoint.transfers,
        body: body,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      debugPrint("📩 Trial Offer Response: ${response.statusCode}");
      debugPrint("📩 Trial Offer Body: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        AppSnackbar.success(
          title: 'Success',
          message: response.data['message'] ?? 'Trial offer sent successfully',
        );
      } else {
        throw Exception(response.data['message'] ?? 'Failed to send offer');
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isOfferingTrial = false;
      update();
    }
  }
}
