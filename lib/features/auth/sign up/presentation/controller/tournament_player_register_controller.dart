import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../services/storage/storage_keys.dart';
import '../../../../../../services/storage/storage_services.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/api/multipart_helper.dart';
import '../../../../../utils/app_snackbar.dart';

class TournamentPlayerRegisterController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  final playerFirstName = TextEditingController();
  final playerLastName = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;
  double uploadProgress = 0.0;

  // Selected values
  String? selectedDob;
  String? selectedAgeGroup;
  String? selectedPosition = "Forward";
  String? selectedStrongFoot = "Right";

  // File Picker variable
  File? pickedImage;

  // Data Lists
  final List<String> ageGroups = ["U18", "U16", "U21", "SENIOR"];
  final List<String> positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"];
  final List<String> strongFootOptions = ["Right", "Left", "Both"];

  void setAgeGroup(String value) {
    selectedAgeGroup = value;
    update();
  }

  void setPosition(String value) {
    selectedPosition = value;
    update();
  }

  void setStrongFoot(String value) {
    selectedStrongFoot = value;
    update();
  }

  Future<void> pickIdImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      pickedImage = File(result.files.single.path!);
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

  Future<void> submitRegistration() async {
    if (playerFirstName.text.isEmpty || playerLastName.text.isEmpty || selectedDob == null) {
      AppSnackbar.error(title: 'Error', message: 'Please fill in all required fields');
      return;
    }

    try {
      isLoading = true;
      uploadProgress = 0.0;
      update();

      final Map<String, String> body = {
        'firstName': playerFirstName.text.trim(),
        'lastName': playerLastName.text.trim(),
        'dateOfBirth': selectedDob!,
        'ageGroup': selectedAgeGroup ?? "",
        'position': selectedPosition ?? "",
        'strongFoot': selectedStrongFoot ?? "Right",
        'phone': phoneController.text.trim(),
      };

      List<MultipartFileItem> files = [];
      if (pickedImage != null) {
        files.add(MultipartFileItem(
          filePath: pickedImage!.path,
          fileName: 'document',
        ));
      }

      final String? token = Get.arguments?['token'];
      final Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      } else if (LocalStorage.token.isNotEmpty) {
        headers['Authorization'] = 'Bearer ${LocalStorage.token}';
      }

      final response = await apiClient.multipart(
        url: ApiEndPoint.playerProfile,
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
        await LocalStorage.setString(LocalStorageKeys.profileStatus, "PENDING");
        
        // Tournament players don't need to pay, go straight to success
        Get.toNamed(AppRoutes.successfulCreateAccount);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint('❌ submitRegistration error: $e');
      AppSnackbar.error(title: 'Error', message: 'Failed to submit tournament player details.');
    } finally {
      isLoading = false;
      uploadProgress = 0.0;
      update();
    }
  }

  @override
  void onClose() {
    playerFirstName.dispose();
    playerLastName.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
