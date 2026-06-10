import '../../home/data/match_model.dart';

class PlayerSelectionResponse {
  final bool success;
  final String message;
  final SelectionData? data;

  PlayerSelectionResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory PlayerSelectionResponse.fromJson(Map<String, dynamic> json) {
    return PlayerSelectionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SelectionData.fromJson(json['data']) : null,
    );
  }
}

class SelectionData {
  final String id;
  final dynamic match; // Can be ID or Match object
  final dynamic team;  // Can be ID or Team object
  final String teamFormation;
  final List<SelectedPlayer> players;

  SelectionData({
    required this.id,
    required this.match,
    required this.team,
    required this.teamFormation,
    required this.players,
  });

  factory SelectionData.fromJson(Map<String, dynamic> json) {
    return SelectionData(
      id: json['_id'] ?? '',
      match: json['match'],
      team: json['team'],
      teamFormation: json['teamFormation']?.toString() ?? '11',
      players: json['players'] != null
          ? List<SelectedPlayer>.from(
              json['players'].map((x) => SelectedPlayer.fromJson(x)))
          : [],
    );
  }
}

class SelectedPlayer {
  final PlayerSelectionInfo player;
  final String position;
  final bool substitute;
  final int positionIndex;

  SelectedPlayer({
    required this.player,
    required this.position,
    required this.substitute,
    required this.positionIndex,
  });

  factory SelectedPlayer.fromJson(Map<String, dynamic> json) {
    // Handle both nested player object and flat player info (from filter API)
    final dynamic playerData = json['player'] ?? json;
    
    return SelectedPlayer(
      player: PlayerSelectionInfo.fromJson(playerData),
      position: json['position'] ?? '',
      substitute: json['substitute'] ?? false,
      positionIndex: json['positionIndex'] != null ? (json['positionIndex'] is int ? json['positionIndex'] : int.parse(json['positionIndex'].toString())) : 0,
    );
  }
}

class PlayerSelectionInfo {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? profile;
  final String? userName;

  PlayerSelectionInfo({
    required this.id,
    this.firstName,
    this.lastName,
    this.profile,
    this.userName,
  });

  factory PlayerSelectionInfo.fromJson(dynamic json) {
    // API sometimes returns the ID directly instead of an object in some responses
    if (json is String) {
      return PlayerSelectionInfo(id: json);
    }
    
    if (json is Map<String, dynamic>) {
      return PlayerSelectionInfo(
        id: json['_id'] ?? '',
        firstName: json['firstName'],
        lastName: json['lastName'],
        profile: json['profile'],
        userName: json['userName'],
      );
    }

    return PlayerSelectionInfo(id: '');
  }
}
