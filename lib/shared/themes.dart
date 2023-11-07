// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:forkified/shared/colors.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: cerulian,
  primaryColor: platinum,
  hintColor: nonPhotoBlue,
  scaffoldBackgroundColor: prussianBlue,
  appBarTheme: AppBarTheme(
    color: cerulian,
    elevation: 0,
    iconTheme: IconThemeData(
      color: platinum,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: "Raleway",
      color: platinum,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: "Raleway",
      color: nonPhotoBlueDark,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: "Raleway",
      color: nonPhotoBlueDark,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Raleway",
      fontSize: 16,
      color: nonPhotoBlueDark,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Raleway",
      fontSize: 14,
      color: nonPhotoBlueDark,
    ),
  ),
);
