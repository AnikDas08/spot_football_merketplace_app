class VideoCategoryModel {
  final String id;
  final String name;
  final String slug;
  final int order;
  final List<VideoSubCategoryModel> subCategories;

  VideoCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.order,
    required this.subCategories,
  });

  factory VideoCategoryModel.fromJson(Map<String, dynamic> json) {
    return VideoCategoryModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      order: json['order'] ?? 0,
      subCategories: (json['subCategories'] as List?)
              ?.map((e) => VideoSubCategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class VideoSubCategoryModel {
  final String id;
  final String name;
  final String parentCategory;

  VideoSubCategoryModel({
    required this.id,
    required this.name,
    required this.parentCategory,
  });

  factory VideoSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return VideoSubCategoryModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      parentCategory: json['parentCategory'] ?? '',
    );
  }
}

class VideoCategoryResponse {
  final bool success;
  final String message;
  final List<VideoCategoryModel> data;

  VideoCategoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VideoCategoryResponse.fromJson(Map<String, dynamic> json) {
    return VideoCategoryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
              ?.map((e) => VideoCategoryModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
