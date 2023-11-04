// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:forkified/shared/colors.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: cerulian,
  primaryColor: platinum,
  hintColor: nonPhotoBlue,
  scaffoldBackgroundColor: prussianBlue,
  appBarTheme: AppBarTheme(
    color: prussianBlue,
    elevation: 0,
    iconTheme: IconThemeData(
      color: platinum,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: platinum,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: nonPhotoBlueDark,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: nonPhotoBlueDark,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: nonPhotoBlueDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: nonPhotoBlueDark,
    ),
  ),
);
