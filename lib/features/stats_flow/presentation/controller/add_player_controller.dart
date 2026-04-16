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



  var selectedSeason = "2024/25".obs;
  var selectedClub = "All Clubs".obs;
  var selectedPosition = "All Positions".obs;

  // Options List
  final List<String> seasons = ["2023/24", "2024/25", "2025/26"];
  final List<String> clubs = ["All Clubs", "TITANS FC", "EAGLES SC"];
  final List<String> positions = ["All Positions", "Forward", "Midfielder", "Defender"];
}
