import 'package:get/get.dart';
import 'package:untitled/features/auth/select_role/select_role.dart';
import 'package:untitled/features/auth/trial_registration/presentation/screen/trial_registration_screen.dart';
import 'package:untitled/features/auth/sign%20up/presentation/screen/manager_registation_screen.dart';
import 'package:untitled/features/auth/sign%20up/presentation/screen/manager_subscription_screen.dart';
import 'package:untitled/features/auth/sign%20up/presentation/screen/player_register_screen.dart';
import 'package:untitled/features/auth/sign%20up/presentation/screen/successful_create_account.dart';
import 'package:untitled/features/auth/sign%20up/presentation/screen/verify_player_screen.dart';
import 'package:untitled/features/fixtures/presentation/screen/fixtures_screen.dart';
import 'package:untitled/features/match_info/presentation/screens/match_info_screen.dart';
import 'package:untitled/features/news_details/presentation/screens/news_details_screen.dart';
import 'package:untitled/features/player_profile/presentation/screens/player_profile_screen.dart';
import '../../features/auth/change_password/presentation/screen/change_password_screen.dart';
import '../../features/auth/forgot password/presentation/screen/create_password.dart';
import '../../features/auth/forgot password/presentation/screen/forgot_password.dart';
import '../../features/auth/forgot password/presentation/screen/verify_screen.dart';
import '../../features/auth/sign in/presentation/screen/sign_in_screen.dart';
import '../../features/auth/sign up/presentation/screen/sign_up_screen.dart';
import '../../features/auth/sign up/presentation/screen/verify_user.dart';
import '../../features/eng_tv_flow/presentation/screen/video_stream_screen.dart';
import '../../features/home/presentation/screens/league_preview_screen.dart';
import '../../features/message/presentation/screen/chat_screen.dart';
import '../../features/message/presentation/screen/message_screen.dart';
import '../../features/my_subscription/presentation/screens/my_subscription_screen.dart';
import '../../features/navbar/screen/navbar_screen.dart';
import '../../features/notifications/presentation/screen/notifications_screen.dart';
import '../../features/onboarding_screen/onboarding_screen.dart';
import '../../features/profile/presentation/screen/edit_profile.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/setting/presentation/screen/privacy_policy_screen.dart';
import '../../features/setting/presentation/screen/setting_screen.dart';
import '../../features/setting/presentation/screen/terms_of_services_screen.dart';
import '../../features/shop/presentation/screens/shop_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/stats_flow/presentation/screen/add_player_screen.dart';
import '../../features/stats_flow/presentation/screen/player_comparison_screen.dart';
import '../../features/stats_flow/presentation/screen/season_stats_screen.dart';
import '../../features/transferms/presentation/screen/tranasfer_pending_approval.dart';
import '../../features/transferms/presentation/screen/transfer_form_screen.dart';
import '../../features/transferms_history/presentation/screens/transfers_history_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String transferFormScreen = '/transferFormScreen.dart';
  static const String seasonStatsScreen = '/seasonStatsScreen.dart';
  static const String addPlayerScreen = '/addPlayerScreen.dart';
  static const String playerComparisonScreen = '/playerComparisonScreen.dart';
  static const String transferPendingApproval = '/transferPendingApproval.dart';
  static const String navBarScreen = '/navBarScreen.dart';
  static const String videoStreamScreen = '/videoStreamScreen.dart';

  // added by ajijul
  static const String matchInfo = "/matchInfo";
  static const String leaguePreview = "/leaguePreview";
  static const String newsDetails = "/newsDetails";
  static const String playerProfile = "/playerProfile";
  static const String transferHistoryScreen = '/transfer_history_screen.dart';
  static const String shopScreen = '/shop_screen.dart';
  static const String mySubscription = '/subscription_screen.dart';
  static const String fixtures = '/fixtures_screen.dart';

  static const String test = '/test_screen.dart';
  static const String splash = '/';
  static const String onboarding = '/onboarding_screen.dart';
  static const String signUp = '/sign_up_screen.dart';
  static const String verifyUser = '/verify_user.dart';
  static const String signIn = '/sign_in_screen.dart';
  static const String forgotPassword = '/forgot_password.dart';
  static const String verifyEmail = '/verify_screen.dart';
  static const String createPassword = '/create_password.dart';
  static const String changePassword = '/change_password_screen.dart';
  static const String notifications = '/notifications_screen.dart';
  static const String chat = '/chat_screen.dart';
  static const String message = '/message_screen.dart';
  static const String profile = '/profile_screen.dart';
  static const String editProfile = '/edit_profile.dart';
  static const String privacyPolicy = '/privacy_policy_screen.dart';
  static const String termsOfServices = '/terms_of_services_screen.dart';
  static const String setting = '/setting_screen.dart';
  static const String role_select_screen = '/role_select_screen';
  static const String player_registration_screen = '/player_registration_screen';
  static const String successful_create_account = '/successful_create_account';
  static const String verify_player_screen = '/verify_player_screen';
  static const String manager_registation_screen = '/manager_registation_screen';
  static const String manager_subscription_screen = '/manager_subscription_screen';
  static const String trial_registration_screen = '/trial_registration_screen';

  static List<GetPage<String>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUser()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: notifications, page: () => const NotificationsScreen()),
    GetPage(name: chat, page: () => const ChatListScreen()),
    GetPage(name: message, page: () => const MessageScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => const TermsOfServicesScreen()),
    GetPage(name: setting, page: () => const SettingScreen()),
    //added by Arif
    GetPage(name: transferFormScreen, page: () => TransferFormScreen()),
    GetPage(name: navBarScreen, page: () => NavBarScreen()),
    GetPage(
      name: transferPendingApproval,
      page: () => TransferPendingApproval(),
    ),
    GetPage(name: matchInfo, page: () => MatchInfoScreen()),
    GetPage(name: leaguePreview, page: () => const LeaguePreviewScreen()),
    GetPage(name: transferFormScreen, page: () =>  TransferFormScreen()),
    GetPage(name:  navBarScreen, page: () =>   NavBarScreen()),
    GetPage(name:  transferPendingApproval, page: () =>   TransferPendingApproval()),
    GetPage(name:  seasonStatsScreen, page: () =>   SeasonStatsScreen()),
    GetPage(name:  playerComparisonScreen, page: () =>   PlayerComparisonScreen()),
    GetPage(name:  addPlayerScreen, page: () =>   AddPlayerScreen()),
    GetPage(name:  videoStreamScreen, page: () =>   VideoStreamScreen()),
    GetPage(name: transferFormScreen, page: () => TransferFormScreen()),
    GetPage(name: navBarScreen, page: () => NavBarScreen()),
    GetPage(
      name: transferPendingApproval,
      page: () => TransferPendingApproval(),
    ),
    GetPage(name: seasonStatsScreen, page: () => SeasonStatsScreen()),
    GetPage(name: playerComparisonScreen, page: () => PlayerComparisonScreen()),
    GetPage(name: addPlayerScreen, page: () => AddPlayerScreen()),
    GetPage(name: newsDetails, page: () => NewsDetailsScreen()),
    GetPage(name: playerProfile, page: () => PlayerProfileScreen()),
    GetPage(
      name: transferHistoryScreen,
      page: () => const TransfersHistoryScreen(),
    ),
    GetPage(name: shopScreen, page: () => const ShopScreen()),
    GetPage(name: mySubscription, page: () => const MySubscriptionScreen()),
    GetPage(name: fixtures, page: () => FixturesScreen()),
    GetPage(name: role_select_screen, page: () => SelectRole()),
    GetPage(name: player_registration_screen, page: () => PlayerRegisterScreen()),
    GetPage(name: successful_create_account, page: () => SuccessfulCreateAccount()),
    GetPage(name: verify_player_screen, page: () => VerifyPlayerScreen()),
    GetPage(name: manager_registation_screen, page: () => ManagerRegistationScreen()),
    GetPage(name: manager_subscription_screen, page: () => ManagerSubscriptionScreen()),
    GetPage(name: trial_registration_screen, page: () => const TrialRegistrationScreen()),
  ];
}
