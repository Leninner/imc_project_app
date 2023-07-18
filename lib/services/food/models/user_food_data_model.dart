import 'package:imc_project_app/utils/date_utils.dart';

class UserFoodDataModel {
  final String month;
  final double calories;

  static final List<String> months = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Oct',
    'Nov',
    'Dic',
  ];

  UserFoodDataModel(this.month, this.calories);

  factory UserFoodDataModel.fromJson(Map<String, String> data) {
    if (data['month'] != null) {
      return UserFoodDataModel(
        months[int.parse(data['month']!) - 1],
        double.parse(data['calories']!),
      );
    }

    if (data['day'] != null) {
      return UserFoodDataModel(
        data['day']!,
        double.parse(data['calories']!),
      );
    }

    if (data['week_start'] != null) {
      return UserFoodDataModel(
        'Semana ${formatDate(data['week_start']!)}',
        double.parse(data['calories']!),
      );
    }

    if (data['year'] != null) {
      return UserFoodDataModel(
        data['year']!,
        double.parse(data['calories']!),
      );
    }

    return UserFoodDataModel(
      months[int.parse(data['month']!) - 1],
      double.parse(data['calories']!),
    );
  }
}
