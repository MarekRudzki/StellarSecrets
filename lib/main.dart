import 'package:flutter/material.dart';
import 'package:stellar_secrets/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: Color.fromRGBO(0, 31, 63, 1),
          primary: Color.fromRGBO(0, 31, 63, 1),
        ),
      ),
    ),
  );
}
