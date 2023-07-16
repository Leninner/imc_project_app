part of 'imc_bloc.dart';

abstract class ImcState extends Equatable {
  const ImcState();

  @override
  List<Object> get props => [];
}

class ImcInitial extends ImcState {}

class ImcLoading extends ImcState {}

class ImcError extends ImcState {
  final Exception error;

  const ImcError(this.error);

  @override
  List<Object> get props => [error];
}

class ImcLoaded extends ImcState {
  final List<Map<String, String>> imc;

  const ImcLoaded(this.imc);

  @override
  List<Object> get props => [imc];
}
