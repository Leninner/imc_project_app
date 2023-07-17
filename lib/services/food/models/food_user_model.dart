class FoodUserModel {
  final String foodName;
  final String calories;
  final String scheduleName;
  final String createdAt;

  FoodUserModel({
    required this.foodName,
    required this.calories,
    required this.scheduleName,
    required this.createdAt,
  });

  factory FoodUserModel.fromJson(Map<String, String> json) {
    return FoodUserModel(
      foodName: json['foodName'].toString(),
      calories: json['calories'].toString(),
      scheduleName: json['scheduleName'].toString(),
      createdAt: json['createdAt'].toString(),
    );
  }

  Map<String, String> toJson() {
    return {
      'name': foodName,
      'calories': calories,
      'scheduleName': scheduleName,
      'createdAt': createdAt,
    };
  }
}
