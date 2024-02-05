// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:stellar_secrets/features/space_fact/model/data_models/space_fact.dart';
import 'package:stellar_secrets/features/space_fact/model/space_fact_repository.dart';

part 'space_fact_event.dart';
part 'space_fact_state.dart';

class SpaceFactBloc extends Bloc<SpaceFactEvent, SpaceFactState> {
  final SpaceFactRepository spaceFactRepository;
  SpaceFactBloc({required this.spaceFactRepository})
      : super(SpaceFactInitial()) {
    on<DailySpaceFactRequested>(_onDailySpaceFactRequested);
    on<RandomSpaceFactRequsted>(_onRandomSpaceFactRequsted);
  }

  Future<void> _onDailySpaceFactRequested(
    DailySpaceFactRequested event,
    Emitter<SpaceFactState> emit,
  ) async {
    final todayDate = DateTime.now().toString().substring(0, 10);
    final SpaceFact dailySpaceFact;
    emit(SpaceFactLoading());
    try {
      final isSpaceFactSaved = spaceFactRepository.checkIfDailyFactIsSaved(
        date: todayDate,
      );

      if (isSpaceFactSaved) {
        dailySpaceFact = spaceFactRepository.getSavedSpaceFact(date: todayDate);
      } else {
        dailySpaceFact = await spaceFactRepository.getDailySpaceFact();
        await spaceFactRepository.addDailySpaceFact(
          date: todayDate,
          spaceFact: dailySpaceFact,
        );
      }

      emit(SpaceFactSuccess(spaceFact: dailySpaceFact));
    } catch (e) {
      debugPrint(e.toString());
      emit(SpaceFactError());
    }
  }

  Future<void> _onRandomSpaceFactRequsted(
    RandomSpaceFactRequsted event,
    Emitter<SpaceFactState> emit,
  ) async {
    emit(SpaceFactLoading());
    try {
      SpaceFact randomSpaceFact;
      while (true) {
        randomSpaceFact = await spaceFactRepository.getRandomSpaceFact();
        if (randomSpaceFact.url.contains('.jpg')) {
          break;
        }
      }

      emit(SpaceFactSuccess(spaceFact: randomSpaceFact));
    } catch (e) {
      debugPrint(e.toString());
      emit(SpaceFactError());
    }
  }
}
