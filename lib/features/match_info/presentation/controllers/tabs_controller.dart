import 'package:get/get.dart';

class TabsController extends GetxController {
  RxInt selectedTab = 0.obs;

  final List<String> tabs = ['Overview', 'Lineups', 'Related'];
}
