class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String message;
  final String receiver;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.receiver,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic>? json) {
    return NotificationModel(
      id: json?['_id'] ?? '',
      type: json?['type'] ?? '',
      title: json?['title'] ?? '',
      message: json?['message'] ?? '',
      receiver: json?['receiver'] ?? '',
      isRead: json?['isRead'] ?? false,
      createdAt:
          DateTime.tryParse(json?['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json?['updatedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inSeconds < 60) return '${diff.inSeconds} SEC AGO';
    if (diff.inMinutes < 60) return '${diff.inMinutes} MIN AGO';
    if (diff.inHours < 24) return '${diff.inHours} HR AGO';
    return '${diff.inDays} DAYS AGO';
  }
}
