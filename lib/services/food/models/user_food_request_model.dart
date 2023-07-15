class UserFoodRequestModel {
  final String foodId;
  final String scheduleId;
  final double calories;
  final String userId;

  UserFoodRequestModel({
    required this.foodId,
    required this.scheduleId,
    required this.calories,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'scheduleId': scheduleId,
      'calories': calories,
      'userId': userId,
    };
  }
}
