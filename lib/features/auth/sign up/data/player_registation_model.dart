class RegistrationPlan {
  final String id;
  final String title;
  final String badge;
  final double price;
  final String priceSubtitle;
  final List<String> features;
  final List<bool> featureStatus; // true for checkmark, false for cross
  final String buttonText;
  bool isSelected;

  RegistrationPlan({
    required this.id,
    required this.title,
    required this.badge,
    required this.price,
    required this.priceSubtitle,
    required this.features,
    required this.featureStatus,
    required this.buttonText,
    this.isSelected = false,
  });

  RegistrationPlan copyWith({bool? isSelected}) {
    return RegistrationPlan(
      id: id,
      title: title,
      badge: badge,
      price: price,
      priceSubtitle: priceSubtitle,
      features: features,
      featureStatus: featureStatus,
      buttonText: buttonText,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}