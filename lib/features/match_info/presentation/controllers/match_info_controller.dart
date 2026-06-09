import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../home/data/match_model.dart';

class MatchInfoController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;
  var match = Rxn<MatchModel>();
  var selectionData = Rxn<Map<String, dynamic>>();

  Future<void> fetchMatchDetails(String id) async {
    try {
      isLoading.value = true;
      update();

      // Fetch match details
      try {
        final matchResponse = await apiClient.get("${ApiEndPoint.match}/$id");
        if (matchResponse.statusCode == 200 && matchResponse.data['success'] == true) {
          match.value = MatchModel.fromJson(matchResponse.data['data']);
        }
      } catch (e) {
        debugPrint('❌ match fetch error: $e');
      }

      // Fetch selection data
      try {
        final selectionResponse = await apiClient.get("${ApiEndPoint.playerSelection}$id");
        if (selectionResponse.statusCode == 200 && selectionResponse.data['success'] == true) {
          selectionData.value = selectionResponse.data['data'];
        }
      } catch (e) {
        debugPrint('❌ playerSelection fetch error: $e');
      }
    } catch (e) {
      debugPrint('❌ fetchMatchDetails error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
