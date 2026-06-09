import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/services/api/api_client.dart';
import 'package:untitled/services/api/api_service.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/app_snackbar.dart';

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
          role = "Club";
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
    }
  }
}
