class NewsModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String image;
  final String status;
  final DateTime publishDateTime;

  NewsModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.status,
    required this.publishDateTime,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      publishDateTime: DateTime.parse(json['publishDateTime'] ?? DateTime.now().toIso8601String()),
    );
  }
}
