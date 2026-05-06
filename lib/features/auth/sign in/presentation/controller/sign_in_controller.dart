import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:untitled/utils/app_snackbar.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_client.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../profile/presentation/controller/profile_controller.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// email and password Controller here
  final emailController = TextEditingController(text: kDebugMode ? "mesoso4279@gixpos.com" : null);
  final passwordController = TextEditingController(text: kDebugMode ? "Aaaa@#+1" : null);

  final ApiClient apiClient = DioApiClient();

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
        final Map<String, dynamic> data = response.data['data'] ?? '';
        final userData = Jwt.parseJwt(data["accessToken"]);
        await LocalStorage.setString(LocalStorageKeys.token, data["accessToken"]);
        await LocalStorage.setString(LocalStorageKeys.refreshToken, data["refreshToken"]);
        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);


        // Fetch profile data immediately after login
        await Get.find<ProfileController>().getProfileData();

        print(userData);

        /// clear
        emailController.clear();
        passwordController.clear();

        /// navigate
        Get.offAllNamed(AppRoutes.navBarScreen);
        AppSnackbar.success(
          title: response.statusCode.toString(),
          message: response.message,
        );
      } else {
        AppSnackbar.error(
          title: response.statusCode.toString(),
          message: response.message,
        );
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
