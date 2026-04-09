import 'package:get/get.dart';

class ShopController extends GetxController {

  static ShopController get to => Get.find();

  int selectedTab = 0;

  void changeTab(int index){
    selectedTab = index;
    update();
  }

}