class NotificationModel {
  final String id;
  final String alertType;
  final String title;
  final String subtitle;
  final String linkId;
  final String role;
  final String receiver;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationModel({
    required this.id,
    required this.alertType,
    required this.title,
    required this.subtitle,
    required this.linkId,
    required this.role,
    required this.receiver,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic>? json) {
    return NotificationModel(
      id: json?['_id'] ?? '',
      alertType: json?['type'] ?? '',
      title: json?['title'] ?? '',
      subtitle: json?['subtitle'] ?? '',
      linkId: json?['linkId'] ?? '',
      role: json?['role'] ?? '',
      receiver: json?['receiver'] ?? '',
      v: json?['__v'] ?? 0,
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
