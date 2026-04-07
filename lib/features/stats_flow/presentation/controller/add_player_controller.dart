import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../utils/constants/app_images.dart';
import '../model/player_model.dart';
class AddPlayerController extends GetxController{
  TextEditingController searchController=TextEditingController();

  final RxList<PlayerModel> playerList = <PlayerModel>[
    PlayerModel(id: "1", name: "Max Aarons", position: "Defender", image: TempImage.player),
    PlayerModel(id: "2", name: "Max Aarons", position: "Defender", image: TempImage.stats1),
    PlayerModel(id: "2", name: "Max Aarons", position: "Defender", image: TempImage.stats2),
    PlayerModel(id: "2", name: "Max Aarons", position: "Defender", image: TempImage.player),
    // ... aro data
  ].obs;

// UI-te call korben:

}