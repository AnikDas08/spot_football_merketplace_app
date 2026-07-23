
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/auth/delete_account/presentation/screen/delete_account_screen.dart';
import '../../features/auth/change_password/presentation/screen/change_password_screen.dart';
import '../../features/auth/forgot password/presentation/screen/create_password.dart';
import '../../features/auth/forgot password/presentation/screen/forgot_password.dart';
import '../../features/auth/forgot password/presentation/screen/verify_screen.dart';
import '../../features/auth/referee_info/presentation/screen/referee_info_screen.dart';
import '../../features/auth/select_role/select_role.dart';
import '../../features/auth/sign in/presentation/screen/sign_in_screen.dart';
import '../../features/auth/sign up/presentation/screen/manager_registation_screen.dart';
import '../../features/auth/sign up/presentation/screen/manager_subscription_screen.dart';
import '../../features/auth/sign up/presentation/screen/player_register_screen.dart';
import '../../features/auth/sign up/presentation/screen/sign_up_screen.dart';
import '../../features/auth/sign up/presentation/screen/successful_create_account.dart';
import '../../features/auth/sign up/presentation/screen/verify_player_screen.dart';
import '../../features/auth/sign up/presentation/screen/verify_user.dart';
import '../../features/auth/trial_registration/presentation/screen/trial_registration_screen.dart';
import '../../features/eng_tv_flow/presentation/screen/video_stream_screen.dart';
import '../../features/fixtures/presentation/screen/fixtures_screen.dart';
import '../../features/home/presentation/screens/club_profile_screen.dart';
import '../../features/home/presentation/screens/league_preview_screen.dart';
import '../../features/league_tables/presentation/screen/league_tables_screen.dart';
import '../../features/live_match_control/presentation/screen/live_match_control_screen.dart';
import '../../features/live_match_control/presentation/screen/record_goal_screen.dart';
import '../../features/match_info/presentation/screens/match_info_screen.dart';
import '../../features/my_subscription/presentation/screens/my_subscription_screen.dart';
import '../../features/navbar/screen/navbar_screen.dart';
import '../../features/news_details/presentation/screens/news_details_screen.dart';
import '../../features/notifications/presentation/screen/notifications_screen.dart';
import '../../features/onboarding_screen/onboarding_screen.dart';
import '../../features/player_profile/presentation/screens/player_profile_screen.dart';
import '../../features/profile/presentation/screen/edit_profile.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/profile/presentation/screens/my_children_screen.dart';
import '../../features/profile/presentation/screens/my_profile_screen.dart';
import '../../features/referee_dashboard/presentation/screen/referee_dashboard_screen.dart';
import '../../features/setting/presentation/screen/privacy_policy_screen.dart';
import '../../features/setting/presentation/screen/setting_screen.dart';
import '../../features/setting/presentation/screen/terms_of_services_screen.dart';
import '../../features/shop/presentation/screens/shop_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/stats_flow/presentation/screen/add_player_screen.dart';
import '../../features/stats_flow/presentation/screen/player_comparison_screen.dart';
import '../../features/stats_flow/presentation/screen/season_stats_screen.dart';
import '../../features/team_sheet/presentation/screen/team_sheet_screen.dart';
import '../../features/transferms/presentation/screen/tranasfer_pending_approval.dart';
import '../../features/transferms/presentation/screen/player_profile_details_screen.dart';
import '../../features/transferms/presentation/screen/transfer_request_screen.dart';
import '../../features/transferms/presentation/screen/transferm_screen.dart';
import '../../features/transferms_history/presentation/screens/transfers_history_screen.dart';

