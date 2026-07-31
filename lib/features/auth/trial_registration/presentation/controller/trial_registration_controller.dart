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
  String? selectedTeamName;
  String? selectedStrongFoot;
  String? selectedPosition = "Forward";
  File? pickedDocument;

  // Paginated Teams
  final RxList<dynamic> teamsList = <dynamic>[].obs;
  var isTeamsLoading = false.obs;
  var isMoreTeamsLoading = false.obs;
  int teamPage = 1;
  bool hasMoreTeams = true;
  String teamSearch = "";

  // Data Lists
  final List<String> strongFeet = ["LEFT", "RIGHT", "BOTH"];
  final List<String> positions = ["Goalkeeper", "Defender", "Midfielder", "Forward"];

  @override
  void onInit() {
    super.onInit();
    fetchTeams();
  }

  Future<void> fetchTeams({bool isLoadMore = false, String? search}) async {
    if (isLoadMore && !hasMoreTeams) return;

    try {
      if (isLoadMore) {
        isMoreTeamsLoading.value = true;
      } else {
        isTeamsLoading.value = true;
        teamPage = 1;
        teamsList.clear();
      }
      update();

      if (search != null) teamSearch = search;

      String url = "${ApiEndPoint.teams}?page=$teamPage&limit=10";
      if (teamSearch.isNotEmpty) url += "&searchTerm=$teamSearch";

      final response = await apiClient.get(
        url,
        headers: LocalStorage.token.isNotEmpty ? {'Authorization': 'Bearer ${LocalStorage.token}'} : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final pagination = response.data['pagination'];

        if (isLoadMore) {
          teamsList.addAll(data);
        } else {
          teamsList.assignAll(data);
        }

        if (pagination != null) {
          int totalPage = pagination['totalPage'] ?? 1;
          hasMoreTeams = teamPage < totalPage;
        } else {
          hasMoreTeams = false;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchTeams error: $e');
    } finally {
      isTeamsLoading.value = false;
      isMoreTeamsLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreTeams() async {
    if (!isMoreTeamsLoading.value && hasMoreTeams) {
      teamPage++;
      await fetchTeams(isLoadMore: true);
    }
  }

  void setTeam(String id, String name) {
    selectedTeam = id;
    selectedTeamName = name;
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

        // After submitting additional info, redirect to success screen
        // Subscription is no longer required for Trial users
        Get.toNamed(AppRoutes.successfulCreateAccount);
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
