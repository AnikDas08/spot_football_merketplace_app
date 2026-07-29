import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';

class StatsController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  var selectedAge = "".obs; // This will hold the league name
  var isLoading = false.obs;
  var summaryData = Rxn<Map<String, dynamic>>();

  // Paginated Leagues
  final RxList<dynamic> leaguesList = <dynamic>[].obs;
  var isLeaguesLoading = false.obs;
  var isMoreLeaguesLoading = false.obs;
  int leaguePage = 1;
  bool hasMoreLeagues = true;
  String leagueSearch = "";

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    await fetchLeagues();
    if (leaguesList.isNotEmpty) {
      if (selectedAge.value.isEmpty) {
        selectedAge.value = leaguesList.first['leagueName'] ?? "";
      }
      fetchLeagueSummary();
    }
  }

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
        headers: LocalStorage.token.isNotEmpty 
            ? {'Authorization': 'Bearer ${LocalStorage.token}'} 
            : null,
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
      debugPrint('⚠️ fetchLeagues error: $e');
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

  void updateAge(String value) {
    selectedAge.value = value;
    fetchLeagueSummary();
  }

  Future<void> fetchLeagueSummary() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(
        "${ApiEndPoint.leagueSummary}?leagueName=${Uri.encodeComponent(selectedAge.value)}",
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        summaryData.value = response.data['data'];
      }
    } catch (e) {
      debugPrint('❌ fetchLeagueSummary error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
