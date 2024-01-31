import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stellar_secrets/features/home/view/home_screen.dart';
import 'package:stellar_secrets/utils/custom_theme.dart';

void main() async {
  await dotenv.load();
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: CustomTheme.theme,
      ),
    ),
  );
}
