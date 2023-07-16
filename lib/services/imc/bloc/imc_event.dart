part of 'imc_bloc.dart';

abstract class ImcEvent extends Equatable {
  const ImcEvent();

  @override
  List<Object> get props => [];
}

class GetImcEvent extends ImcEvent {}
