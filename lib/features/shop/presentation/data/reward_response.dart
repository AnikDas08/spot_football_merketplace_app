
class RewardResponse {
  final bool success;
  final String message;
  final Pagination? pagination;
  final List<RewardProduct> data;

  RewardResponse({
    required this.success,
    required this.message,
    this.pagination,
    required this.data,
  });

  factory RewardResponse.fromJson(Map<String, dynamic> json) {
    return RewardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      data: json['data'] != null
          ? List<RewardProduct>.from(
          json['data'].map((x) => RewardProduct.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'pagination': pagination?.toJson(),
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
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

  Map<String, dynamic> toJson() => {
    'total': total,
    'limit': limit,
    'page': page,
    'totalPage': totalPage,
  };
}

class RewardProduct {
  final String id;
  final String? image;
  final String brand;
  final String productType;
  final int point;
  final String status;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RewardProduct({
    required this.id,
    this.image,
    required this.brand,
    required this.productType,
    required this.point,
    required this.status,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory RewardProduct.fromJson(Map<String, dynamic> json) {
    return RewardProduct(
      id: json['_id'] ?? '',
      image: json['image'],
      brand: json['brand'] ?? '',
      productType: json['productType'] ?? '',
      point: json['point'] ?? 0,
      status: json['status'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
    'brand': brand,
    'productType': productType,
    'point': point,
    'status': status,
    'createdBy': createdBy,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}