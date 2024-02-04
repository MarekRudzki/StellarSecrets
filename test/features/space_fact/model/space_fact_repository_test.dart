import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';
import 'package:stellar_secrets/features/space_fact/model/local_datasources/hive_local_datasource.dart';
import 'package:stellar_secrets/features/space_fact/model/remote_datasources/nasa_remote_datasource.dart';
import 'package:stellar_secrets/features/space_fact/model/space_fact_repository.dart';

class MockSpaceFactRemoteDataSource extends Mock
    implements NASARemoteDataSource {}

class MockHiveLocalDatasource extends Mock implements HiveLocalDatasource {}

void main() {
  late SpaceFactRepository sut;
  late NASARemoteDataSource spaceFactRemoteDataSource;
  late HiveLocalDatasource hiveLocalDatasource;

  setUp(() {
    spaceFactRemoteDataSource = MockSpaceFactRemoteDataSource();
    hiveLocalDatasource = MockHiveLocalDatasource();
    sut = SpaceFactRepository(
      spaceFactRemoteDataSource: spaceFactRemoteDataSource,
      hiveLocalDatasource: hiveLocalDatasource,
    );
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

  test(
    "should add daily fact to hive",
    () async {
      when(() => hiveLocalDatasource.addDailyFact(
            spaceFact: spaceFact,
          )).thenAnswer((_) async => {});

      sut.addDailySpaceFact(
        date: 'date',
        spaceFact: spaceFact,
      );

      verify(() => hiveLocalDatasource.addDailyFact(spaceFact: spaceFact))
          .called(1);
    },
  );

  test(
    "should get SpaceFact from Hive",
    () async {
      when(() => hiveLocalDatasource.getDailyFact(date: any(named: 'date')))
          .thenReturn(json);

      final savedSpaceFact = sut.getSavedSpaceFact(date: 'date');

      expect(savedSpaceFact, spaceFact);
    },
  );

  group("should check if daily fact is saved", () {
    test(
      "and return true",
      () async {
        when(() => hiveLocalDatasource.checkIfDailyFactIsSaved(
            date: any(named: 'date'))).thenReturn(true);

        final isDailyFactSaved = sut.checkIfDailyFactIsSaved(date: 'date');

        expect(isDailyFactSaved, true);
      },
    );

    test(
      "and return false",
      () async {
        when(() => hiveLocalDatasource.checkIfDailyFactIsSaved(
            date: any(named: 'date'))).thenReturn(false);

        final isDailyFactSaved = sut.checkIfDailyFactIsSaved(date: 'date');

        expect(isDailyFactSaved, false);
      },
    );
  });
}
