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
import '../../../../../../services/storage/storage_keys.dart';
import '../../../../../../services/storage/storage_services.dart';

class VerifyPlayerController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  final playerFirstName = TextEditingController();
  final playerLastName = TextEditingController();

  bool isLoading = false;
  double uploadProgress = 0.0;

  // Selected values
  String? selectedDob;
  String? selectedAgeGroup;
  String? selectedTeam;
  String? selectedPosition = "Forward";
  String? selectedGender;
  String? selectedNationality;

  // File Picker variable
  File? pickedImage;

  // Data Lists
  final List<String> ageGroups = ["U18", "U15", "U12", "Senior"];
  final List<String> teams = ["A", "B", "C"];
  final List<String> positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"];

  void setAgeGroup(String value) {
    selectedAgeGroup = value;
    update();
  }

  void setTeam(String value) {
    selectedTeam = value;
    update();
  }

  void setPosition(String value) {
    selectedPosition = value;
    update();
  }

  // Method to pick file (image, pdf, etc.)
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

  Future<void> submitVerification() async {
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
        'selectGroup': selectedTeam ?? "",
        'position': selectedPosition ?? "",
      };

      List<MultipartFileItem> files = [];
      if (pickedImage != null) {
        files.add(MultipartFileItem(
          filePath: pickedImage!.path,
          fileName: 'document',
        ));
      }

      final response = await apiClient.multipart(
        url: ApiEndPoint.playerProfile,
        headers: {'Authorization': LocalStorage.token},
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
        Get.toNamed(AppRoutes.player_registration_screen);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint('❌ submitVerification error: $e');
      AppSnackbar.error(title: 'Error', message: 'Failed to submit player details.');
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
    super.onClose();
  }
}
