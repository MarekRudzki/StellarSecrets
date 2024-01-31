import 'package:stellar_secrets/features/daily/model/data_models/daily_data.dart';
import 'package:stellar_secrets/features/daily/model/remote_datasources/daily_data_remote_datasource.dart';

class DailyDataRepository {
  final DailyDataRemoteDatasource _dailyDataRemoteDatasource;

  DailyDataRepository({
    required DailyDataRemoteDatasource dailyDataRemoteDatasource,
  }) : _dailyDataRemoteDatasource = dailyDataRemoteDatasource;

  Future<DailyData> getDailyData() async {
    final json = await _dailyDataRemoteDatasource.getDailyData();
    return DailyData.fromJson(json);
  }
}
