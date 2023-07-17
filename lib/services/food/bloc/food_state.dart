part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodError extends FoodState {
  final Exception error;

  const FoodError(this.error);

  @override
  List<Object> get props => [error];
}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<Map<String, String>> foodList;
  final List<Map<String, String>> caloriesByFilter;

  const FoodLoaded(this.foodList, this.caloriesByFilter);

  @override
  List<Object> get props => [foodList, caloriesByFilter];
}
