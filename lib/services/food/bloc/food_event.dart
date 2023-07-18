part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class GetFoodEvent extends FoodEvent {
  final CaloriesFoodFilter filter;
  final DateTime startDate;
  final DateTime endDate;

  factory GetFoodEvent({
    DateTime? startDate,
    DateTime? endDate,
    CaloriesFoodFilter? filter,
  }) {
    return GetFoodEvent._(
      startDate: startDate ?? DateTime.now().subtract(const Duration(days: 15)),
      endDate: endDate ?? DateTime.now(),
      filter: filter ?? CaloriesFoodFilter.month,
    );
  }

  const GetFoodEvent._({
    required this.startDate,
    required this.endDate,
    required this.filter,
  });

  @override
  List<Object> get props => [startDate, endDate, filter];
}
