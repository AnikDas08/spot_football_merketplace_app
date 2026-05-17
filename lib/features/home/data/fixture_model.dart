class UpcomingFixtureModel {
  final String date;
  final String homeTeam;
  final String awayTeam;
  final String time;

  UpcomingFixtureModel({
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.time,
  });

  factory UpcomingFixtureModel.fromJson(Map<String, dynamic> json) {
    return UpcomingFixtureModel(
      date: json['date'] ?? '',
      homeTeam: json['homeTeam'] ?? '',
      awayTeam: json['awayTeam'] ?? '',
      time: json['time'] ?? '',
    );
  }
}