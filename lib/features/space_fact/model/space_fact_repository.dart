import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';
import 'package:stellar_secrets/features/space_fact/model/remote_datasources/space_fact_remote_datasource.dart';

class SpaceFactRepository {
  final SpaceFactRemoteDataSource spaceFactRemoteDataSource;

  SpaceFactRepository({
    required this.spaceFactRemoteDataSource,
  });

  Future<SpaceFact> getDailySpaceFact() async {
    final json = await spaceFactRemoteDataSource.getDailySpaceFact();
    return SpaceFact.fromJson(json);
  }

  Future<SpaceFact> getRandomSpaceFact() async {
    final json = await spaceFactRemoteDataSource.getRandomSpaceFact();
    return SpaceFact.fromJson(json);
  }
}
