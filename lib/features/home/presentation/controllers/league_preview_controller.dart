import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/point_table_model.dart';

class LeaguePreviewController extends GetxController {
  final ApiClient apiClient = DioApiClient();

  var isLoading = false.obs;
  List<PointTableModel> pointTable = [];
  String pointTableMessage = '';

  @override
  void onInit() {
    fetchPointTable();
    super.onInit();
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
