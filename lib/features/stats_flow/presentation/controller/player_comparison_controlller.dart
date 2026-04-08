import 'package:get/get.dart';
import 'package:untitled/features/stats_flow/presentation/model/player_model.dart';



class PlayerComparisonController extends GetxController {
  // Model-er nam ekhon PlayerModel
  var player1 = Rxn<PlayerModel>();
  var player2 = Rxn<PlayerModel>();

  void selectPlayer(PlayerModel player, int slot) {
    if (slot == 1) {
      player1.value = player;
    } else {
      player2.value = player;
    }
    Get.back();
  }

  bool get canShowStats => player1.value != null;
}