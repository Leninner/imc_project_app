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
  final Map<String, dynamic> filters;

  const FoodLoaded(this.foodList, this.caloriesByFilter, this.filters);

  FoodLoaded copyWith({
    List<Map<String, String>>? foodList,
    List<Map<String, String>>? caloriesByFilter,
    Map<String, dynamic>? filters,
  }) {
    return FoodLoaded(
      foodList ?? this.foodList,
      caloriesByFilter ?? this.caloriesByFilter,
      filters ?? this.filters,
    );
  }

  @override
  List<Object> get props => [foodList, caloriesByFilter];
}
