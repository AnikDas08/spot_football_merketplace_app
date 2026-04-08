class PlayerComparison {
  final String image;
  final String name;
  final String position;

  final int appearances;
  final int goals;
  final int assists;
  final int cleanSheets;
  final int saves;
  final int yellowCards;
  final int redCards;

  PlayerComparison({
    required this.image,
    required this.name,
    required this.position,
    this.appearances = 0,
    this.goals = 0,
    this.assists = 0,
    this.cleanSheets = 0,
    this.saves = 0,
    this.yellowCards = 0,
    this.redCards = 0,
  });
}