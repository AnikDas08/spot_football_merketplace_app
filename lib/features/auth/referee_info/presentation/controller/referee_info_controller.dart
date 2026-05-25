import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/api_service.dart';
import 'package:untitled/services/api/multipart_helper.dart';
import 'package:untitled/utils/app_snackbar.dart';
import '../../../../../../services/storage/storage_services.dart';

class RefereeInfoController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  var isLoading = false.obs;
  var uploadProgress = 0.0.obs;

  // Selected values
  String? selectedDob;
  File? pickedIdCard;

  // Method to pick file
  Future<void> pickIdCard() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      pickedIdCard = File(result.files.single.path!);
      update();
    }
  }

  // Date Picker logic
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // API expects YYYY-MM-DD
      selectedDob = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      update();
    }
  }

  Future<void> completeProcess() async {
    if (firstNameController.text.isEmpty || 
        lastNameController.text.isEmpty || 
        selectedDob == null || 
        phoneController.text.isEmpty ||
        pickedIdCard == null) {
      AppSnackbar.error(title: 'Error', message: 'Please fill in all required fields and upload ID Card');
      return;
    }

    try {
      isLoading.value = true;
      uploadProgress.value = 0.0;

      final Map<String, String> body = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'dateOfBirth': selectedDob!,
        'phone': phoneController.text.trim(),
      };

      List<MultipartFileItem> files = [];
      files.add(MultipartFileItem(
        filePath: pickedIdCard!.path,
        fileName: 'document',
      ));

      final String? token = Get.arguments?['token'];
      final Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      } else if (LocalStorage.token.isNotEmpty) {
        headers['Authorization'] = 'Bearer ${LocalStorage.token}';
      }

      final response = await apiClient.multipart(
        url: ApiEndPoint.refereeProfile,
        headers: headers,
        body: body,
        files: files,
        onSendProgress: (sent, total) {
          if (total > 0) {
            uploadProgress.value = sent / total;
          }
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(title: 'Success', message: response.message);
        
        // After submitting additional info, check payment status
        if (!LocalStorage.paymentStatus) {
          Get.offAllNamed(AppRoutes.mySubscription, arguments: {
            'isFromRegistration': true,
            'token': token,
          });
        } else {
          Get.offAllNamed(AppRoutes.successfulCreateAccount);
        }
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint('❌ completeProcess error: $e');
      AppSnackbar.error(title: 'Error', message: 'Failed to submit referee details.');
    } finally {
      isLoading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
