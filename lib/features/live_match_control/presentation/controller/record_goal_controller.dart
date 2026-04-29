import 'package:get/get.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class RecordGoalController extends GetxController {
  final selectedTeam = 'Tigers FC'.obs;
  final selectedPlayerIndex = 0.obs;
  final selectedGoalType = 'Regular Goal'.obs;
  final selectedAssistPlayer = RxnString();

  final List<Map<String, String>> players = [
    {'name': 'J. Smith', 'number': '10', 'image': TempImage.profile},
    {'name': 'R. Garcia', 'number': '07', 'image': TempImage.profile},
    {'name': 'M. Rossi', 'number': '05', 'image': TempImage.profile},
    {'name': 'L. Miller', 'number': '11', 'image': TempImage.profile},
    {'name': 'A. Khan', 'number': '09', 'image': TempImage.profile},
  ];

  void updateTeam(String team) {
    selectedTeam.value = team;
  }

  void updatePlayerIndex(int index) {
    selectedPlayerIndex.value = index;
  }

  void updateGoalType(String type) {
    selectedGoalType.value = type;
  }

  void updateAssistPlayer(String? player) {
    selectedAssistPlayer.value = player;
  }
}
