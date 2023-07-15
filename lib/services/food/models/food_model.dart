class FoodModel {
  String id;
  String name;
  double calories;

  FoodModel({
    required this.id,
    required this.name,
    required this.calories,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      calories: double.parse(json['calories'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
    };
  }
}
