import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/services/api/api_client.dart';

import '../../data/model/html_model.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/enum/enum.dart';

class PrivacyPolicyController extends GetxController {
  /// API status
  Status status = Status.completed;

  /// HTML data
  HtmlModel data = HtmlModel.fromJson({});

  /// Instance (for lazyPut/bindings)
  static PrivacyPolicyController get instance =>
      Get.find<PrivacyPolicyController>();

  final ApiClient apiClient = DioApiClient();

  /// Fetch privacy policy
  Future<void> getPrivacyPolicy() async {
    try {
      status = Status.loading;
      update();

      final response = await apiClient.get(ApiEndPoint.privacyPolicies);

      if (response.statusCode == 200) {
        final Map<String, dynamic> rawData = response.data['data'] ?? {};
        data = HtmlModel.fromJson(rawData);
        status = Status.completed;
      } else {
        status = Status.error;
      }
    } catch (e) {
      status = Status.error;
      debugPrint('❌ getPrivacyPolicy error: $e');
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicy();
  }
}
