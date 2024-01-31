part of 'daily_picture_bloc.dart';

sealed class DailyPictureEvent extends Equatable {
  const DailyPictureEvent();

  @override
  List<Object> get props => [];
}

class DailyPictureRequested extends DailyPictureEvent {}
