import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import '../../../utils/constants/app_images.dart';
import '../../profile/presentation/screen/profile_screen.dart';

class NavBarController extends GetxController {
  final selectedIndex = 1.obs;

  int get currentIndex => selectedIndex.value;

  void changeIndex(int index) {
    if (index >= 0 && index < screens.length) {
      selectedIndex.value = index;
    }
  }

  final List<Widget> screens = [
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  final List<String> labels = const [
    'Lastest',
    'Fixtures',
    'TRANSFERS',
    "ENG TV",
    "Stats",
  ];

  final List<String> activeIcons = [
    AppIcons.homeActive,
    AppImages.profile,
    AppImages.profile,
    AppImages.profile,
    AppImages.profile,
  ];

  final List<String> inActiveIcons = [
    AppIcons.homeInActive,
    AppIcons.fixturesInActive,
    AppIcons.transfersInActive,
    AppIcons.engTvInActive,
    AppIcons.statsInactive,
  ];
}
