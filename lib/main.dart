import 'package:flutter/material.dart';
import 'package:forkified/modules/on_boarding/on_borading_screen.dart';
import 'package:forkified/shared/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const OnBoardingScreen(),
    );
  }
}
