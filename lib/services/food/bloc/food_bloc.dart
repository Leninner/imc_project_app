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

    final prevResult = await FoodService().getUserFood();

    prevResult.fold(
      (l) {
        emit(FoodError(l));
      },
      (r) => emit(FoodLoaded(r)),
    );
  }
}
