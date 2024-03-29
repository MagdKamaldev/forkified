// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:forkified/shared/colors.dart';

final ThemeData darkTheme = ThemeData(
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

final ThemeData lightTheme = ThemeData(
  primarySwatch: flame,
  primaryColor: platinum,
  hintColor: blackOlive,
  scaffoldBackgroundColor: platinum,
  appBarTheme: AppBarTheme(
    color: flame,
    elevation: 0,
  ),
  iconTheme: IconThemeData(color: platinum),
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
      color: blackOlive,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: "Raleway",
      color: blackOlive,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Raleway",
      fontSize: 16,
      color: blackOlive,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Raleway",
      fontSize: 14,
      color: blackOlive,
    ),
  ),
);
