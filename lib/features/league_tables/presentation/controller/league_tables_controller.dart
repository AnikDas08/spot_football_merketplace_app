import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../home/data/point_table_model.dart';

class LeagueTablesController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  final ScrollController scrollController = ScrollController();

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var isLeaguesLoading = false.obs;

  final RxList<LeagueData> allLeagues = <LeagueData>[].obs;
  final RxList<dynamic> leaguesList = <dynamic>[].obs; // For the selection sheet

  var selectedLeagueId = "".obs;
  var selectedLeagueName = AppString.all.obs;
  var selectedYear = DateTime.now().year.toString().obs;

  int currentPage = 1;
  bool hasNextPage = true;

  @override
  void onInit() {
    super.onInit();
    fetchPointTable();
    fetchLeagues();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && !isMoreLoading.value && hasNextPage) {
        loadMore();
      }
    }
  }

  Future<void> fetchPointTable({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        allLeagues.clear();
      }
      update();

      String url = "${ApiEndPoint.pointTable}?page=$currentPage&limit=5";
      if (selectedLeagueName.value != AppString.all && selectedLeagueId.value.isNotEmpty) {
        url += "&leagueId=${selectedLeagueId.value}";
      }
      url += "&season=${selectedYear.value}";

      final response = await apiClient.get(url);

      if (response.statusCode == 200) {
        final pointTableResponse = PointTableResponse.fromJson(response.data);
        final List<LeagueData> newData = pointTableResponse.data;

        if (isLoadMore) {
          allLeagues.addAll(newData);
        } else {
          allLeagues.assignAll(newData);
        }

        // Handle pagination from response if available, otherwise guess based on length
        // Assuming backend might not have standard pagination for point-table yet, 
        // but we prepare the logic.
        if (response.data['pagination'] != null) {
          int totalPage = response.data['pagination']['totalPage'] ?? 1;
          hasNextPage = currentPage < totalPage;
        } else {
          hasNextPage = newData.isNotEmpty && newData.length >= 5;
        }
      }
    } catch (e) {
      debugPrint('❌ fetchPointTable error: $e');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> fetchLeagues() async {
    try {
      isLeaguesLoading.value = true;
      final response = await apiClient.get("${ApiEndPoint.leagues}?limit=100");
      if (response.statusCode == 200) {
        leaguesList.assignAll(response.data['data'] ?? []);
      }
    } catch (e) {
      debugPrint('❌ fetchLeagues error: $e');
    } finally {
      isLeaguesLoading.value = false;
    }
  }

  void loadMore() {
    currentPage++;
    fetchPointTable(isLoadMore: true);
  }

  void selectLeague(String id, String name) {
    selectedLeagueId.value = id;
    selectedLeagueName.value = name;
    fetchPointTable();
  }

  void selectYear(String year) {
    selectedYear.value = year;
    fetchPointTable();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
