class MatchResponse {
  final bool success;
  final String message;
  final List<MatchModel> data;

  MatchResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<MatchModel>.from(
              json['data'].map((x) => MatchModel.fromJson(x)))
          : [],
    );
  }
}

class MatchModel {
  final String id;
  final String? league;
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final DateTime? matchDate;
  final int durationMinutes;
  final String venueName;
  final RefereeModel? referee;
  final String status;
  final int homeScore;
  final int awayScore;
  final String? notes;

  MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    this.matchDate,
    required this.durationMinutes,
    required this.venueName,
    this.referee,
    required this.status,
    required this.homeScore,
    required this.awayScore,
    this.notes, this.league,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['_id'] ?? '',
      league: json['league'] is String ? json['league'] : json['league']?['_id'],
      homeTeam: TeamModel.fromJson(json['homeTeam'] ?? {}),
      awayTeam: TeamModel.fromJson(json['awayTeam'] ?? {}),
      matchDate: json['matchDate'] != null ? DateTime.parse(json['matchDate']) : null,
      durationMinutes: json['durationMinutes'] ?? 0,
      venueName: json['venueName'] ?? '',
      referee: json['referee'] != null ? RefereeModel.fromJson(json['referee']) : null,
      status: json['status'] ?? '',
      homeScore: json['homeScore'] ?? 0,
      awayScore: json['awayScore'] ?? 0,
      notes: json['notes'],
    );
  }
}

class TeamModel {
  final String id;
  final String teamName;
  final String shortName;
  final String? teamLogo;
  final String stadiumName;

  TeamModel({
    required this.id,
    required this.teamName,
    required this.shortName,
    this.teamLogo,
    required this.stadiumName,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['_id'] ?? '',
      teamName: json['teamName'] ?? '',
      shortName: json['shortName'] ?? '',
      teamLogo: json['teamLogo'],
      stadiumName: json['stadiumName'] ?? '',
    );
  }
}

class RefereeModel {
  final String id;
  final String userName;
  final String? profile;

  RefereeModel({
    required this.id,
    required this.userName,
    this.profile,
  });

  factory RefereeModel.fromJson(Map<String, dynamic> json) {
    return RefereeModel(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      profile: json['profile'],
    );
  }
}
