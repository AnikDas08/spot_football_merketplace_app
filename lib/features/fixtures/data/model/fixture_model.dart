// features/fixtures/data/model/fixture_model.dart

class FixtureModel {
  final String id;
  final String date;       // "OCT 24"
  final String time;       // "20:00 PM"
  final String homeTeam;
  final String awayTeam;
  final String groupLabel; // "TONIGHT", "TOMORROW", etc.

  FixtureModel({
    required this.id,
    required this.date,
    required this.time,
    required this.homeTeam,
    required this.awayTeam,
    required this.groupLabel,
  });
}