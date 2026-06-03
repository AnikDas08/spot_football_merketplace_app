import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/multipart_helper.dart';
import '../../../../config/api/api_end_point.dart';
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

  // Dropdown Lists
  final List<String> ageGroups = ["U18", "U16", "U21", "SENIOR"];
  final List<String> positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"];
  List<Map<String, dynamic>> teams = [];

  // Selected values for dropdowns
  String? selectedAgeGroup;
  String? selectedTeam;
  String? selectedPosition;

  /// Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final ageGroupController = TextEditingController();
  final teamController = TextEditingController();
  final positionController = TextEditingController();

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

      // 1. Fetch Generic Profile
      final genericResponse = await apiClient.get(
        ApiEndPoint.profile,
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (genericResponse.statusCode == 200) {
        final genericData = genericResponse.data['data'];
        
        // Populate display name immediately from generic data fallback to prevent flicker
        String fallbackName = genericData['userName'] ?? "";
        String initialFirstName = genericData['firstName'] ?? (fallbackName.isNotEmpty ? fallbackName.split(' ').first : "");
        String initialLastName = genericData['lastName'] ?? (fallbackName.contains(' ') ? fallbackName.split(' ').last : "");
        
        firstNameController.text = initialFirstName;
        lastNameController.text = initialLastName;
        
        String fullName = "$initialFirstName $initialLastName".trim();
        if (fullName.isEmpty) fullName = fallbackName;
        
        genericData['fullName'] = fullName;
        profileData.value = genericData;
        await LocalStorage.setString(LocalStorageKeys.myName, fullName);

        // Basic Info
        emailController.text = genericData['email'] ?? "";
        await LocalStorage.setString(LocalStorageKeys.myEmail, genericData['email'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.myImage, genericData['profile'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.role, genericData['role'] ?? "");
        await LocalStorage.setString(LocalStorageKeys.userId, genericData['_id'] ?? "");
        String status = genericData['profileStatus'] ?? "";
        await LocalStorage.setString(LocalStorageKeys.profileStatus, status);

        // 2. Fetch Role Specific Profile
        final role = (genericData['role'] ?? "").toString().toUpperCase();
        String? roleEndpoint;
        if (role == 'PLAYER') roleEndpoint = ApiEndPoint.playerProfile;
        else if (role == 'MANAGER') roleEndpoint = ApiEndPoint.managerProfile;
        else if (role == 'REFEREE') roleEndpoint = ApiEndPoint.refereeProfile;
        else if (role == 'OTHER_CLUBS' || role == 'TRIAL') roleEndpoint = ApiEndPoint.trialProfile;

        if (roleEndpoint != null) {
          final roleResponse = await apiClient.get(
            roleEndpoint,
            headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
          );

          if (roleResponse.statusCode == 200) {
            final roleData = roleResponse.data['data'];
            debugPrint("📊 Fetched Specific Profile Data: $roleData");
            
            // Merge or override with specific data
            firstNameController.text = roleData['firstName'] ?? genericData['userName']?.split(' ').first ?? "";
            lastNameController.text = roleData['lastName'] ?? (genericData['userName']?.contains(' ') == true ? genericData['userName']?.split(' ').last : "") ?? "";
            phoneController.text = roleData['phone'] ?? "";
            dobController.text = roleData['dateOfBirth'] != null ? roleData['dateOfBirth'].toString().split('T')[0] : "";
            
            // Team Handling - check multiple possible fields
            if (roleData['selectTeam'] is Map) {
              selectedTeam = roleData['selectTeam']['id'] ?? roleData['selectTeam']['_id'];
              teamController.text = roleData['selectTeam']['teamName'] ?? "";
            } else {
              selectedTeam = roleData['selectTeam'] ?? roleData['teamId'] ?? roleData['selectGroup'];
              teamController.text = roleData['selectTeam'] ?? roleData['selectGroup'] ?? "";
            }

            debugPrint("📌 Identified Team ID: $selectedTeam");

            if (selectedTeam != null && selectedTeam!.isNotEmpty) {
              await LocalStorage.setString(LocalStorageKeys.teamId, selectedTeam!);
            }

            selectedPosition = roleData['position'];
            selectedAgeGroup = roleData['ageGroup'];

            // Update profileStatus from specific role data (often 'status' field)
            String specificStatus = roleData['status'] ?? "";
            if (specificStatus.isNotEmpty) {
              await LocalStorage.setString(LocalStorageKeys.profileStatus, specificStatus);
            }

            // Update display name again with specific data
            String updatedFullName = "${firstNameController.text} ${lastNameController.text}".trim();
            if (updatedFullName.isNotEmpty) {
              genericData['fullName'] = updatedFullName;
              profileData.value = genericData;
              profileData.refresh();
              await LocalStorage.setString(LocalStorageKeys.myName, updatedFullName);
            }

            // Update controllers
            ageGroupController.text = roleData['ageGroup'] ?? "";
            positionController.text = roleData['position'] ?? "";
          }
        } else {
          // Fallback if no specific role profile exists yet
          firstNameController.text = genericData['userName']?.split(' ').first ?? "";
          lastNameController.text = (genericData['userName']?.contains(' ') == true ? genericData['userName']?.split(' ').last : "") ?? "";
        }

        await LocalStorage.setString(LocalStorageKeys.myName, "${firstNameController.text} ${lastNameController.text}");
        
        // Update profileData with formatted name to prevent drawer flicker
        profileData['fullName'] = "${firstNameController.text} ${lastNameController.text}";
        profileData.refresh();

        // Fetch teams if role requires it
        if (role == 'PLAYER' || role == 'MANAGER' || role == 'OTHER_CLUBS' || role == 'TRIAL') {
          fetchTeams();
        }
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

  /// Fetch Teams
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

  void setAgeGroup(String value) {
    selectedAgeGroup = value;
    ageGroupController.text = value;
    update();
  }

  void setTeam(String value) {
    selectedTeam = value;
    teamController.text = value;
    update();
  }

  void setPosition(String value) {
    selectedPosition = value;
    positionController.text = value;
    update();
  }

  /// Update profile
  Future<void> editProfileRepo() async {
    if (LocalStorage.token.isEmpty) return;

    try {
      _setLoading(true);

      final role = LocalStorage.role.toUpperCase();
      String url = ApiEndPoint.playerProfile;

      if (role == 'MANAGER') {
        url = ApiEndPoint.managerProfile;
      } else if (role == 'REFEREE') {
        url = ApiEndPoint.refereeProfile;
      } else if (role == 'OTHER_CLUBS' || role == 'TRIAL') {
        url = ApiEndPoint.trialProfile;
      }

      final body = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'dateOfBirth': dobController.text.trim(),
      };

      // Add role-specific fields
      if (role == 'PLAYER' || role == 'OTHER_CLUBS' || role == 'TRIAL' || role == 'MANAGER') {
        if (selectedTeam != null) body['selectTeam'] = selectedTeam!;
        if (selectedAgeGroup != null) body['ageGroup'] = selectedAgeGroup!;
        if (selectedPosition != null) body['position'] = selectedPosition!;
      }

      final files = image != null
          ? [MultipartFileItem(fileName: 'image', filePath: image!)]
          : <MultipartFileItem>[];

      final response = await apiClient.multipart(
        url: url,
        body: body,
        files: files,
        method: 'PATCH',
        headers: {'Authorization': 'Bearer ${LocalStorage.token}'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(
          title: 'Success',
          message: 'Profile updated successfully',
        );
        getProfileData(); // Refresh data
        Get.back();
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Select Date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      update();
    }
  }

  /// Dispose controllers
  @override
  void onClose() {
    super.onClose();
  }
}
