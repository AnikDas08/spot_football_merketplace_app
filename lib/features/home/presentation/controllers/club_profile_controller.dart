import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../data/match_model.dart';
import '../../data/point_table_model.dart';

class ClubProfileController extends GetxController {
  static ClubProfileController get to => Get.find();
  final ApiClient apiClient = DioApiClient();

  var isLoading = false.obs;
  List<MatchModel> liveMatches = [];
  List<MatchModel> recentMatches = [];
  List<MatchModel> upcomingMatches = [];
  
  List<LeagueData> allLeagues = [];
  int selectedLeagueIndex = 0;
  List<PointTableModel> pointTable = [];
  String pointTableMessage = '';

  // Team Dashboard Data
  Map<String, dynamic>? teamData;
  List<dynamic> teamPlayers = [];
  int totalPlayers = 0;
  int position = 0;
  int points = 0;
  int goalDifference = 0;

  @override
  void onInit() {
    super.onInit();
    final String? teamId = Get.arguments;
    if (teamId != null) {
      fetchTeamDashboard(teamId);
    } else {
      fetchMatches();
      fetchPointTable();
    }
  }

  void selectLeague(int index) {
    if (index >= 0 && index < allLeagues.length) {
      selectedLeagueIndex = index;
      pointTable = allLeagues[index].standings;
      update();
    }
  }

  Future<void> fetchMatches() async {
    try {

      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.match);

      if (response.statusCode == 200) {
        final matchResponse = MatchResponse.fromJson(response.data);
        
        liveMatches = matchResponse.data
            .where((match) => match.status.toLowerCase() == 'live' || match.status.toLowerCase() == 'half_time')
            .toList();

        recentMatches = matchResponse.data
            .where((match) => match.status.toLowerCase() == 'finished')
            .toList();
            
        upcomingMatches = matchResponse.data
            .where((match) => match.status.toLowerCase() == 'upcoming')
            .toList();
      }




    } catch (e) {
      debugPrint('❌ fetchMatches error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchPointTable() async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get(ApiEndPoint.pointTable);

      if (response.statusCode == 200) {
        final pointTableResponse = PointTableResponse.fromJson(response.data);
        allLeagues = pointTableResponse.data;
        
        if (allLeagues.isNotEmpty) {
          if (selectedLeagueIndex >= allLeagues.length) {
            selectedLeagueIndex = 0;
          }
          pointTable = allLeagues[selectedLeagueIndex].standings;
        } else {
          pointTable = [];
        }
        
        pointTableMessage = pointTableResponse.message;
      }
    } catch (e) {
      debugPrint('❌ fetchPointTable error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchTeamDashboard(String teamId) async {
    try {
      isLoading.value = true;
      update();

      final response = await apiClient.get("${ApiEndPoint.teamDashboard}$teamId");

      if (response.statusCode == 200) {
        final data = response.data['data'];
        teamData = data['team'];
        teamPlayers = data['players'] ?? [];
        totalPlayers = data['totalPlayers'] ?? 0;
        position = data['position'] ?? 0;
        points = data['points'] ?? 0;
        goalDifference = data['goalDifference'] ?? 0;
        
        upcomingMatches = (data['upcomingMatches'] as List?)
                ?.map((e) => MatchModel.fromJson(e))
                .toList() ?? [];
        
        // Handle both 'recentResults' and 'recentMatches' keys
        final List? results = data['recentResults'] ?? data['recentMatches'];
        recentMatches = results
                ?.map((e) => MatchModel.fromJson(e))
                .toList() ?? [];
      }
    } catch (e) {
      debugPrint('❌ fetchTeamDashboard error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
