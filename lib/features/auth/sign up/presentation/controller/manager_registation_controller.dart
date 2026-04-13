import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ManagerRegistationController extends GetxController {
  final playerFirstName = TextEditingController();
  final playerLastName = TextEditingController();
  final emailAddress = TextEditingController();
  final phoneNumber = TextEditingController();

  // Selected values
  String? selectedDob;
  String? selectedAgeGroup;
  String? selectedTeam;
  String? selectedPosition = "Forward";

  // Image Picker variables
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();


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


  @override
  void onClose() {
    playerFirstName.dispose();
    playerLastName.dispose();
    super.onClose();
  }
}