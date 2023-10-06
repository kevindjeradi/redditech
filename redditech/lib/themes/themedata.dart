import 'package:flutter/material.dart';

ThemeData themedata = ThemeData(
  //ICI on peut definir du CSS par default pr tte les pages
  // TEXT ------------------------------->
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    headline2: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
  ),
  // ------------------------------------->
  primarySwatch: Colors.blue,
  errorColor: Colors.red,
);
