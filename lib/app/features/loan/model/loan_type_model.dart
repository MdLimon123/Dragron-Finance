class LoanTypeModel {
  final String id;
  final String name;
  final String iconImageUrl;
  final String description;

  LoanTypeModel({
    required this.id,
    required this.name,
    required this.iconImageUrl,
    required this.description,
  });

  factory LoanTypeModel.fromJson(Map<String, dynamic> json) {
    return LoanTypeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iconImageUrl: json['iconImageUrl'] ?? '',
      description: json['description'] ?? '',
    );
  }
}