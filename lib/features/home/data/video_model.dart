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
  final String description;
  final String videoUrl;
  final String createdBy;
  final String status;
  final String publishDateTime;
  final String createdAt;
  final String updatedAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.videoUrl,
    required this.createdBy,
    required this.status,
    required this.publishDateTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      createdBy: json['createdBy'] ?? '',
      status: json['status'] ?? '',
      publishDateTime: json['publishDateTime'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
