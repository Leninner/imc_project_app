import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/services/imc/index.dart';

part 'imc_event.dart';
part 'imc_state.dart';

class ImcBloc extends Bloc<ImcEvent, ImcState> {
  ImcBloc() : super(ImcInitial()) {
    on<GetImcEvent>(_handleGetImcEvent);
    on<GetImcChartDataByDateFilterEvent>(
        _handleGetImcChartDataByDateFilterEvent);
  }

  void _handleGetImcEvent(GetImcEvent event, Emitter<ImcState> emit) async {
    emit(ImcLoading());

    final prevImc = await ImcService().getUserImc();

    prevImc.fold(
      (l) {
        emit(ImcError(l));
      },
      (r) {
        emit(ImcLoaded(r));
      },
    );
  }

  void _handleGetImcChartDataByDateFilterEvent(
    GetImcChartDataByDateFilterEvent event,
    Emitter<ImcState> emit,
  ) async {
    emit(ImcLoading());

    final prevImc = await ImcService().getUserImcByDateFilter(
      startDate: event.startDate,
      endDate: event.endDate,
    );

    prevImc.fold(
      (l) {
        emit(ImcError(l));
      },
      (r) {
        emit(ImcLoaded(r));
      },
    );
  }
}
