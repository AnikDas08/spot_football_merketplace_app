import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/notification/notification_service.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_snackbar.dart';
import '../../../../profile/presentation/controller/profile_controller.dart';

class SignInController extends GetxController {
  bool isLoading = false;

  /// email and password Controller here
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final ApiClient apiClient = DioApiClient();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController(
      text: kDebugMode ? "rodefe4817@cadinr.com" : null,
    );
    passwordController = TextEditingController(
      text: kDebugMode ? "Aaaa@#+11" : null,
    );
  }

  /// Sign in Api call here
  Future<void> signInUser() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();
      final Map<String, String> body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      final response = await apiClient.post(ApiEndPoint.signIn, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        final userData = Jwt.parseJwt(data["accessToken"]);

        final String profileStatus = (data['profileStatus'] == null || data['profileStatus'].toString().isEmpty) 
            ? "INCOMPLETE" 
            : data['profileStatus'];
        final bool paymentStatus = data['paymentStatus'] ?? false;
        final String role = userData['role'] ?? "";

        await LocalStorage.setString(LocalStorageKeys.token, data["accessToken"]);
        await LocalStorage.setString(LocalStorageKeys.refreshToken, data["refreshToken"]);
        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
        await LocalStorage.setString(LocalStorageKeys.profileStatus, profileStatus);
        await LocalStorage.setBool(LocalStorageKeys.paymentStatus, paymentStatus);
        await LocalStorage.setString(LocalStorageKeys.role, role);

        // Update FCM Token
        await NotificationService.updateToken();

        // Fetch profile data immediately after login to get latest statuses
        await Get.find<ProfileController>().getProfileData();

        final String currentProfileStatus = LocalStorage.profileStatus;
        final bool currentPaymentStatus = LocalStorage.paymentStatus;
        final String currentRole = LocalStorage.role.toUpperCase();

        /// navigate
        if (currentProfileStatus == "INCOMPLETE" || currentProfileStatus.isEmpty) {
          if (currentRole == "PLAYER") {
            Get.offAllNamed(AppRoutes.verifyPlayerScreen);
          } else if (currentRole == "MANAGER") {
            Get.offAllNamed(AppRoutes.managerRegistrationScreen);
          } else if (currentRole == "REFEREE") {
            Get.offAllNamed(AppRoutes.refereeInfoScreen);
          } else if (currentRole == "OTHER_CLUBS" || currentRole == "TRIAL" || currentRole == "OTHER CLUBS") {
            Get.offAllNamed(AppRoutes.trialRegistrationScreen);
          } else {
            Get.offAllNamed(AppRoutes.navBarScreen);
          }
        } else if (!currentPaymentStatus) {
          Get.offAllNamed(AppRoutes.mySubscription);
        } else {
          Get.offAllNamed(AppRoutes.navBarScreen);
        }

        /// clear
        emailController.clear();

        passwordController.clear();

        AppSnackbar.success(
          title: 'Success',
          message: response.message,
        );
      } else {
        if (response.statusCode == 403 && response.message.contains("verify your account")) {
          // Trigger Resend OTP
          await apiClient.post(
            ApiEndPoint.resendOtp,
            body: {'email': emailController.text.trim()},
          );
          
          // Navigate to Verify Email Screen
          Get.toNamed(
            AppRoutes.verifyEmail, 
            arguments: {
              'isSignUp': true, 
              'email': emailController.text.trim()
            }
          );
          
          AppSnackbar.success(
            title: 'Verification Required',
            message: 'OTP has been sent to your email. Please verify first.',
          );
          return;
        }

        AppSnackbar.error(
          title: 'Error',
          message: response.message,
        );
      }
    }

    catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      update();
    }

  }

  @override
  void onClose() {
    // emailController.dispose(); // Commenting these out to avoid "used after disposed" error on rapid logout/login transitions
    // passwordController.dispose();
    super.onClose();
  }
}
