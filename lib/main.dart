// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:stellar_secrets/features/home/view/home_screen.dart';
import 'package:stellar_secrets/features/home/viewModel/internet_connection_provider.dart';
import 'package:stellar_secrets/features/space_fact/model/local_datasources/hive_local_datasource.dart';
import 'package:stellar_secrets/features/space_fact/model/remote_datasources/nasa_remote_datasource.dart';
import 'package:stellar_secrets/features/space_fact/model/space_fact_repository.dart';
import 'package:stellar_secrets/features/space_fact/viewModel/bloc/space_fact_bloc.dart';
import 'package:stellar_secrets/utils/custom_theme.dart';

void main() async {
  await dotenv.load();

  await Hive.initFlutter();
  await Hive.openBox('dailyFact');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SpaceFactBloc(
            spaceFactRepository: SpaceFactRepository(
              spaceFactRemoteDataSource: NASARemoteDataSource(),
              hiveLocalDatasource: HiveLocalDatasource(),
            ),
          ),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => InternetConnectionProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          theme: CustomTheme.theme,
        ),
      ),
    ),
  );
}
