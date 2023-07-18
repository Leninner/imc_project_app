import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/services/food/index.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<GetFoodEvent>(_handleGetFoodEvent);
    on<GetFoodChartDataByDateFilterEvent>(
      _handleGetChartDataByDateFilterEvent,
    );
  }

  void _handleGetFoodEvent(GetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoading());

    final prevResult = await FoodService().getUserFood();
    final prevCaloriesByMonth = await FoodService().getCaloriesByFilter(
      filter: CaloriesFoodFilter.month,
      endDate: DateTime.now(),
      startDate: DateTime.now().subtract(
        const Duration(days: 15),
      ),
    );

    prevResult.fold(
      (l) {
        emit(FoodError(l));
      },
      (userFoodList) {
        prevCaloriesByMonth.fold(
          (l) {
            emit(FoodError(l));
          },
          (caloriesByFilter) {
            emit(FoodLoaded(userFoodList, caloriesByFilter));
          },
        );
      },
    );
  }

  void _handleGetChartDataByDateFilterEvent(
    GetFoodChartDataByDateFilterEvent event,
    Emitter<FoodState> emit,
  ) async {
    emit(FoodLoading());

    final result = await FoodService().getCaloriesByDateFilter(
      startDate: event.startDate,
      endDate: event.endDate,
    );
    final prevResult = await FoodService().getUserFood();

    result.fold(
      (l) {
        emit(FoodError(l));
      },
      (caloriesByFilter) {
        prevResult.fold(
          (l) {
            emit(FoodError(l));
          },
          (userFoodList) {
            emit(
              FoodLoaded(userFoodList, caloriesByFilter),
            );
          },
        );
      },
    );
  }
}
