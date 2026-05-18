import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/player_response.dart';

class TransferController extends GetxController {
  static TransferController get to => Get.find();
  final ApiClient apiClient = DioApiClient();

  var isLoading = false.obs;
  List<PlayerModel> playerList = [];

  @override
  void onInit() {
    fetchPlayers();
    super.onInit();
  }

  Future<void> fetchPlayers() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.transfersAvailable);

      if (response.statusCode == 200) {
        final playerResponse = PlayerResponse.fromJson(response.data);
        playerList = playerResponse.data;
      }
    } catch (e) {
      debugPrint('❌ fetchPlayers error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
