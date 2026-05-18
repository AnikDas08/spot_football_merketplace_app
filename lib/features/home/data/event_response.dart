class EventResponse {
  final bool success;
  final String message;
  final Pagination? pagination;
  final List<EventModel> data;

  EventResponse({
    required this.success,
    required this.message,
    this.pagination,
    required this.data,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      data: json['data'] != null
          ? List<EventModel>.from(
              json['data'].map((x) => EventModel.fromJson(x)))
          : [],
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
      limit: json['limit'] ?? 0,
      page: json['page'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String location;
  final DateTime? eventDate;
  final String status;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    this.eventDate,
    required this.status,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      eventDate: json['eventDate'] != null
          ? DateTime.parse(json['eventDate'])
          : null,
      status: json['status'] ?? '',
    );
  }
}
