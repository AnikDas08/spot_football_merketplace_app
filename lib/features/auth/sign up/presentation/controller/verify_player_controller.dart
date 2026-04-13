import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VerifyPlayerController extends GetxController {
  final playerFirstName = TextEditingController();
  final playerLastName = TextEditingController();

  // Selected values
  String? selectedDob;
  String? selectedAgeGroup;
  String? selectedTeam;
  String? selectedPosition = "Forward";

  // Image Picker variables
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  // Data Lists
  final List<String> ageGroups = ["U-12", "U-15", "U-18", "Senior"];
  final List<String> teams = ["Lions FC", "Tigers United", "Dragons SC", "Eagles Academy"];
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
      selectedDob = "${picked.day}/${picked.month}/${picked.year}";
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