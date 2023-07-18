part of 'imc_bloc.dart';

abstract class ImcEvent extends Equatable {
  const ImcEvent();

  @override
  List<Object> get props => [];
}

class GetImcEvent extends ImcEvent {}

class GetImcChartDataByDateFilterEvent extends ImcEvent {
  final DateTime startDate;
  final DateTime endDate;

  const GetImcChartDataByDateFilterEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}
