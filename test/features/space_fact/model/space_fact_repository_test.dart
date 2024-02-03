import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';
import 'package:stellar_secrets/features/space_fact/model/remote_datasources/space_fact_remote_datasource.dart';
import 'package:stellar_secrets/features/space_fact/model/space_fact_repository.dart';

class MockSpaceFactRemoteDataSource extends Mock
    implements SpaceFactRemoteDataSource {}

void main() {
  late SpaceFactRepository sut;
  late SpaceFactRemoteDataSource spaceFactRemoteDataSource;

  setUp(() {
    spaceFactRemoteDataSource = MockSpaceFactRemoteDataSource();
    sut = SpaceFactRepository(
        spaceFactRemoteDataSource: spaceFactRemoteDataSource);
  });

  final Map<String, dynamic> json = {
    'copyright': 'copyright',
    'date': 'date',
    'explanation': 'description',
    'hdurl': 'hdUrl',
    'title': 'title',
    'url': 'url',
  };

  final SpaceFact spaceFact = SpaceFact(
    copyright: 'copyright',
    date: 'date',
    description: 'description',
    hdUrl: 'hdUrl',
    title: 'title',
    url: 'url',
  );

  test(
    "should return daily space fact",
    () async {
      when(() => spaceFactRemoteDataSource.getDailySpaceFact())
          .thenAnswer((_) async => json);

      final dailySpaceFact = await sut.getDailySpaceFact();

      expect(dailySpaceFact, spaceFact);
    },
  );

  test(
    "should return random space fact",
    () async {
      when(() => spaceFactRemoteDataSource.getRandomSpaceFact())
          .thenAnswer((_) async => json);

      final randomSpaceFact = await sut.getRandomSpaceFact();

      expect(randomSpaceFact, spaceFact);
    },
  );
}
