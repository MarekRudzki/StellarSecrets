part of 'space_fact_bloc.dart';

sealed class SpaceFactEvent extends Equatable {
  const SpaceFactEvent();

  @override
  List<Object> get props => [];
}

class DailySpaceFactRequested extends SpaceFactEvent {}

class RandomSpaceFactRequsted extends SpaceFactEvent {}
