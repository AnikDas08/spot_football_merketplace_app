import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/helpers/other_helper.dart';

class TrialRegistrationController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  
  // Selected values
  String? selectedDob;
  String? selectedAgeGroup;
  String? selectedPreviousClub;
  String? selectedPosition = "Forward";
  String? selectedStrongFoot;

  // Data Lists
  final List<String> ageGroups = ["U-12", "U-15", "U-18", "Senior"];
  final List<String> previousClubs = ["Lions FC", "Tigers United", "Dragons SC", "Eagles Academy", "None"];
  final List<String> positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"];
  final List<String> strongFeet = ["Right", "Left", "Both"];
  
  String? profileImage;
  bool isLoading = false;

  void setAgeGroup(String value) {
    selectedAgeGroup = value;
    update();
  }

  void setPreviousClub(String value) {
    selectedPreviousClub = value;
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

  // Date Picker logic
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedDob = "${picked.day}/${picked.month}/${picked.year}";
      update();
    }
  }

  Future<void> pickImage() async {
    profileImage = await OtherHelper.pickImage();
    update();
  }

  void submitRequest() async {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields");
      return;
    }

    isLoading = true;
    update();

    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));

    // Save role to local storage
    LocalStorage.role = "Trial";
    await LocalStorage.setString(LocalStorageKeys.role, LocalStorage.role);

    isLoading = false;
    update();

    Get.toNamed(AppRoutes.successful_create_account);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
