// features/fixtures/presentation/controller/fixtures_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../home/data/match_model.dart';

class FixturesController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  var isLoading = false.obs;

  // ── Tab (Status & Date Filtering) ──
  int selectedTab = 0;
  final List<String> tabs = ['All', 'Today', 'Upcoming', 'Live', 'Finished', 'Cancelled'];

  // ── Filter Sheet ──
  var filterTab = 0.obs; // 0 = All, 1 = Specific
  var selectedLeague = RxnString();
  var selectedTeam = RxnString();
  int dateRangeTab = 0; // 0 = All, 1 = Today, 2 = This Month
  DateTime focusedMonth = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  // ── Data ──
  List<MatchModel> allMatches = [];
  List<MatchModel> filteredFixtures = [];

  // ── Paginated Leagues ──
  final RxList<dynamic> leaguesList = <dynamic>[].obs;
  var isLeaguesLoading = false.obs;
  var isMoreLeaguesLoading = false.obs;
  int leaguePage = 1;
  bool hasMoreLeagues = true;
  String leagueSearch = "";

  // ── Paginated Teams ──
  final RxList<dynamic> teamsList = <dynamic>[].obs;
  var isTeamsLoading = false.obs;
  var isMoreTeamsLoading = false.obs;
  int teamPage = 1;
  bool hasMoreTeams = true;
  String teamSearch = "";

  @override
  void onInit() {
    super.onInit();
    fetchMatches();
    fetchLeagues();
    fetchTeams();
  }

  // ── Leagues Fetching ──
  Future<void> fetchLeagues({bool isLoadMore = false, String? search}) async {
    if (isLoadMore && !hasMoreLeagues) return;
    
    try {
      if (isLoadMore) {
        isMoreLeaguesLoading.value = true;
      } else {
        isLeaguesLoading.value = true;
        leaguePage = 1;
        leaguesList.clear();
      }
      update();

      if (search != null) leagueSearch = search;
      
      String url = "${ApiEndPoint.leagues}?page=$leaguePage&limit=10";
      if (leagueSearch.isNotEmpty) url += "&searchTerm=$leagueSearch";

      final response = await apiClient.get(
        url,
        headers: LocalStorage.token.isNotEmpty ? {'Authorization': 'Bearer ${LocalStorage.token}'} : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final pagination = response.data['pagination'];
        
        if (isLoadMore) {
          leaguesList.addAll(data);
        } else {
          leaguesList.assignAll(data);
        }

        if (pagination != null) {
          int totalPage = pagination['totalPage'] ?? 1;
          hasMoreLeagues = leaguePage < totalPage;
        } else {
          hasMoreLeagues = false;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchLeagues error: $e');
    } finally {
      isLeaguesLoading.value = false;
      isMoreLeaguesLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreLeagues() async {
    if (!isMoreLeaguesLoading.value && hasMoreLeagues) {
      leaguePage++;
      await fetchLeagues(isLoadMore: true);
    }
  }

  // ── Teams Fetching ──
  Future<void> fetchTeams({bool isLoadMore = false, String? search}) async {
    if (isLoadMore && !hasMoreTeams) return;

    try {
      if (isLoadMore) {
        isMoreTeamsLoading.value = true;
      } else {
        isTeamsLoading.value = true;
        teamPage = 1;
        teamsList.clear();
      }
      update();

      if (search != null) teamSearch = search;

      String url = "${ApiEndPoint.teams}?page=$teamPage&limit=10";
      if (teamSearch.isNotEmpty) url += "&searchTerm=$teamSearch";

      final response = await apiClient.get(
        url,
        headers: LocalStorage.token.isNotEmpty ? {'Authorization': 'Bearer ${LocalStorage.token}'} : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        final pagination = response.data['pagination'];

        if (isLoadMore) {
          teamsList.addAll(data);
        } else {
          teamsList.assignAll(data);
        }

        if (pagination != null) {
          int totalPage = pagination['totalPage'] ?? 1;
          hasMoreTeams = teamPage < totalPage;
        } else {
          hasMoreTeams = false;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchTeams error: $e');
    } finally {
      isTeamsLoading.value = false;
      isMoreTeamsLoading.value = false;
      update();
    }
  }

  Future<void> loadMoreTeams() async {
    if (!isMoreTeamsLoading.value && hasMoreTeams) {
      teamPage++;
      await fetchTeams(isLoadMore: true);
    }
  }

  // ── Matches Fetching ──
  Future<void> fetchMatches({String? leagueName, String? teamName}) async {
    try {
      isLoading.value = true;
      update();

      String url = ApiEndPoint.match;
      Map<String, String> queryParams = {};
      if (leagueName != null && leagueName.isNotEmpty) queryParams['leagueName'] = leagueName;
      if (teamName != null && teamName.isNotEmpty) queryParams['teamName'] = teamName;

      final response = await apiClient.get(url, query: queryParams.isNotEmpty ? queryParams : null);

      if (response.statusCode == 200) {
        final matchResponse = MatchResponse.fromJson(response.data);
        allMatches = matchResponse.data;
        _applyLocalTabFilters();
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
    _applyLocalTabFilters();
    update();
  }

  // ── Filter Sheet Methods ──
  void selectFilterTab(int index) {
    filterTab.value = index;
    if (index == 0) {
      selectedLeague.value = null;
      selectedTeam.value = null;
    }
    update();
  }

  void selectLeague(String? league) {
    selectedLeague.value = league;
    update();
  }

  void selectTeam(String? team) {
    selectedTeam.value = team;
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

  Future<void> applyFilters() async {
    await fetchMatches(
      leagueName: filterTab.value == 1 ? selectedLeague.value : null,
      teamName: filterTab.value == 1 ? selectedTeam.value : null,
    );
    Get.back();
  }

  void _applyLocalTabFilters() {
    List<MatchModel> results = List.from(allMatches);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (selectedTab == 1) { // Today Tab
      results = results.where((m) => _isSameDay(m.matchDate, today)).toList();
    } else if (selectedTab > 1) { // Status Tabs (Upcoming, Live, etc.)
      final status = tabs[selectedTab].toLowerCase();
      results = results.where((m) => m.status.toLowerCase() == status).toList();
    }

    if (startDate != null) {
      if (endDate == null) {
        results = results.where((m) => _isSameDay(m.matchDate, startDate!)).toList();
      } else {
        results = results.where((m) => _isInRange(m.matchDate, startDate!, endDate!)).toList();
      }
    } else {
      if (dateRangeTab == 1) { // Today
         results = results.where((m) => _isSameDay(m.matchDate, today)).toList();
      } else if (dateRangeTab == 2) { // This Month
        results = results.where((m) => _isThisMonth(m.matchDate)).toList();
      }
    }

    filteredFixtures = results;
    update();
  }

  void resetFilters() {
    filterTab.value = 0;
    selectedLeague.value = null;
    selectedTeam.value = null;
    dateRangeTab = 0;
    startDate = null;
    endDate = null;
    focusedMonth = DateTime.now();
    fetchMatches();
    update();
  }

  bool _isSameDay(DateTime? d1, DateTime d2) {
    if (d1 == null) return false;
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  bool _isInRange(DateTime? date, DateTime start, DateTime end) {
    if (date == null) return false;
    final d = DateTime(date.year, date.month, date.day);
    final s = DateTime(start.year, start.month, start.day);
    final e = DateTime(end.year, end.month, end.day);
    return (d.isAtSameMomentAs(s) || d.isAfter(s)) && (d.isAtSameMomentAs(e) || d.isBefore(e));
  }

  bool _isThisMonth(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }
}
