import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';
import '../../data/player_registation_model.dart';

class PlayerRegistrationController extends GetxController {
  late RxList<RegistrationPlan> plans;
  late Rx<RegistrationPlan?> selectedPlan;
  late RxBool isLoading;

  @override
  void onInit() {
    super.onInit();
    isLoading = false.obs;
    selectedPlan = Rx<RegistrationPlan?>(null);

    // Initialize plans based on the screenshot
    plans = RxList([
      RegistrationPlan(
        id: '1',
        title: 'AMATEUR',
        badge: '🛡️',
        price: 4.95,
        priceSubtitle: '/Season',
        features: [
          'ENG Coins Program',
          'Player Stats',
          'ENG Coins with a red cross',
        ],
        featureStatus: [true, false, false], // Check, Cross, Cross
        buttonText: 'SELECT AMATEUR',
        isSelected: false,
      ),
      RegistrationPlan(
        id: '2',
        title: 'SEMI PRO',
        badge: '✨',
        price: 9.95,
        priceSubtitle: '/Season',
        features: [
          'Enhanced Team Registration',
          'Detailed Player Stats',
          'No ENG Coins',
        ],
        featureStatus: [true, true, false], // Check, Check, Cross
        buttonText: 'SELECT SEMI PRO',
        isSelected: false,
      ),
      RegistrationPlan(
        id: '3',
        title: 'PROFESSIONAL',
        badge: '👑',
        price: 14.95,
        priceSubtitle: '/Season',
        features: [
          'Full Club Registration',
          'Elite Player Stats',
          'ENG Coins Program',
        ],
        featureStatus: [true, true, true], // Check, Check, Check
        buttonText: 'SELECT PROFESSIONAL',
        isSelected: false,
      ),
    ]);
  }

  void selectPlan(String planId) {
    for (var plan in plans) {
      plan.isSelected = (plan.id == planId);
      if (plan.isSelected) {
        selectedPlan.value = plan;
      }
    }
    plans.refresh();
    update();
  }

  void continueWithPlan() async {
    if (selectedPlan.value != null) {
      isLoading.value = true;

      // Simulating API call
      await Future.delayed(const Duration(seconds: 1));

      // Save role and plan to local storage using the consistent setter
      await LocalStorage.setString(LocalStorageKeys.role, "Player");
      await LocalStorage.setString(
        LocalStorageKeys.plan,
        selectedPlan.value!.title.trim().toUpperCase(),
      );
      print(
        "${selectedPlan.value!.title.trim()}==============================================================",
      );

      isLoading.value = false;
      // If the user is already logged in, it means they are changing the plan
      if (LocalStorage.isLogIn) {
        Get.back();
      } else {
        Get.toNamed(AppRoutes.verify_player_screen);
      }
    }
  }

  void switchPrimaryRoleLater() {}
}
