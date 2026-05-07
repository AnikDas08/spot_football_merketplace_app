import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:untitled/features/auth/sign%20up/presentation/controller/player_registatio_controller.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_snackbar.dart';
import '../../../../../utils/helpers/other_helper.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find<SignUpController>();

  final PlayerRegistrationController _playerRegistrationController = Get.find<PlayerRegistrationController>();
  final ApiClient apiClient = DioApiClient();

  bool isLoading = false;
  bool isLoadingVerify = false;
  String selectRole = 'User';
  String countryCode = '+880';
  String? image;
  Timer? _timer;
  int _seconds = 0;

  /// Form controllers
  final nameController = TextEditingController(text: kDebugMode ? "Ajijul Islam" : null);
  final emailController = TextEditingController(text: kDebugMode ? "rodefe4817@cadinr.com" : null);
  final passwordController = TextEditingController(text: kDebugMode ? "Aaaa@#+11" : null);
  final confirmPasswordController = TextEditingController(text: kDebugMode ? "Aaaa@#+11" : null);
  final otpController = TextEditingController(text: kDebugMode ? "123456" : null);

  /// Get formatted timer text (mm:ss)
  String get time {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Change selected country
  void onCountryChange(Country value) {
    countryCode = value.dialCode;
  }

  /// Change role
  void setSelectedRole(String value) {
    selectRole = value;
    update();
  }

  /// Pick image from gallery
  Future<void> openGallery() async {
    image = await OtherHelper.pickImage();
    update();
  }

  /// Set loading state
  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  /// Navigate to Role Selection
  void goToRoleSelection() {
    Get.toNamed(AppRoutes.role_select_screen);
  }

  /// Sign up user API call
  Future<void> signUpUser() async {
    try {
      _setLoading(true);

      final body = {
        'userName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'role': selectRole.toUpperCase(),
      };

      final response = await apiClient.post(ApiEndPoint.signUp, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSnackbar.success(title: 'Success', message: response.message);
        startTimer();
        Get.toNamed(AppRoutes.verifyEmail, arguments: {'isSignUp': true});
      } else {
        AppSnackbar.error(
          title: 'Error',
          message: response.message,
        );
      }
    } catch (e) {
      debugPrint('❌ signUpUser error: $e');
      AppSnackbar.error(title: 'Error', message: 'Registration failed.');
    } finally {
      _setLoading(false);
    }
  }

  /// Start OTP countdown timer (3 minutes)
  void startTimer() {
    _timer?.cancel();
    _seconds = 180;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        return;
      }
      _seconds--;
      update();
    });
  }

  /// Verify OTP API call
  Future<void> verifyOtp() async {
    try {
      _setLoading(true);
      final body = {
        'email': emailController.text.trim(),
        'oneTimeCode': int.tryParse(otpController.text.trim()) ?? 0,
      };
      
      final response = await apiClient.post(
        ApiEndPoint.verifyEmail,
        body: body,
      );

      if (response.statusCode == 200) {
        final String token = response.data['data'] ?? '';
        await LocalStorage.setString(LocalStorageKeys.token, token);
        
        AppSnackbar.success(title: 'Success', message: response.message);
        
        if (selectRole.toUpperCase() == 'PLAYER') {
          Get.offAllNamed(AppRoutes.verify_player_screen);
        } else {
          Get.offAllNamed(AppRoutes.signIn);
        }
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint('❌ verifyOtp error: $e');
      AppSnackbar.error(title: 'Error', message: 'OTP verification failed.');
    } finally {
      _setLoading(false);
    }
  }

  /// Resend OTP API call
  Future<void> resendOtp() async {
    try {
      final response = await apiClient.post(
        ApiEndPoint.resendOtp,
        body: {'email': emailController.text.trim()},
      );
      if (response.statusCode == 200) {
        AppSnackbar.success(title: 'Success', message: response.message);
        startTimer();
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint('❌ resendOtp error: $e');
      AppSnackbar.error(title: 'Error', message: 'Failed to resend OTP.');
    }
  }

  /// Dispose controllers & timer
  @override
  void onClose() {
    _timer?.cancel();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
