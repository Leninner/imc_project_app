import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/services/food/index.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<GetFoodEvent>(_handleGetFoodEvent);
  }

  void _handleGetFoodEvent(GetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoading());

    final prevResult = await FoodService().getUserFood(
      endDate: event.endDate,
      startDate: event.startDate,
    );
    final prevCaloriesByMonth = await FoodService().getCaloriesByFilter(
      filter: event.filter,
      endDate: event.endDate,
      startDate: event.startDate,
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
            emit(
              FoodLoaded(
                userFoodList,
                caloriesByFilter,
                {
                  'startDate': event.startDate,
                  'endDate': event.endDate,
                  'filter': event.filter,
                },
              ),
            );
          },
        );
      },
    );
  }
}
