// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color.fromARGB(255, 210, 88, 1),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 251, 167, 107),
    textStyle: TextStyle(color: Colors.black),
    side: BorderSide(color: Color.fromARGB(255, 64, 64, 64), width: 1),
  )),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor: const Color.fromARGB(255, 210, 88, 1),
    suffixIconColor: const Color.fromARGB(255, 210, 88, 1),
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 210, 88, 1),
      textStyle: const TextStyle(
        fontSize: 18,
      ),
      disabledBackgroundColor: Colors.grey,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 210, 88, 1),
    elevation: 0.3,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 210, 88, 1)));
