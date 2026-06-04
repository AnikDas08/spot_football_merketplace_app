class TransferRequestResponse {
  final bool success;
  final String message;
  final List<TransferRequestModel> data;

  TransferRequestResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransferRequestResponse.fromJson(Map<String, dynamic> json) {
    return TransferRequestResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<TransferRequestModel>.from(
              json['data'].map((x) => TransferRequestModel.fromJson(x)))
          : [],
    );
  }
}

class TransferRequestModel {
  final String id;
  final PlayerInfo player;
  final TeamInfo? fromTeam;
  final TeamInfo? toTeam;
  final String requestedBy;
  final String transferType;
  final String status;
  final String? approvedBy;
  final String? rejectReason;
  final DateTime createdAt;

  TransferRequestModel({
    required this.id,
    required this.player,
    this.fromTeam,
    this.toTeam,
    required this.requestedBy,
    required this.transferType,
    required this.status,
    this.approvedBy,
    this.rejectReason,
    required this.createdAt,
  });

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) {
    return TransferRequestModel(
      id: json['_id'] ?? '',
      player: PlayerInfo.fromJson(json['player'] ?? {}),
      fromTeam: json['fromTeam'] != null ? TeamInfo.fromJson(json['fromTeam']) : null,
      toTeam: json['toTeam'] != null ? TeamInfo.fromJson(json['toTeam']) : null,
      requestedBy: json['requestedBy'] ?? '',
      transferType: json['transferType'] ?? '',
      status: json['status'] ?? '',
      approvedBy: json['approvedBy'],
      rejectReason: json['rejectReason'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class PlayerInfo {
  final String id;
  final String userName;
  final String? firstName;
  final String? lastName;
  final String? profile;

  PlayerInfo({
    required this.id,
    required this.userName,
    this.firstName,
    this.lastName,
    this.profile,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    return PlayerInfo(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      profile: json['profile'],
    );
  }
}

class TeamInfo {
  final String id;
  final String teamName;
  final String? teamLogo;

  TeamInfo({
    required this.id,
    required this.teamName,
    this.teamLogo,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      id: json['_id'] ?? '',
      teamName: json['teamName'] ?? '',
      teamLogo: json['teamLogo'],
    );
  }
}
