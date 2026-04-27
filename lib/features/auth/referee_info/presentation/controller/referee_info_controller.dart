import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';

class RefereeInfoController extends GetxController {
  var isLoading = false.obs;
  var selectedExperience = "".obs;
  var assignedLeague = "".obs;

  void completeProcess() async {
    // if (selectedExperience.value.isEmpty) {
    //   Get.snackbar("Error", "Please select an experience level");
    //   return;
    // }

    isLoading.value = true;
    
    // Simulating API call or processing delay
    await Future.delayed(const Duration(seconds: 1));

    // Save Referee role and info
    await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
    await LocalStorage.setString(LocalStorageKeys.role, "Referee");
    // You might want to save more info here if needed
    
    isLoading.value = false;
    
    // Navigate to home screen
    Get.offAllNamed(AppRoutes.navBarScreen);
  }
}
