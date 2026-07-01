class SeasonLeaderboardModel {
  bool? success;
  String? message;
  LeaderboardData? data;

  SeasonLeaderboardModel({this.success, this.message, this.data});

  SeasonLeaderboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? LeaderboardData.fromJson(json['data']) : null;
  }
}

class LeaderboardData {
  List<LeaderboardEntry>? goal;
  List<LeaderboardEntry>? assist;

  LeaderboardData({this.goal, this.assist});

  LeaderboardData.fromJson(Map<String, dynamic> json) {
    if (json['goal'] != null) {
      goal = <LeaderboardEntry>[];
      json['goal'].forEach((v) {
        goal!.add(LeaderboardEntry.fromJson(v, isGoal: true));
      });
    }
    if (json['assist'] != null) {
      assist = <LeaderboardEntry>[];
      json['assist'].forEach((v) {
        assist!.add(LeaderboardEntry.fromJson(v, isGoal: false));
      });
    }
  }
}

class LeaderboardEntry {
  int? rank;
  int? totalCount;
  String? firstName;
  String? lastName;
  String? profile;

  LeaderboardEntry({
    this.rank,
    this.totalCount,
    this.firstName,
    this.lastName,
    this.profile,
  });

  LeaderboardEntry.fromJson(Map<String, dynamic> json, {required bool isGoal}) {
    rank = json['rank'];
    totalCount = isGoal ? json['totalGoals'] : json['totalAssists'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profile = json['profile'];
  }

  String get fullName => "${firstName ?? ''} ${lastName ?? ''}".trim();
}
