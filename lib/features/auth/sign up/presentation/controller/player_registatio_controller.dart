import 'package:get/get.dart';
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

    // Initialize plans
    plans = RxList([
      RegistrationPlan(
        id: '1',
        title: 'AMATEUR',
        badge: '🎖️',
        price: 4.95,
        priceSubtitle: '/Season',
        features: [
          'ENG Coins Program',
          'Player Stats',
          'ENG Coins with a red cross',
        ],
        featureStatus: [true, true, false],
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
        featureStatus: [true, true, false],
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
        featureStatus: [true, true, true],
        buttonText: 'SELECT PROFESSIONAL',
        isSelected: false,
      ),
    ]);
  }

  /// Select a plan
  void selectPlan(String planId) {
    final updatedPlans = plans.map((plan) {
      if (plan.id == planId) {
        selectedPlan.value = plan.copyWith(isSelected: true);
        return plan.copyWith(isSelected: true);
      } else {
        return plan.copyWith(isSelected: false);
      }
    }).toList();

    plans.assignAll(updatedPlans);
    update();
  }

  /// Get selected plan details
  RegistrationPlan? getSelectedPlan() {
    return selectedPlan.value;
  }

  /// Continue with selected plan
  void continuWithPlan() {
    if (selectedPlan.value != null) {
      isLoading.value = true;

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
        // Navigate to next screen
        Get.snackbar(
          'Success',
          'Selected Plan: ${selectedPlan.value!.title}',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    } else {
      Get.snackbar(
        'Warning',
        'Please select a plan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Switch primary role later
  void switchPrimaryRoleLater() {
    Get.snackbar(
      'Info',
      'You can switch your primary role in settings',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}