import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class VideoMetadataHelper {
  static final Map<String, String> _thumbnailCache = {};

  /// Generates a thumbnail for the given [videoUrl].
  static Future<String?> getThumbnail(String videoUrl) async {
    if (videoUrl.isEmpty) return null;
    
    final encodedUrl = Uri.encodeFull(videoUrl);
    if (_thumbnailCache.containsKey(encodedUrl)) {
      return _thumbnailCache[encodedUrl];
    }

    try {
      final tempDir = await getTemporaryDirectory();
      
      final dynamic result = await VideoThumbnail.thumbnailFile(
        video: encodedUrl,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 400,
        quality: 85,
        timeMs: 1000, 
      );

      if (result != null) {
        final String path = (result is String) ? result : result.path;
        _thumbnailCache[encodedUrl] = path;
        return path;
      }
    } catch (e) {
      debugPrint("VideoMetadataHelper: Failed to generate thumbnail for $encodedUrl: $e");
      
      try {
        final tempDir = await getTemporaryDirectory();
        final dynamic result = await VideoThumbnail.thumbnailFile(
          video: encodedUrl,
          thumbnailPath: tempDir.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 400,
          quality: 85,
        );
        if (result != null) {
          final String path = (result is String) ? result : result.path;
          _thumbnailCache[encodedUrl] = path;
          return path;
        }
      } catch (_) {}
    }
    return null;
  }

  /// Formats snake_case category strings to Title Case.
  static String formatCategory(String cat) {
    if (cat.isEmpty) return cat;
    
    String formatted = cat.replaceAll('_', ' ');
    if (formatted.toLowerCase() == 'refree body cam highlight') return 'Referee Body Cam Highlight';
    
    return formatted.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
