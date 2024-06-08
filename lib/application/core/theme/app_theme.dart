import 'package:flutter/material.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';

class AppThemes {
  static get getTheme => ThemeData(
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: HexColor.fromHex(AppConstants.primaryColor)),
      useMaterial3: true,
      fontFamily: "Poppins",
      iconTheme: IconThemeData(
        color: HexColor.fromHex(AppConstants.primaryColor),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
          backgroundColor: MaterialStateProperty.all(
              HexColor.fromHex(AppConstants.primaryColor).withOpacity(0.3)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(350, 40)),
          backgroundColor: WidgetStateProperty.all(
              HexColor.fromHex(AppConstants.primaryColor)),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
      ));
}
