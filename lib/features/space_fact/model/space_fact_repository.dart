import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';
import 'package:stellar_secrets/features/space_fact/model/local_datasources/hive_local_datasource.dart';
import 'package:stellar_secrets/features/space_fact/model/remote_datasources/nasa_remote_datasource.dart';

class SpaceFactRepository {
  final NASARemoteDataSource spaceFactRemoteDataSource;
  final HiveLocalDatasource hiveLocalDatasource;

  SpaceFactRepository({
    required this.spaceFactRemoteDataSource,
    required this.hiveLocalDatasource,
  });

  Future<SpaceFact> getDailySpaceFact() async {
    final json = await spaceFactRemoteDataSource.getDailySpaceFact();
    return SpaceFact.fromJson(json);
  }

  Future<SpaceFact> getRandomSpaceFact() async {
    final json = await spaceFactRemoteDataSource.getRandomSpaceFact();
    return SpaceFact.fromJson(json);
  }

  Future<void> addDailySpaceFact({
    required String date,
    required SpaceFact spaceFact,
  }) async {
    await hiveLocalDatasource.addDailyFact(
      spaceFact: spaceFact,
    );
  }

  SpaceFact getSavedSpaceFact({
    required String date,
  }) {
    final json = hiveLocalDatasource.getDailyFact(date: date);
    return SpaceFact.fromJson(json);
  }

  bool checkIfDailyFactIsSaved({
    required String date,
  }) {
    return hiveLocalDatasource.checkIfDailyFactIsSaved(date: date);
  }
}
