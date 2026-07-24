import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../services/storage/storage_services.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/api/multipart_helper.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../utils/app_snackbar.dart';

class TrialRegistrationController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;
  double uploadProgress = 0.0;

  // Selected values
  String? selectedDob;
  String? selectedTeam;
  String? selectedStrongFoot;
  String? selectedPosition = "Forward";
  File? pickedDocument;

  // Data Lists
  List<Map<String, dynamic>> teams = [];
  final List<String> strongFeet = ["LEFT", "RIGHT", "BOTH"];
  final List<String> positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"];

  @override
  void onInit() {
    super.onInit();
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    try {
      final response = await apiClient.get(ApiEndPoint.teams);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          teams = List<Map<String, dynamic>>.from(response.data['data']);
        }
        update();
      }
    } catch (e) {
      debugPrint('❌ fetchTeams error: $e');
    }
  }

  void setTeam(String value) {
    selectedTeam = value;
    update();
  }

  void setStrongFoot(String value) {
    selectedStrongFoot = value;
    update();
  }

  void setPosition(String value) {
    selectedPosition = value;
    update();
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      pickedDocument = File(result.files.single.path!);
      update();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedDob = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      update();
    }
  }

  Future<void> submitRequest() async {
    if (firstNameController.text.isEmpty || 
        lastNameController.text.isEmpty || 
        selectedDob == null || 
        selectedTeam == null || 
        selectedStrongFoot == null ||
        phoneController.text.isEmpty ||
        pickedDocument == null) {
      AppSnackbar.error(title: 'Error', message: 'Please fill in all required fields');
      return;
    }

    try {
      isLoading = true;
      uploadProgress = 0.0;
      update();

      final Map<String, String> body = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'dateOfBirth': selectedDob!,
        'selectTeam': selectedTeam!,
        'strongFoot': selectedStrongFoot!,
        'position': selectedPosition ?? "",
        'phone': phoneController.text.trim(),
      };

      List<MultipartFileItem> files = [
        MultipartFileItem(filePath: pickedDocument!.path, fileName: 'document')
      ];

      final String? token = Get.arguments?['token'];
      final Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      } else if (LocalStorage.token.isNotEmpty) {
        headers['Authorization'] = 'Bearer ${LocalStorage.token}';
      }

      final response = await apiClient.multipart(
        url: ApiEndPoint.trialProfile,
        headers: headers,
        body: body,
        files: files,
        onSendProgress: (sent, total) {
          if (total > 0) {
            uploadProgress = sent / total;
            update();
          }
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(title: 'Success', message: response.message);
        
        // Update local status so app knows info is submitted
        await LocalStorage.setString(LocalStorageKeys.profileStatus, "PENDING");

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
      debugPrint('❌ submitRequest error: $e');
      AppSnackbar.error(title: 'Error', message: 'Failed to submit trial details.');
    } finally {
      isLoading = false;
      update();
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
