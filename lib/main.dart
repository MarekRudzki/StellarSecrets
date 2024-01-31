import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:stellar_secrets/features/daily_picture/viewModel/bloc/daily_picture_bloc.dart';
import 'package:stellar_secrets/features/home/view/home_screen.dart';
import 'package:stellar_secrets/features/home/viewModel/internet_connection_provider.dart';
import 'package:stellar_secrets/utils/custom_theme.dart';

void main() async {
  await dotenv.load();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DailyPictureBloc(),
        )
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
