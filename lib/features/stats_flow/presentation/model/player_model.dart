class PlayerModel {
  final String id;
  final String name;
  final String position;
  final String image;

  // Stats fields made nullable to handle "hidden" logic correctly
  final int? appearances;
  final int? goals;
  final int? assists;
  final int? cleanSheets;
  final int? saves;
  final int? yellowCards;
  final int? redCards;

  // Additional public info
  final String? strongFoot;
  final int? engCoins;
  final String? dob;
  final String? debutDate;
  final String? teamName;

  PlayerModel({
    required this.id,
    required this.name,
    required this.position,
    required this.image,
    this.appearances,
    this.goals,
    this.assists,
    this.cleanSheets,
    this.saves,
    this.yellowCards,
    this.redCards,
    this.strongFoot,
    this.engCoins,
    this.dob,
    this.debutDate,
    this.teamName,
  });
}
