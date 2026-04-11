import 'package:get/get.dart';

import '../../../../utils/constants/temp_image.dart';

class  VideoStreamController extends GetxController{
  RxString videoLink="https://github.com/mdarif3499/video/raw/refs/heads/main/videoplayback.mp4".obs;

  // videoUrl: 'https://github.com/mdarif3499/video/raw/refs/heads/main/videoplayback.mp4'
  // videoUrl: 'https://github.com/mdarif3499/video/raw/refs/heads/main/videoplayback.mp4'
  final List<Map<String, String>> videoList = [
    {
      "title": "Ref Cam: Brobbey's Dramatic Tyne-Wear Derby Goal",
      "description": "See Anthony Taylor's view of Brian Brobbey's late winner against Newcastle",
      "timeAgo": "2 days ago",
      "image": TempImage.playerVideo,
      "videoLink": 'https://raw.githubusercontent.com/mdarif3499/video/main/AngelDiMaria.mp4'
    },
    {
      "title": "Match Highlights: Arsenal vs Man City",
      "description": "Catch up on all the action from the thrilling 2-2 draw at the Emirates",
      "timeAgo": "1 day ago",
      "image": TempImage.playerVideo,
      "videoLink": 'https://github.com/mdarif3499/video/raw/refs/heads/main/videoplayback.mp4'
    },
    {
      "title": "Top 10 Goals of the Week",
      "description": "A countdown of the most spectacular strikes across Europe's top leagues",
      "timeAgo": "5 hours ago",
      "image": TempImage.playerVideo,
      "videoLink": 'https://raw.githubusercontent.com/mdarif3499/video/main/AngelDiMaria.mp4'
    },
  ];
}