import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/styles/color_scheme.dart';
import 'package:imc_project_app/constants/styles/styles.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: ColorSchemeApp.gray.shade50,
  fontFamily: StyleConstants.primaryFont,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      debugLabel: 'H1/bold',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: StyleConstants.primaryFont,
    ),
    displayMedium: TextStyle(
      debugLabel: 'H1/regular',
      fontSize: 24,
      fontWeight: FontWeight.normal,
      fontFamily: StyleConstants.primaryFont,
    ),
    displaySmall: TextStyle(
      debugLabel: 'H2/bold',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: StyleConstants.primaryFont,
    ),
    headlineLarge: TextStyle(
      debugLabel: 'H2/regular',
      fontSize: 20,
      fontWeight: FontWeight.normal,
      fontFamily: StyleConstants.primaryFont,
    ),
    headlineMedium: TextStyle(
      debugLabel: 'H3/Medium',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: StyleConstants.primaryFont,
    ),
    headlineSmall: TextStyle(
      debugLabel: 'H3/Regular',
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: StyleConstants.primaryFont,
    ),
    titleLarge: TextStyle(
      debugLabel: 'Subtitulo/bold',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: StyleConstants.primaryFont,
    ),
    titleMedium: TextStyle(
      debugLabel: 'Subtítulo/Regular',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: StyleConstants.primaryFont,
    ),
    titleSmall: TextStyle(
      debugLabel: 'Link1/Regular',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: StyleConstants.primaryFont,
      decoration: TextDecoration.underline,
    ),
    bodyMedium: TextStyle(
      debugLabel: 'Body/bold',
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: StyleConstants.primaryFont,
    ),
    bodySmall: TextStyle(
      debugLabel: 'Body/regular',
      fontWeight: FontWeight.normal,
      fontSize: 14,
      fontFamily: StyleConstants.primaryFont,
    ),
    labelLarge: TextStyle(
      debugLabel: "Small/Bold",
      fontFamily: StyleConstants.primaryFont,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      debugLabel: "Small/Regular",
      fontFamily: StyleConstants.primaryFont,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      debugLabel: "Link2/Regular",
      fontFamily: StyleConstants.primaryFont,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 72, 16, 112),
    primary: const Color.fromARGB(255, 78, 33, 126),
    secondary: ColorSchemeApp.secondary,
    error: ColorSchemeApp.danger,
  ),
);
