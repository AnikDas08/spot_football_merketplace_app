import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/match_model.dart';
import '../../data/point_table_model.dart';

class ClubProfileController extends GetxController {
  static ClubProfileController get to => Get.find();
  final ApiClient apiClient = DioApiClient();

  var isLoading = false.obs;
  List<MatchModel> recentMatches = [];
  List<MatchModel> upcomingMatches = [];
  List<PointTableModel> pointTable = [];
  String pointTableMessage = '';

  @override
  void onInit() {
    fetchMatches();
    fetchPointTable();
    super.onInit();
  }

  Future<void> fetchMatches() async {
    try {

      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.match);

      if (response.statusCode == 200) {
        final matchResponse = MatchResponse.fromJson(response.data);
        
        recentMatches = matchResponse.data
            .where((match) => match.status.toLowerCase() == 'finished')
            .toList();
            
        upcomingMatches = matchResponse.data
            .where((match) => match.status.toLowerCase() == 'upcoming')
            .toList();
      }


    } catch (e) {
      debugPrint('❌ fetchMatches error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchPointTable() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.pointTable);

      if (response.statusCode == 200) {
        final pointTableResponse = PointTableResponse.fromJson(response.data);
        pointTable = pointTableResponse.data;
        pointTableMessage = pointTableResponse.message;
      }
    } catch (e) {
      debugPrint('❌ fetchPointTable error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
