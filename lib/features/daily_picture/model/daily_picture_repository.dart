import 'package:stellar_secrets/features/daily_picture/model/data_models/daily_picture.dart';
import 'package:stellar_secrets/features/daily_picture/model/remote_datasources/daily_picture_remote_datasource.dart';

class DailyPictureRepository {
  final DailyPictureRemoteDatasource _dailyPictureRemoteDatasource;

  DailyPictureRepository(
      {required DailyPictureRemoteDatasource dailyPictureRemoteDatasource})
      : _dailyPictureRemoteDatasource = dailyPictureRemoteDatasource;

  Future<DailyPicture> getDailyPicture() async {
    final json = await _dailyPictureRemoteDatasource.getDailyPicture();
    return DailyPicture.fromJson(json);
  }
}
