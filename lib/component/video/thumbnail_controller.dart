import 'package:get/get.dart';
import '../../utils/helpers/video_metadata_helper.dart';

class ThumbnailController extends GetxController {
  final String videoUrl;
  
  final localPath = Rxn<String>();
  final isGenerating = false.obs;

  ThumbnailController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    if (isGenerating.value) return;
    
    isGenerating.value = true;
    try {
      final path = await VideoMetadataHelper.getThumbnail(videoUrl);
      localPath.value = path;
    } finally {
      isGenerating.value = false;
    }
  }
}
