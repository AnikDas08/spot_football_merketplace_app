class PlayerResponse {
  final bool success;
  final String message;
  final List<PlayerModel> data;

  PlayerResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PlayerResponse.fromJson(Map<String, dynamic> json) {
    return PlayerResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<PlayerModel>.from(
              json['data'].map((x) => PlayerModel.fromJson(x)))
          : [],
    );
  }
}

class PlayerModel {
  final String id;
  final String userName;
  final String role;
  final String email;
  final String? profile;
  final bool verified;
  final AccountInformation? accountInformation;

  PlayerModel({
    required this.id,
    required this.userName,
    required this.role,
    required this.email,
    this.profile,
    required this.verified,
    this.accountInformation,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      profile: json['profile'],
      verified: json['verified'] ?? false,
      accountInformation: json['accountInformation'] != null
          ? AccountInformation.fromJson(json['accountInformation'])
          : null,
    );
  }
}

class AccountInformation {
  final bool status;

  AccountInformation({required this.status});

  factory AccountInformation.fromJson(Map<String, dynamic> json) {
    return AccountInformation(
      status: json['status'] ?? false,
    );
  }
}
