import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../component/screen/webview_screen.dart';

class PackageModel {
  String? id;
  String? title;
  String? description;
  String? userType;
  int? price;
  String? duration;
  String? paymentType;
  String? stripeProductId;
  String? stripePriceId;
  int? credit;
  int? loginLimit;
  String? paymentLink;
  String? status;

  PackageModel({
    this.id,
    this.title,
    this.description,
    this.userType,
    this.price,
    this.duration,
    this.paymentType,
    this.stripeProductId,
    this.stripePriceId,
    this.credit,
    this.loginLimit,
    this.paymentLink,
    this.status,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    userType = json['userType'];
    price = json['price'];
    duration = json['duration'];
    paymentType = json['paymentType'];
    stripeProductId = json['stripeProductId'];
    stripePriceId = json['stripePriceId'];
    credit = json['credit'];
    loginLimit = json['loginLimit'];
    paymentLink = json['paymentLink'];
    status = json['status'];
  }
}

class SubscriptionController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var packages = <PackageModel>[].obs;
  var isLoading = false.obs;
  var isCheckingOut = false.obs;
  var selectedPackage = Rx<PackageModel?>(null);
  var isChangingPlan = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }

  void toggleChangingPlan(bool value) {
    isChangingPlan.value = value;
  }

  void selectPackage(PackageModel package) {
    selectedPackage.value = package;
  }

  Future<void> fetchPackages() async {
    try {
      isLoading.value = true;
      update();

      // Get role and token from arguments if available (registration flow)
      // Fallback to LocalStorage for logged-in users
      String role = Get.arguments?['role'] ?? LocalStorage.role;
      final String? token = Get.arguments?['token'];

      if (role.isEmpty) {
        // Try to decode role from token if available
        if (token != null) {
          try {
            final decodedToken = Jwt.parseJwt(token);
            role = decodedToken['role'] ?? "";
          } catch (e) {
            debugPrint("Error decoding token for role: $e");
          }
        }
      }

      if (role.isNotEmpty) {
        if (role == "OTHER_CLUBS") {
          role = "Other";
        } else {
          role = role[0].toUpperCase() + role.substring(1).toLowerCase();
        }
      }

      final Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await apiClient.get(
        "${ApiEndPoint.packages}?userType=$role",
        headers: headers.isNotEmpty ? headers : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        packages.value = data.map((e) => PackageModel.fromJson(e)).toList();
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> generateCheckoutUrl({
    required String packageId,
    required bool isFromRegistration,
    required dynamic profileController,
  }) async {
    try {
      isCheckingOut.value = true;
      update();

      final String? token = Get.arguments?['token'] ?? LocalStorage.token;
      final Map<String, String> headers = {};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await apiClient.get(
        "${ApiEndPoint.packages}/$packageId/checkout",
        headers: headers.isNotEmpty ? headers : null,
      );

      if (response.statusCode == 200) {
        final String? checkoutUrl = response.data['data']?['checkoutUrl'];

        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          Get.to(
            () => WebViewScreen(
              url: checkoutUrl,
              title: "Payment",
              onPaymentSuccess: () async {
                if (isFromRegistration) {
                  Get.offAllNamed(AppRoutes.signIn);
                  AppSnackbar.success(
                    title: "Success",
                    message: "Payment successful! Please sign in.",
                  );
                } else {
                  await LocalStorage.setBool(LocalStorageKeys.paymentStatus, true);
                  await profileController.getProfileData();
                  toggleChangingPlan(false);
                  Get.offAllNamed(AppRoutes.navBarScreen);
                  AppSnackbar.success(
                    title: "Success",
                    message: "Payment successful! Welcome back.",
                  );
                }
              },
            ),
          );
        } else {
          AppSnackbar.error(title: 'Error', message: 'Checkout URL not found.');
        }
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isCheckingOut.value = false;
      update();
    }
  }
}
