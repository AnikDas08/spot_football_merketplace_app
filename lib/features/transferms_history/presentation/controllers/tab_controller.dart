import 'package:get/get.dart';

class TabController extends GetxController {

  static TabController get to => Get.find();

  int selectedTab = 0;

  void changeTab(int index) {
    selectedTab = index;
    update();
  }
}