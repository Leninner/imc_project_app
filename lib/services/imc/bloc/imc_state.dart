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
  final List<Map<String, String>>? imc;
  final List<Map<String, String>>? food;

  const ImcLoaded.initial({this.imc = const [], this.food = const []});

  ImcLoaded copyWith({
    List<Map<String, String>>? imc,
    List<Map<String, String>>? food,
  }) {
    return ImcLoaded.initial(
      imc: imc ?? this.imc,
      food: food ?? this.food,
    );
  }
}
