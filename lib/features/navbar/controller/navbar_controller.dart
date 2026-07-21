import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_icons.dart';
import '../../../utils/constants/app_string.dart';
import '../../eng_tv_flow/presentation/screen/eng_tv_screen.dart';
import '../../fixtures/presentation/screen/fixtures_screen.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../league_tables/presentation/screen/league_tables_screen.dart';
import '../../stats_flow/presentation/screen/stats_screen.dart';

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;
  final isDrawerOpen = false.obs;

  int get currentIndex => selectedIndex.value;

  void changeIndex(int index) {
    if (index >= 0 && index < screens.length) {
      selectedIndex.value = index;
    }
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const FixturesScreen(),
    const LeagueTablesScreen(fromBottomNav: true),
    const EngTvScreen(),
    StatsScreen(),
  ];

  final List<String> titles = [
    AppString.community,
    AppString.fixture,
    'LEAGUE TABLES',
    "ENG TV",
    'STATS',
  ];

  final List<String> labels = const [
    'Lastest',
    'Fixtures',
    'Leagues',
    "ENG TV",
    "Stats"
  ];

  final List<String> activeIcons = [
    AppIcons.homeInActive,
    AppIcons.fixturesInActive,
    AppIcons.league,
    AppIcons.engTvInActive,
    AppIcons.statsInactive,
  ];

  final List<String> inActiveIcons = [
    AppIcons.homeInActive,
    AppIcons.fixturesInActive,
    AppIcons.league,
    AppIcons.engTvInActive,
    AppIcons.statsInactive,
  ];
}
