class PointTableResponse {
  final bool success;
  final String message;
  final List<LeagueData> data;

  PointTableResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PointTableResponse.fromJson(Map<String, dynamic> json) {
    return PointTableResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<LeagueData>.from(
              json['data'].map((x) => LeagueData.fromJson(x)))
          : [],
    );
  }
}

class LeagueData {
  final League league;
  final List<PointTableModel> standings;

  LeagueData({
    required this.league,
    required this.standings,
  });

  factory LeagueData.fromJson(Map<String, dynamic> json) {
    return LeagueData(
      league: League.fromJson(json['league'] ?? {}),
      standings: json['standings'] != null
          ? List<PointTableModel>.from(
              json['standings'].map((x) => PointTableModel.fromJson(x)))
          : [],
    );
  }
}

class League {
  final String id;
  final String leagueName;
  final String season;

  League({
    required this.id,
    required this.leagueName,
    required this.season,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['_id'] ?? '',
      leagueName: json['leagueName'] ?? '',
      season: json['season'] ?? '',
    );
  }
}

class PointTableModel {
  final PointTableTeam team;
  final int played;
  final int win;
  final int draw;
  final int loss;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;

  PointTableModel({
    required this.team,
    required this.played,
    required this.win,
    required this.draw,
    required this.loss,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
  });

  factory PointTableModel.fromJson(Map<String, dynamic> json) {
    return PointTableModel(
      team: PointTableTeam.fromJson(json['team'] ?? {}),
      played: json['played'] ?? 0,
      win: json['win'] ?? 0,
      draw: json['draw'] ?? 0,
      loss: json['loss'] ?? 0,
      goalsFor: json['goalsFor'] ?? 0,
      goalsAgainst: json['goalsAgainst'] ?? 0,
      goalDifference: json['goalDifference'] ?? 0,
      points: json['points'] ?? 0,
    );
  }
}

class PointTableTeam {
  final String id;
  final String teamName;
  final String shortName;
  final String? teamLogo;

  PointTableTeam({
    required this.id,
    required this.teamName,
    required this.shortName,
    this.teamLogo,
  });

  factory PointTableTeam.fromJson(Map<String, dynamic> json) {
    return PointTableTeam(
      id: json['_id'] ?? '',
      teamName: json['teamName'] ?? '',
      shortName: json['shortName'] ?? '',
      teamLogo: json['teamLogo'],
    );
  }
}
