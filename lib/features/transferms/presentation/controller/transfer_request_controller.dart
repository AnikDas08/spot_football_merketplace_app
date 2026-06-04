import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/api_service.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/app_snackbar.dart';
import '../../data/transfer_request_model.dart';

class TransferRequestController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  final _isIncoming = true.obs;
  bool get isIncoming => _isIncoming.value;

  final RxBool isLoading = false.obs;
  final RxString withdrawingId = "".obs;
  final RxList<TransferRequestModel> outgoingRequests = <TransferRequestModel>[].obs;
  final RxList<TransferRequestModel> incomingRequests = <TransferRequestModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void setIncoming(bool value) {
    _isIncoming.value = value;
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      update();

      if (isIncoming) {
        // Handle incoming requests if endpoint exists, for now just outgoing
        // fetchIncomingRequests();
      } else {
        await fetchOutgoingRequests();
      }
    } catch (e) {
      debugPrint("Error fetching requests: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchOutgoingRequests() async {
    try {
      final response = await apiClient.get(
        ApiEndPoint.myRequests,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final transferResponse = TransferRequestResponse.fromJson(response.data);
        outgoingRequests.assignAll(transferResponse.data);
      }
    } catch (e) {
      debugPrint("Error fetching outgoing requests: $e");
    }
  }

  Future<void> withdrawOffer(String transferId, String playerName) async {
    try {
      withdrawingId.value = transferId;
      update();

      final response = await apiClient.patch(
        "${ApiEndPoint.transfers}/$transferId/withdraw",
        body: {},
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        AppSnackbar.success(
          title: 'Success',
          message: 'Offer for $playerName has been withdrawn.',
        );
        fetchRequests(); // Refresh the list
      } else {
        throw Exception(response.data['message'] ?? 'Failed to withdraw offer');
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      withdrawingId.value = "";
      update();
    }
  }

  // Placeholder for acceptance/rejection until endpoints are provided
  void acceptTransfer(String transferId, String playerName) {
    AppSnackbar.success(
      title: 'Success',
      message: 'Transfer request for $playerName accepted.',
    );
  }

  void rejectTransfer(String transferId, String playerName) {
    AppSnackbar.success(
      title: 'Rejected',
      message: 'Transfer request for $playerName rejected.',
    );
  }
}
