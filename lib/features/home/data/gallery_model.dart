class GalleryModel {
  final String id;
  final String image;
  final String status;
  final DateTime? createdAt;

  GalleryModel({
    required this.id,
    required this.image,
    required this.status,
    this.createdAt,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}

class GalleryResponse {
  final bool success;
  final String message;
  final List<GalleryModel> data;
  final dynamic pagination;

  GalleryResponse({
    required this.success,
    required this.message,
    required this.data,
    this.pagination,
  });

  factory GalleryResponse.fromJson(Map<String, dynamic> json) {
    return GalleryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
              ?.map((e) => GalleryModel.fromJson(e))
              .toList() ??
          [],
      pagination: json['pagination'],
    );
  }
}
