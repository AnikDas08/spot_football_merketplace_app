import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/services/api/api_client.dart';

import 'package:untitled/services/api/multipart_helper.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/helpers/other_helper.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find<ProfileController>();

  /// Language list
  final List<String> languages = ['English', 'French', 'Arabic'];
  String selectedLanguage = 'English';
  String? image;
  bool isLoading = false;
  bool isProfileLoading = false;

  /// Profile Data
  var profileData = {}.obs;

  /// Text controllers
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  final ApiClient apiClient = DioApiClient();

  @override
  void onInit() {
    super.onInit();
    if (LocalStorage.token.isNotEmpty) {
      getProfileData();
    }
  }

  /// Get Profile Data
  Future<void> getProfileData() async {
    try {
      isProfileLoading = true;
      update();

      final response = await apiClient.get(
        ApiEndPoint.profile, // Assuming ApiEndPoint.profile is "/user/profile"
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        profileData.value = data;

        // Save basic info to LocalStorage for offline/immediate use
        await LocalStorage.setString(LocalStorageKeys.myName, data['userName'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.myEmail, data['email'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.myImage, data['profile'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.role, data['role'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.userId, data['_id'] ?? "");
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isProfileLoading = false;
      update();
    }
  }

  /// Pick profile image
  Future<void> getProfileImage() async {
    image = await OtherHelper.pickImage();
    update();
  }

  /// Select language
  void selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// Set loading safely
  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  /// Update profile
  Future<void> editProfileRepo() async {
    if (LocalStorage.token.isEmpty) return;

    try {
      _setLoading(true);

      final body = {
        'fullName': nameController.text.trim(),
        'phone': numberController.text.trim(),
      };

      final files = image != null
          ? [MultipartFileItem(fileName: 'image', filePath: image!)]
          : <MultipartFileItem>[];

      final response = await apiClient.multipart(
        url: ApiEndPoint.user,
        body: body,
        files: files,
      );

      if (response.statusCode != 200) {
        throw Exception(response.message);
      }

      final Map<String, dynamic> data = response.data['data'] ?? {};

      //LocalStorage.saveUser(data['user']);

      AppSnackbar.success(
        title: 'Success',
        message: 'Profile updated successfully',
      );

      nameController.clear();
      numberController.clear();
      //Get.offNamed(AppRoutes.profile);
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Dispose controllers
  @override
  void onClose() {
    super.onClose();
  }
}
