import 'package:get/get.dart';

class StatsController extends GetxController {
  var selectedAge = "12".obs;

  final List<String> ageOptions = ["10", "12", "14", "16", "18"];

  void updateAge(String value) {
    selectedAge.value = value;
  }
}