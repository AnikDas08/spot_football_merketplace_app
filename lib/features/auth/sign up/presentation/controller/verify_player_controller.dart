import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/api_service.dart';
import 'package:untitled/utils/app_snackbar.dart';
import '../../../../../../services/storage/storage_keys.dart';
import '../../../../../../services/storage/storage_services.dart';

class VerifyPlayerController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  final playerFirstName = TextEditingController();
  final playerLastName = TextEditingController();

  bool isLoading = false;

  // Selected values
  String? selectedDob;
  String? selectedAgeGroup;
  String? selectedTeam;
  String? selectedPosition = "Forward";
  String? selectedGender;
  String? selectedNationality;

  // Image Picker variables
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

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

  // Method to pick image from gallery
  Future<void> pickIdImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      pickedImage = File(image.path);
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
    try {
      isLoading = true;
      update();

      final token = LocalStorage.token;
      
      final Map<String, dynamic> body = {
        'firstName': playerFirstName.text.trim(),
        'lastName': playerLastName.text.trim(),
        'dateOfBirth': selectedDob,
        'ageGroup': selectedAgeGroup,
        'selectGroup': selectedTeam, 
        'position': selectedPosition,
      };

      if (pickedImage != null) {
        body['document'] = await dio.MultipartFile.fromFile(
          pickedImage!.path,
          filename: pickedImage!.path.split('/').last,
        );
      }

      final response = await apiClient.post(
        ApiEndPoint.playerProfile,
        headers: {'Authorization': token},
        body: body,

      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(title: 'Success', message: response.message);
        // Next step in flow: Plan Selection
        Get.toNamed(AppRoutes.player_registration_screen);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint('❌ submitVerification error: $e');
      AppSnackbar.error(title: 'Error', message: 'Failed to submit player details.');
    } finally {
      isLoading = false;
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
