import 'package:flutter/material.dart';
import '../../data/fixture_model.dart';

class ClubProfileController extends ChangeNotifier {
  List<UpcomingFixtureModel> upcomingFixturesList = [];

  ClubProfileController() {
    getUpcomingFixtures();
  }

  void getUpcomingFixtures() {
    List<Map<String, dynamic>> dummyData = [
      {"date": "OCT 12", "homeTeam": "Titans SC", "awayTeam": "Vortex FC", "time": "20:00 PM"},
      {"date": "OCT 15", "homeTeam": "Phoenix UTDS", "awayTeam": "Warriors", "time": "18:00 PM"},
      {"date": "OCT 20", "homeTeam": "Lions FC", "awayTeam": "Titans SC", "time": "21:00 PM"},
      {"date": "OCT 24", "homeTeam": "Vortex FC", "awayTeam": "Phoenix UTDS", "time": "19:30 PM"},
    ];

    upcomingFixturesList = dummyData.map((e) => UpcomingFixtureModel.fromJson(e)).toList();

    notifyListeners();
  }
}