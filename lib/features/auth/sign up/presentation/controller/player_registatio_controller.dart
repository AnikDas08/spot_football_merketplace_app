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

  void continuWithPlan() {
    if (selectedPlan.value != null) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
        // Navigation logic goes here
      });
    }
  }

  void switchPrimaryRoleLater() {}
}
