import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../model/player_model.dart';

class AddPlayerController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final RxList<PlayerModel> playerList = <PlayerModel>[
    PlayerModel(
      id: "1",
      name: "Max Aarons",
      position: "Defender",
      image: TempImage.playerProfile2,
      appearances: 13,
      goals: 4,
      assists: 1,
      yellowCards: 1,
      redCards: 3,
    ),
    PlayerModel(
      id: "2",
      name: "John Doe",
      position: "Forward",
      image: TempImage.stats2,
      appearances: 10,
      goals: 8,
      assists: 5,
    ),
  ].obs;
}
