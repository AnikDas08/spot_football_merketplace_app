import '../../../../config/api/api_end_point.dart';

class VideoResponse {
  final bool success;
  final String message;
  final Pagination pagination;
  final List<VideoModel> data;

  VideoResponse({
    required this.success,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      data: (json['data'] as List?)
              ?.map((v) => VideoModel.fromJson(v))
              .toList() ??
          [],
    );
  }
}

class Pagination {
  final int total;
  final int limit;
  final int page;
  final int totalPage;

  Pagination({
    required this.total,
    required this.limit,
    required this.page,
    required this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 10,
      page: json['page'] ?? 1,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class VideoModel {
  final String id;
  final String title;
  final String category;
  final String subCategory;
  final String description;
  final String videoUrl;
  final String hlsUrl;
  final String processingStatus;
  final String thumbnail;
  final String createdBy;
  final String status;
  final String publishDateTime;
  final String createdAt;
  final String updatedAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subCategory,
    required this.description,
    required this.videoUrl,
    required this.hlsUrl,
    required this.processingStatus,
    required this.thumbnail,
    required this.createdBy,
    required this.status,
    required this.publishDateTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    String extractName(dynamic field) {
      if (field == null) return '';
      if (field is String) return field;
      if (field is Map) return field['name'] ?? '';
      return '';
    }

    String cleanUrl(dynamic url) {
      if (url == null || url is! String) return '';
      return url.trim().replaceAll(RegExp(r'[\n\r\s]+'), '');
    }

    return VideoModel(
      id: json['_id'] ?? '',
      title: (json['title'] ?? '').toString().trim(),
      category: extractName(json['category']),
      subCategory: extractName(json['subCategory']),
      description: (json['description'] ?? '').toString().trim(),
      videoUrl: cleanUrl(json['videoUrl']),
      hlsUrl: cleanUrl(json['hlsUrl']),
      processingStatus: (json['processingStatus'] ?? '').toString().trim(),
      thumbnail: cleanUrl(json['thumbnail']),
      createdBy: json['createdBy'] ?? '',
      status: json['status'] ?? '',
      publishDateTime: json['publishDateTime'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  // Helper for full video URL
  String get fullVideoUrl {
    if (videoUrl.isEmpty) return '';
    return videoUrl.startsWith('http') ? videoUrl : '${ApiEndPoint.videoUrl}$videoUrl';
  }

  // Helper for full thumbnail URL
  String get fullThumbnailUrl {
    if (thumbnail.isEmpty) return '';
    return thumbnail.startsWith('http') ? thumbnail : '${ApiEndPoint.imageUrl}$thumbnail';
  }

  // Check if video is from YouTube
  bool get isYouTube {
    final url = videoUrl.toLowerCase();
    return url.contains('youtube.com') || url.contains('youtu.be');
  }


  // Get the effective URL to play (HLS if completed/active, else standard)
  String get effectiveVideoUrl {
    if (isYouTube) return videoUrl;
    
    String status = processingStatus.toLowerCase();
    String rawUrl = ((status == 'completed' || status == 'active') && hlsUrl.isNotEmpty)
        ? hlsUrl 
        : videoUrl;
    
    if (rawUrl.isEmpty) return '';
    return rawUrl.startsWith('http') ? rawUrl : '${ApiEndPoint.videoUrl}$rawUrl';
  }
}
