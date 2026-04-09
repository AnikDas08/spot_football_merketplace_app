// features/fixtures/presentation/controller/fixtures_controller.dart

import 'package:get/get.dart';
import '../../data/model/fixture_model.dart';

class FixturesController extends GetxController {
  // ── Tab (All / Today / Upcoming) ──
  int selectedTab = 0;
  final List<String> tabs = ['All', 'Today', 'Upcoming'];

  // ── Filter Sheet ──
  int teamTab = 0; // 0 = All Teams, 1 = Specific
  String? selectedTeam;
  int dateRangeTab = 0; // 0 = Today, 1 = This Week, 2 = This Month
  DateTime focusedMonth = DateTime(2023, 3);
  DateTime? selectedDate;

  // ── Fixtures ──
  List<FixtureModel> allFixtures = _dummyFixtures();
  List<FixtureModel> filteredFixtures = [];

  final List<String> teams = ['Titans SC', 'Vortex FC', 'Storm FC', 'Eagle FC'];

  @override
  void onInit() {
    super.onInit();
    filteredFixtures = List.from(allFixtures);
  }

  void selectTab(int index) {
    selectedTab = index;
    _applyMainFilter();
    update();
  }

  void _applyMainFilter() {
    final now = DateTime.now();
    if (selectedTab == 0) {
      filteredFixtures = List.from(allFixtures);
    } else if (selectedTab == 1) {
      filteredFixtures = allFixtures
          .where((f) => f.groupLabel == 'TONIGHT')
          .toList();
    } else {
      filteredFixtures = allFixtures
          .where((f) => f.groupLabel == 'TOMORROW')
          .toList();
    }
  }

  // ── Filter Sheet Methods ──
  void selectTeamTab(int index) {
    teamTab = index;
    if (index == 0) selectedTeam = null;
    update();
  }

  void selectTeam(String? team) {
    selectedTeam = team;
    update();
  }

  void selectDateRangeTab(int index) {
    dateRangeTab = index;
    selectedDate = null;
    update();
  }

  void selectCalendarDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void previousMonth() {
    focusedMonth = DateTime(focusedMonth.year, focusedMonth.month - 1);
    update();
  }

  void nextMonth() {
    focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + 1);
    update();
  }

  void applyFilters() {
    filteredFixtures = allFixtures.where((f) {
      if (teamTab == 1 && selectedTeam != null) {
        if (f.homeTeam != selectedTeam && f.awayTeam != selectedTeam)
          return false;
      }
      return true;
    }).toList();
    Get.back();
    update();
  }

  void resetFilters() {
    teamTab = 0;
    selectedTeam = null;
    dateRangeTab = 0;
    selectedDate = null;
    focusedMonth = DateTime(2023, 3);
    filteredFixtures = List.from(allFixtures);
    update();
  }

  // ── Grouped fixtures ──
  Map<String, List<FixtureModel>> get groupedFixtures {
    final Map<String, List<FixtureModel>> map = {};
    for (final f in filteredFixtures) {
      map.putIfAbsent(f.date, () => []).add(f);
    }
    return map;
  }

  String groupSubLabel(String date) {
    final items = allFixtures.where((f) => f.date == date);
    return items.isNotEmpty ? items.first.groupLabel : '';
  }
}

List<FixtureModel> _dummyFixtures() => [
  FixtureModel(
    id: '1',
    date: 'OCT 24',
    time: '20:00 PM',
    homeTeam: 'TITANS SC',
    awayTeam: 'VORTEX FC',
    groupLabel: 'TONIGHT',
  ),
  FixtureModel(
    id: '2',
    date: 'OCT 24',
    time: '21:00 PM',
    homeTeam: 'TITANS SC',
    awayTeam: 'VORTEX FC',
    groupLabel: 'TONIGHT',
  ),
  FixtureModel(
    id: '3',
    date: 'OCT 24',
    time: '21:30 PM',
    homeTeam: 'TITANS SC',
    awayTeam: 'VORTEX FC',
    groupLabel: 'TONIGHT',
  ),
  FixtureModel(
    id: '4',
    date: 'OCT 25',
    time: '20:00 PM',
    homeTeam: 'TITANS SC',
    awayTeam: 'VORTEX FC',
    groupLabel: 'TOMORROW',
  ),
  FixtureModel(
    id: '5',
    date: 'OCT 25',
    time: '21:00 PM',
    homeTeam: 'TITANS SC',
    awayTeam: 'VORTEX FC',
    groupLabel: 'TOMORROW',
  ),
];
