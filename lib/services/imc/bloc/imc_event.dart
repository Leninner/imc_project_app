part of 'imc_bloc.dart';

abstract class ImcEvent extends Equatable {
  const ImcEvent();

  @override
  List<Object> get props => [];
}

class GetImcEvent extends ImcEvent {
  final CaloriesFoodFilter filter;
  final DateTime startDate;
  final DateTime endDate;

  factory GetImcEvent({
    DateTime? startDate,
    DateTime? endDate,
    CaloriesFoodFilter? filter,
  }) {
    return GetImcEvent._(
      startDate: startDate ?? DateTime.now().subtract(const Duration(days: 15)),
      endDate: endDate ?? DateTime.now(),
      filter: filter ?? CaloriesFoodFilter.month,
    );
  }

  const GetImcEvent._({
    required this.startDate,
    required this.endDate,
    required this.filter,
  });

  @override
  List<Object> get props => [startDate, endDate, filter];
}
