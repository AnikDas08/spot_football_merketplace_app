import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../utils/app_snackbar.dart';
import '../../../../../utils/enum/enum.dart';

class ForgetPasswordController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    setValue();
  }

  static ForgetPasswordController get instance =>
      Get.find<ForgetPasswordController>();
  final ApiClient apiClient = DioApiClient();

  void setValue() {
    if (!kDebugMode) return;
    emailController.text = 'mesoso4279@gixpos.com';
  }

  bool isLoading = false;
  ForgetPasswordStep currentStep = ForgetPasswordStep.email;
  String forgetPasswordToken = '';
  static const int _otpDurationSeconds = 180;
  int remainingSeconds = 0;
  Timer? _timer;
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool get canResendOtp => remainingSeconds == 0;
  int _seconds = 0;


  /// ===================== TIMER =====================
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

  String get time {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// ===================== Forget Password Repo =====================
  Future<void> sendForgetPasswordEmail() async {
    try {
      _setLoading(true);
      final response = await apiClient.post(
        ApiEndPoint.forgotPassword,
        body: {'email': emailController.text.trim()},
      );
      if (response.statusCode == 200) {
        AppSnackbar.success(title: 'Success', message: response.message);
        currentStep = ForgetPasswordStep.otp;
        startTimer();
        Get.toNamed(AppRoutes.verifyEmail);
      } else {
        AppSnackbar.error(
          title: response.statusCode.toString(),
          message: response.message,
        );
      }
    } catch (e, s) {
      debugPrint('❌ sendForgetPasswordEmail error: $e');
      debugPrintStack(stackTrace: s);
      AppSnackbar.error(
        title: 'Error',
        message: 'Failed to send verification email. Please try again.',
      );
    } finally {
      _setLoading(false);
    }
  }

  /// ===================== VERIFY OTP Repo =====================
  Future<void> verifyOtp() async {
    try {
      _setLoading(true);
      final response = await apiClient.post(
        ApiEndPoint.verifyOtp,
        body: {
          'email': emailController.text.trim(),
          'oneTimeCode': int.tryParse(otpController.text.trim()) ?? 0,
        },
      );

      if (response.statusCode == 200) {
        forgetPasswordToken = response.data['data'] ?? '';

        currentStep = ForgetPasswordStep.resetPassword;
        Get.toNamed(AppRoutes.createPassword);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e, s) {
      debugPrint('❌ verifyOtp error: $e');
      debugPrintStack(stackTrace: s);
      AppSnackbar.error(title: 'Error', message: 'OTP verification failed.');
    } finally {
      _setLoading(false);
    }
  }

  /// ===================== RESET PASSWORD Repo =====================
  Future<void> resetPassword() async {
    try {
      _setLoading(true);
      final response = await apiClient.post(
        ApiEndPoint.resetPassword,
        headers: {'Authorization': 'Bearer $forgetPasswordToken'},
        body: {
          'newPassword': passwordController.text.trim(),
          'confirmPassword': confirmPasswordController.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        AppSnackbar.success(title: 'Success', message: response.message);
        _clearAll();
        Get.offAllNamed(AppRoutes.signIn);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e, s) {
      debugPrint('❌ resetPassword error: $e');
      debugPrintStack(stackTrace: s);
      AppSnackbar.error(title: 'Error', message: 'Password reset failed.');
    } finally {
      _setLoading(false);
    }
  }

  /// ===================== RESEND OTP Repo =====================
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

  /// ===================== HELPERS =====================
  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  void _clearAll() {
    emailController.clear();
    otpController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _timer?.cancel();
    remainingSeconds = 0;
  }

  @override
  void onClose() {
    _timer?.cancel();
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
