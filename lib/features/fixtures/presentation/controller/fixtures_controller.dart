// features/fixtures/presentation/controller/fixtures_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../home/data/match_model.dart';

class FixturesController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;

  // ── Tab (Status & Date Filtering) ──
  int selectedTab = 0;
  final List<String> tabs = ['All', 'Today', 'Upcoming', 'Live', 'Finished', 'Cancelled'];

  // ── Filter Sheet ──
  int teamTab = 0; // 0 = All Teams, 1 = Specific
  String? selectedTeam;
  int dateRangeTab = 0; // 0 = All, 1 = Today, 2 = This Month
  DateTime focusedMonth = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  // ── Fixtures ──
  List<MatchModel> allMatches = [];
  List<MatchModel> filteredFixtures = [];

  List<String> teams = [];

  @override
  void onInit() {
    super.onInit();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.match);

      if (response.statusCode == 200) {
        final matchResponse = MatchResponse.fromJson(response.data);
        allMatches = matchResponse.data;
        
        // Extract unique teams
        final teamSet = <String>{};
        for (var match in allMatches) {
          teamSet.add(match.homeTeam.teamName);
          teamSet.add(match.awayTeam.teamName);
        }
        teams = teamSet.toList()..sort();
        
        applyFilters(isFromSheet: false);
      }
    } catch (e) {
      debugPrint('❌ fetchMatches error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void selectTab(int index) {
    selectedTab = index;
    applyFilters(isFromSheet: false);
    update();
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
    startDate = null;
    endDate = null;
    update();
  }

  void selectCalendarDate(DateTime date) {
    if (startDate == null || (startDate != null && endDate != null)) {
      startDate = date;
      endDate = null;
    } else if (date.isBefore(startDate!)) {
      startDate = date;
      endDate = null;
    } else if (date.isAtSameMomentAs(startDate!)) {
      startDate = null;
      endDate = null;
    } else {
      endDate = date;
    }
    
    // When a date is picked, we deselect the general chips
    dateRangeTab = -1; 
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

  void applyFilters({bool isFromSheet = true}) {
    List<MatchModel> results = List.from(allMatches);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 1. Apply Status/Special Tab Filter (Top Tabs)
    if (selectedTab == 1) { // Today Tab
      results = results.where((m) => _isSameDay(m.matchDate, today)).toList();
    } else if (selectedTab > 1) { // Status Tabs (Upcoming, Live, etc.)
      final status = tabs[selectedTab].toLowerCase();
      results = results.where((m) => m.status.toLowerCase() == status).toList();
    }

    // 2. Apply Team Filter (From Sheet)
    if (teamTab == 1 && selectedTeam != null) {
      results = results.where((m) => 
        m.homeTeam.teamName == selectedTeam || m.awayTeam.teamName == selectedTeam
      ).toList();
    }

    // 3. Apply Date Filter (From Sheet)
    if (startDate != null) {
      if (endDate == null) {
        // Only one date selected, treat as single day
        results = results.where((m) => _isSameDay(m.matchDate, startDate!)).toList();
      } else {
        // Range selected
        results = results.where((m) => _isInRange(m.matchDate, startDate!, endDate!)).toList();
      }
    } else {
      if (dateRangeTab == 1) { // Today
         results = results.where((m) => _isSameDay(m.matchDate, today)).toList();
      } else if (dateRangeTab == 2) { // This Month
        results = results.where((m) => _isThisMonth(m.matchDate)).toList();
      }
      // Note: dateRangeTab == 0 (All) requires no additional filtering
    }

    filteredFixtures = results;
    if (isFromSheet) {
      Get.back();
    }
    update();
  }

  void resetFilters() {
    teamTab = 0;
    selectedTeam = null;
    dateRangeTab = 0;
    startDate = null;
    endDate = null;
    focusedMonth = DateTime.now();
    applyFilters(isFromSheet: false);
    update();
  }

  bool _isSameDay(DateTime? d1, DateTime d2) {
    if (d1 == null) return false;
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  bool _isInRange(DateTime? date, DateTime start, DateTime end) {
    if (date == null) return false;
    // Normalize to date only (midnight)
    final d = DateTime(date.year, date.month, date.day);
    final s = DateTime(start.year, start.month, start.day);
    final e = DateTime(end.year, end.month, end.day);
    
    return (d.isAtSameMomentAs(s) || d.isAfter(s)) && 
           (d.isAtSameMomentAs(e) || d.isBefore(e));
  }

  bool _isThisMonth(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }
}
