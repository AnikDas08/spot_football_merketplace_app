class SocialMediaModel {
  final String id;
  final String platform;
  final String url;
  final String icon;
  final bool status;
  final int order;

  SocialMediaModel({
    required this.id,
    required this.platform,
    required this.url,
    required this.icon,
    required this.status,
    required this.order,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      id: json['_id'] ?? '',
      platform: json['platform'] ?? '',
      url: json['url'] ?? '',
      icon: json['icon'] ?? '',
      status: json['status'] ?? false,
      order: json['order'] ?? 0,
    );
  }
}

class SocialMediaResponse {
  final bool success;
  final String message;
  final List<SocialMediaModel> data;

  SocialMediaResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SocialMediaResponse.fromJson(Map<String, dynamic> json) {
    return SocialMediaResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)
              ?.map((e) => SocialMediaModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
