class MatchResultModel {
  final String time;
  final String date;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  MatchResultModel({
    required this.time,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
  });
}