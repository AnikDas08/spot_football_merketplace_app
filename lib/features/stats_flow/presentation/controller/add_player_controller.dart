import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../model/player_model.dart';

class AddPlayerController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  final RxList<PlayerModel> playerList = <PlayerModel>[].obs;
  final RxList<PlayerModel> filteredPlayerList = <PlayerModel>[].obs;
  final RxList<Map<String, dynamic>> clubList = <Map<String, dynamic>>[].obs;
  
  var isLoading = false.obs; 
  var isMoreLoading = false.obs;
  var isClubsLoading = false.obs; 

  var selectedClubId = "".obs;
  var selectedClubName = "All Clubs".obs;
  var selectedPosition = "All Positions".obs;

  int currentPage = 1;
  bool hasNextPage = true;

  final List<String> positions = ["All Positions", "Goalkeeper", "Defender", "Midfielder", "Forward"];

  @override
  void onInit() {
    super.onInit();
    fetchClubs();
    fetchFilteredPlayers();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && !isMoreLoading.value && hasNextPage) {
        loadMorePlayers();
      }
    }
  }

  Future<void> fetchClubs() async {
    try {
      isClubsLoading.value = true;
      final response = await apiClient.get(ApiEndPoint.teams);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        clubList.value = data.map((e) => {
          'id': e['_id'],
          'name': e['teamName'],
        }).toList();
      }
    } catch (e) {
      debugPrint("Error fetching clubs: $e");
    } finally {
      isClubsLoading.value = false;
    }
  }

  Future<void> fetchFilteredPlayers({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isMoreLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage = 1;
        playerList.clear();
      }
      update();

      String url = "${ApiEndPoint.playerFilter}?page=$currentPage&limit=20";
      if (selectedClubId.value.isNotEmpty) {
        url += "&team=${selectedClubId.value}";
      }
      if (selectedPosition.value != "All Positions") {
        url += "&position=${selectedPosition.value}";
      }

      final response = await apiClient.get(url);

      if (response.statusCode == 200) {
        final dynamic responseData = response.data['data'];
        List<dynamic> data = [];
        
        if (responseData is List) {
          data = responseData;
          hasNextPage = false; // No pagination info if it's just a list
        } else if (responseData is Map) {
          data = responseData['players'] ?? [];
          final pagination = responseData['pagination'];
          if (pagination != null) {
            int totalPage = pagination['totalPage'] ?? 1;
            hasNextPage = currentPage < totalPage;
          } else {
            hasNextPage = false;
          }
        }

        final newPlayers = data.map((json) {
          final stats = json['stats'] ?? {};
          return PlayerModel(
            id: json['_id'] ?? "",
            name: "${json['firstName'] ?? ""} ${json['lastName'] ?? ""}".trim(),
            position: json['position'] ?? "N/A",
            image: json['profile'] ?? "",
            appearances: stats['appearances'],
            goals: stats['goals'],
            assists: stats['assists'],
            yellowCards: stats['yellowCards'],
            redCards: stats['redCards'],
            cleanSheets: stats['cleanSheets'],
            saves: stats['saves'],
            strongFoot: json['strongFoot']?.toString(),
            engCoins: json['engCoine'],
            dob: json['dateOfBirth'],
            debutDate: json['createdAt'],
            teamName: json['teamName'],
          );
        }).toList();

        playerList.addAll(newPlayers);
        onSearch(searchController.text);
      }
    } catch (e) {
      debugPrint("Error fetching filtered players: $e");
      if (!isLoadMore) {
        playerList.clear();
        filteredPlayerList.clear();
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
      update();
    }
  }

  Future<void> loadMorePlayers() async {
    currentPage++;
    await fetchFilteredPlayers(isLoadMore: true);
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      filteredPlayerList.assignAll(playerList);
    } else {
      filteredPlayerList.assignAll(
        playerList.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }

  void updateClub(String id, String name) {
    selectedClubId.value = id;
    selectedClubName.value = name;
    fetchFilteredPlayers();
  }

  void updatePosition(String position) {
    selectedPosition.value = position;
    fetchFilteredPlayers();
  }

  void resetFilters() {
    selectedClubId.value = "";
    selectedClubName.value = "All Clubs";
    selectedPosition.value = "All Positions";
    searchController.clear();
    fetchFilteredPlayers();
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
