import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stellar_secrets/features/daily_picture/model/daily_picture_repository.dart';
import 'package:stellar_secrets/features/daily_picture/model/data_models/daily_picture.dart';
import 'package:stellar_secrets/features/daily_picture/model/remote_datasources/daily_picture_remote_datasource.dart';

part 'daily_picture_event.dart';
part 'daily_picture_state.dart';

class DailyPictureBloc extends Bloc<DailyPictureEvent, DailyPictureState> {
  final dailyPictureProvider = DailyPictureRepository(
    dailyPictureRemoteDatasource: DailyPictureRemoteDatasource(),
  );
  DailyPictureBloc() : super(DailyPictureInitial()) {
    on<DailyPictureRequested>(_onDailyPictureRequested);
  }

  Future<void> _onDailyPictureRequested(
    DailyPictureRequested event,
    Emitter<DailyPictureState> emit,
  ) async {
    emit(DailyPictureLoading());
    try {
      final dailyPicture = await dailyPictureProvider.getDailyPicture();
      emit(DailyPictureSuccess(dailyPicture: dailyPicture));
    } catch (e) {
      emit(DailyPictureError(errorMessage: 'Data loading failed.'));
    }
  }
}
