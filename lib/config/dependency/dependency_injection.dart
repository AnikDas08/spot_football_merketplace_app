import 'package:get/get.dart';
import 'package:untitled/features/shop/presentation/controllers/shop_controller.dart';
import 'package:untitled/features/transferms_history/presentation/controllers/tab_controller.dart';
import '../../features/player_profile/presentation/controllers/player_profile_controller.dart';

import '../../features/auth/change_password/presentation/controller/change_password_controller.dart';
import '../../features/auth/forgot password/presentation/controller/forget_password_controller.dart';
import '../../features/auth/sign in/presentation/controller/sign_in_controller.dart';
import '../../features/auth/sign up/presentation/controller/sign_up_controller.dart';
import '../../features/home/presentation/controllers/banner_controller.dart';
import '../../features/match_info/presentation/controllers/tabs_controller.dart';
import '../../features/message/presentation/controller/chat_controller.dart';
import '../../features/message/presentation/controller/message_controller.dart';
import '../../features/navbar/controller/navbar_controller.dart';
import '../../features/notifications/presentation/controller/notifications_controller.dart';
import '../../features/profile/presentation/controller/profile_controller.dart';
import '../../features/setting/presentation/controller/privacy_policy_controller.dart';
import '../../features/setting/presentation/controller/setting_controller.dart';
import '../../features/setting/presentation/controller/terms_of_services_controller.dart';
import '../../features/stats_flow/presentation/controller/add_player_controller.dart';
import '../../features/transferms/presentation/controller/transfer_form_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut(() => TermsOfServicesController(), fenix: true);
    Get.lazyPut(() => BannerController(), fenix: true);
    Get.lazyPut(() => NavBarController(), fenix: true);
    Get.lazyPut(() => TransferFormController(), fenix: true);
    Get.lazyPut(() => TabsController(), fenix: true);
    Get.lazyPut(() => AddPlayerController(), fenix: true);
    Get.lazyPut(() => PlayerProfileController(), fenix: true);
    Get.lazyPut(() => TabController(), fenix: true);
    Get.lazyPut(() => ShopController(), fenix: true);

  }
}
