class LeaguePreviewModel {
  final int position;
  final String clubName;
  final String clubLogoUrl;
  final int played;
  final int goalDifference;
  final int points;

  const LeaguePreviewModel({
    required this.position,
    required this.clubName,
    required this.clubLogoUrl,
    required this.played,
    required this.goalDifference,
    required this.points,
  });
}