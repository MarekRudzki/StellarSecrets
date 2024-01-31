part of 'daily_picture_bloc.dart';

sealed class DailyPictureState extends Equatable {
  const DailyPictureState();

  @override
  List<Object> get props => [];
}

final class DailyPictureInitial extends DailyPictureState {}

final class DailyPictureLoading extends DailyPictureState {}

final class DailyPictureSuccess extends DailyPictureState {
  final DailyPicture dailyPicture;

  DailyPictureSuccess({
    required this.dailyPicture,
  });

  @override
  List<Object> get props => [
        dailyPicture,
      ];
}

final class DailyPictureError extends DailyPictureState {
  final String errorMessage;

  DailyPictureError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
