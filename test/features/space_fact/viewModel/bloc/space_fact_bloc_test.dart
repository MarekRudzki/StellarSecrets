import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';
import 'package:stellar_secrets/features/space_fact/model/space_fact_repository.dart';
import 'package:stellar_secrets/features/space_fact/viewModel/bloc/space_fact_bloc.dart';

class MockSpaceFactRepository extends Mock implements SpaceFactRepository {}

void main() {
  late SpaceFactBloc sut;
  late MockSpaceFactRepository spaceFactRepository;

  setUp(() {
    spaceFactRepository = MockSpaceFactRepository();
    sut = SpaceFactBloc(spaceFactRepository: spaceFactRepository);
  });

  final SpaceFact dailySpaceFact = SpaceFact(
    copyright: 'daily_copyright',
    date: 'daily_date',
    description: 'daily_description',
    hdUrl: 'daily_hdUrl.jpg',
    title: 'daily_title',
    url: 'daily_url.jpg',
  );

  final SpaceFact dailyHiveSpaceFact = SpaceFact(
    copyright: 'daily_hive_copyright',
    date: 'daily_hive_date',
    description: 'daily_hive_description',
    hdUrl: 'daily_hive_hdUrl.jpg',
    title: 'daily_hive_title',
    url: 'daily_hive_url.jpg',
  );

  final SpaceFact randomSpaceFact = SpaceFact(
    copyright: 'random_copyright',
    date: 'random_date',
    description: 'random_description',
    hdUrl: 'random_hdUrl.jpg',
    title: 'random_title',
    url: 'random_url.jpg',
  );

  group('Space fact bloc', () {
    blocTest<SpaceFactBloc, SpaceFactState>(
      'emits [SpaceFactLoading] and [SpaceFactSuccess] when DailySpaceFactRequested is added and spaceFact is saved in memory.',
      build: () {
        when(() => spaceFactRepository.checkIfDailyFactIsSaved(
            date: any(named: 'date'))).thenReturn(true);
        when(() =>
                spaceFactRepository.getSavedSpaceFact(date: any(named: 'date')))
            .thenReturn(dailyHiveSpaceFact);

        return sut;
      },
      act: (bloc) => sut.add(DailySpaceFactRequested()),
      expect: () => [
        SpaceFactLoading(),
        SpaceFactSuccess(spaceFact: dailyHiveSpaceFact),
      ],
    );

    blocTest<SpaceFactBloc, SpaceFactState>(
      'emits [SpaceFactLoading] and [SpaceFactSuccess] when DailySpaceFactRequested is added.',
      build: () {
        when(() => spaceFactRepository.checkIfDailyFactIsSaved(
            date: any(named: 'date'))).thenReturn(false);

        when(() => spaceFactRepository.getDailySpaceFact())
            .thenAnswer((_) async => dailySpaceFact);
        when(() => spaceFactRepository.addDailySpaceFact(
            date: any(named: 'date'),
            spaceFact: dailySpaceFact)).thenAnswer((_) async => {});

        return sut;
      },
      act: (bloc) => sut.add(DailySpaceFactRequested()),
      expect: () => [
        SpaceFactLoading(),
        SpaceFactSuccess(spaceFact: dailySpaceFact),
      ],
    );

    blocTest<SpaceFactBloc, SpaceFactState>(
      'emits [SpaceFactLoading] and [SpaceFactError] when DailySpaceFactRequested throws an exception.',
      build: () {
        when(() => spaceFactRepository.getDailySpaceFact())
            .thenThrow(Exception('Error occured'));
        return sut;
      },
      act: (bloc) => sut.add(DailySpaceFactRequested()),
      expect: () => [
        SpaceFactLoading(),
        SpaceFactError(),
      ],
    );

    blocTest<SpaceFactBloc, SpaceFactState>(
      'emits [SpaceFactLoading] and [SpaceFactSuccess] when RandomSpaceFactRequsted is added.',
      build: () {
        when(() => spaceFactRepository.getRandomSpaceFact())
            .thenAnswer((_) async => randomSpaceFact);
        return sut;
      },
      act: (bloc) => sut.add(RandomSpaceFactRequsted()),
      expect: () => [
        SpaceFactLoading(),
        SpaceFactSuccess(spaceFact: randomSpaceFact),
      ],
    );

    blocTest<SpaceFactBloc, SpaceFactState>(
      'emits [SpaceFactLoading] and [SpaceFactError] when RandomSpaceFactRequsted throws an exception.',
      build: () {
        when(() => spaceFactRepository.getRandomSpaceFact())
            .thenThrow(Exception('Error occured'));
        return sut;
      },
      act: (bloc) => sut.add(RandomSpaceFactRequsted()),
      expect: () => [
        SpaceFactLoading(),
        SpaceFactError(),
      ],
    );
  });
}
