part of 'space_fact_bloc.dart';

sealed class SpaceFactState extends Equatable {
  const SpaceFactState();

  @override
  List<Object> get props => [];
}

final class SpaceFactInitial extends SpaceFactState {}

final class SpaceFactLoading extends SpaceFactState {}

final class SpaceFactSuccess extends SpaceFactState {
  final SpaceFact spaceFact;

  SpaceFactSuccess({
    required this.spaceFact,
  });

  @override
  List<Object> get props => [
        spaceFact,
      ];
}

final class SpaceFactError extends SpaceFactState {
  final String errorMessage;

  SpaceFactError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
