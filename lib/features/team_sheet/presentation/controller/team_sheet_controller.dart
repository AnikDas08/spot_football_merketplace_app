import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class TeamSheetController extends GetxController {
  final selectedTeam = 'United FC'.obs;
  final selectedFormation = '4-3-3 Attacking'.obs;

  final List<String> teams = ['United FC', 'Madrid Kings', 'London Lions'];
  final List<String> formations = [
    '4-3-3 Attacking',
    '3-3-4 Formation',
    '4-4-2 Defensive',
  ];

  final List<Map<String, String>> roster = [
    {'name': 'James', 'initial': 'J', 'pos': 'ST'},
    {'name': 'David', 'initial': 'D', 'pos': 'ST'},
    {'name': 'Tom', 'initial': 'T', 'pos': 'CM'},
    {'name': 'Chris', 'initial': 'C', 'pos': 'CM'},
    {'name': 'Marcus', 'initial': 'M', 'pos': 'ST'},
    {'name': 'Ryan', 'initial': 'R', 'pos': 'CM'},
    {'name': 'Ben', 'initial': 'B', 'pos': 'CB'},
    {'name': 'Jake', 'initial': 'J', 'pos': 'CB'},
    {'name': 'Mike', 'initial': 'M', 'pos': 'GK'},
    {'name': 'Alex', 'initial': 'A', 'pos': 'CM'},
    {'name': 'Leo', 'initial': 'L', 'pos': 'ST'},
  ];

  final RxMap<int, Map<String, String>?> currentLineup = <int, Map<String, String>?>{
    1: {'name': 'James', 'initial': 'J', 'pos': 'ST'},
    2: {'name': 'David', 'initial': 'D', 'pos': 'ST'},
    4: {'name': 'Tom', 'initial': 'T', 'pos': 'CM'},
    7: {'name': 'Tom', 'initial': 'T', 'pos': 'CB'},
  }.obs;

  final RxMap<int, Map<String, String>?> substitutes = <int, Map<String, String>?>{
    0: null,
    1: null,
    2: null,
    3: null,
  }.obs;

  void updateTeam(String team) {
    selectedTeam.value = team;
  }

  void updateFormation(String formation) {
    selectedFormation.value = formation;
    currentLineup.clear();
  }

  void assignPlayer(int index, Map<String, String> player, {bool isSub = false}) {
    if (isSub) {
      substitutes[index] = player;
    } else {
      currentLineup[index] = player;
    }
  }

  List<List<String>> getFormationLayout() {
    switch (selectedFormation.value) {
      case '3-3-4 Formation':
        return [
          ['ST', 'ST', 'ST', 'ST'],
          ['CM', 'CM', 'CM'],
          ['CB', 'CB', 'CB'],
          ['GK'],
        ];
      case '4-4-2 Defensive':
        return [
          ['ST', 'ST'],
          ['CM', 'CM', 'CM', 'CM'],
          ['CB', 'CB', 'CB', 'CB'],
          ['GK'],
        ];
      case '4-3-3 Attacking':
      default:
        return [
          ['ST', 'ST', 'ST'],
          ['CM', 'CM', 'CM'],
          ['CB', 'CB', 'CB', 'CB'],
          ['GK'],
        ];
    }
  }

  void confirmLineup() {
    Get.snackbar(
      'Success',
      'Lineup confirmed successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.green,
      colorText: Colors.white,
      margin: EdgeInsets.all(15.0),
    );
  }
}
