part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class GetFoodEvent extends FoodEvent {}

class GetFoodChartDataByDateFilterEvent extends FoodEvent {
  final DateTime startDate;
  final DateTime endDate;

  const GetFoodChartDataByDateFilterEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}