import '../../features/home/presentation/screens/all_events_screen.dart';
import '../../features/home/presentation/screens/all_results_screen.dart';
import '../../features/home/presentation/screens/all_videos_screen.dart';
import '../../features/news/presentation/screens/all_news_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String allNews = "/allNews";
  static const String allEvents = "/allEvents";
  static const String allResults = "/allResults";
  static const String allVideos = "/allVideos";
  static const String transferFormScreen = '/transferFormScreen.dart';
  static const String seasonStatsScreen = '/seasonStatsScreen.dart';
  static const String addPlayerScreen = '/addPlayerScreen.dart';
  static const String playerComparisonScreen = '/playerComparisonScreen.dart';
  static const String transferPendingApproval = '/transferPendingApproval.dart';
  static const String navBarScreen = '/navBarScreen.dart';
  static const String videoStreamScreen = '/videoStreamScreen.dart';
  static const String playerProfileDetailsScreen = '/playerProfileDetailsScreen.dart';
  static const String clubProfileScreen = '/clubProfileScreen.dart';

  // added by ajijul
  static const String matchInfo = "/matchInfo";
  static const String leaguePreview = "/leaguePreview";
  static const String leagueTable = "/leagueTable";
  static const String newsDetails = "/newsDetails";
  static const String playerProfile = "/playerProfile";
  static const String myChildren = "/myChildren";
  static const String myProfile = "/myProfile";
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
  static const String roleSelectScreen = '/role_select_screen';
  static const String playerRegistrationScreen = '/player_registration_screen';
  static const String successfulCreateAccount = '/successful_create_account';
  static const String verifyPlayerScreen = '/verify_player_screen';
  static const String managerRegistrationScreen = '/manager_registation_screen';
  static const String managerSubscriptionScreen = '/manager_subscription_screen';
  static const String trialRegistrationScreen = '/trial_registration_screen';
  static const String refereeInfoScreen = '/referee_info_screen';
  static const String refereeDashboardScreen = '/referee_dashboard_screen';
  static const String liveMatchControlScreen = '/live_match_control_screen';
  static const String recordGoalScreen = '/record_goal_screen';
  static const String transferRequestScreen = '/transfer_request_screen';
  static const String teamSheetScreen = '/team_sheet_screen';
  static const String trialList = '/trial-list';
  static const String deleteAccount = '/delete_account';

  static List<GetPage<String>> routes = [
    GetPage(name: allNews, page: () => const AllNewsScreen()),
    GetPage(name: allEvents, page: () => const AllEventsScreen()),
    GetPage(name: allResults, page: () => const AllResultsScreen()),
    GetPage(name: allVideos, page: () => const AllVideosScreen()),
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
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => const TermsOfServicesScreen()),
    GetPage(name: setting, page: () => const SettingScreen()),
    //added by Arif
    GetPage(name: navBarScreen, page: () => NavBarScreen()),
    GetPage(
      name: transferPendingApproval,
      page: () => TransferPendingApproval(),
    ),
    GetPage(name: matchInfo, page: () => MatchInfoScreen()),
    GetPage(name: leaguePreview, page: () => const LeaguePreviewScreen()),
    GetPage(name:  navBarScreen, page: () =>   NavBarScreen()),
    GetPage(name:  transferPendingApproval, page: () =>   TransferPendingApproval()),
    GetPage(name:  seasonStatsScreen, page: () =>   SeasonStatsScreen()),
    GetPage(name:  playerComparisonScreen, page: () =>   PlayerComparisonScreen()),
    GetPage(name:  addPlayerScreen, page: () =>   AddPlayerScreen()),
    GetPage(name:  videoStreamScreen, page: () =>   VideoStreamScreen()),
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
    GetPage(name: myChildren, page: () => const MyChildrenScreen()),
    GetPage(name: myProfile, page: () => const MyProfileScreen()),
    GetPage(
      name: transferHistoryScreen,
      page: () => const TransfersHistoryScreen(),
    ),
    GetPage(name: shopScreen, page: () =>  ShopScreen()),
    GetPage(name: mySubscription, page: () => const MySubscriptionScreen()),
    GetPage(name: fixtures, page: () => FixturesScreen()),
    GetPage(name: roleSelectScreen, page: () => SelectRole()),
    GetPage(name: playerRegistrationScreen, page: () => PlayerRegisterScreen()),
    GetPage(name: successfulCreateAccount, page: () => SuccessfulCreateAccount()),
    GetPage(name: verifyPlayerScreen, page: () => VerifyPlayerScreen()),
    GetPage(name: managerRegistrationScreen, page: () => ManagerRegistationScreen()),
    GetPage(name: managerSubscriptionScreen, page: () => ManagerSubscriptionScreen()),
    GetPage(name: trialRegistrationScreen, page: () => const TrialRegistrationScreen()),
    GetPage(name: refereeInfoScreen, page: () => const RefereeInfoScreen()),
    GetPage(name: refereeDashboardScreen, page: () => const RefereeDashboardScreen()),
    GetPage(name: leagueTable, page: () => const LeagueTablesScreen()),
    GetPage(name: playerProfileDetailsScreen, page: () => const PlayerProfileDetailsScreen()),
    GetPage(name: liveMatchControlScreen, page: () => const LiveMatchControlScreen()),
    GetPage(name: recordGoalScreen, page: () => const RecordGoalScreen()),
    GetPage(name: transferRequestScreen, page: () => const TransferRequestScreen()),
    GetPage(name: teamSheetScreen, page: () => const TeamSheetScreen()),
    GetPage(name: clubProfileScreen, page: () =>  ClubProfileScreen()),
    GetPage(name: trialList, page: () =>  TransferScreen()),
    GetPage(name: deleteAccount, page: () => const DeleteAccountScreen()),
  ];
}
