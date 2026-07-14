import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/features/fixtures/presentation/screen/fixtures_screen.dart';
import 'package:untitled/features/home/presentation/screens/home_screen.dart';
import 'package:untitled/features/league_tables/presentation/screen/league_tables_screen.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import '../../eng_tv_flow/presentation/screen/eng_tv_screen.dart';
import '../../stats_flow/presentation/screen/stats_screen.dart';

class NavBarController extends GetxController {
  final selectedIndex = 0.obs;

  int get currentIndex => selectedIndex.value;

  void changeIndex(int index) {
    if (index >= 0 && index < screens.length) {
      selectedIndex.value = index;
    }
  }

  final List<Widget> screens = [
    HomeScreen(),
    FixturesScreen(),
    LeagueTablesScreen(fromBottomNav: true),

    EngTvScreen(),
    StatsScreen(),
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
