import 'package:flutter/material.dart';

class ColorSchemeApp {
  static const MaterialColor primary = MaterialColor(
    _primaryBase,
    <int, Color>{
      50: Color(0xFFECF4FF),
      100: Color(0xFFDFECFF),
      200: Color(0xFFD1E5FF),
      300: Color(0xFFC4DDFF),
      400: Color(0xFF9DBAE1),
      500: Color(_primaryBase),
      600: Color(0xFF56759D),
      700: Color(0xFF3A567B),
      800: Color(0xFF243B59),
      900: Color(0xFF122237),
    },
  );

  static const MaterialColor acento = MaterialColor(
    _acentoBase,
    <int, Color>{
      50: Color(0xFFFFEAF2),
      100: Color(0xFFFFBCD6),
      200: Color(0xFFFF8EBA),
      300: Color(0xFFFF609D),
      400: Color(0xFFFF3281),
      500: Color(_acentoBase),
      600: Color(0xFFC40F55),
      700: Color(0xFFA20240),
      800: Color(0xFF800032),
      900: Color(0xFF5E0024),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    _secondaryBase,
    <int, Color>{
      50: Color(0xFFF6FAFF),
      100: Color(0xFFEAF1FC),
      200: Color(0xFFDBE3F0),
      300: Color(0xFFC5CDD8),
      400: Color(0xFFA4AEBB),
      500: Color(_secondaryBase),
      600: Color(0xFF787E87),
      700: Color(0xFF636A74),
      800: Color(0xFF4D535C),
      900: Color(0xFF3A4047),
    },
  );

  static const MaterialColor success = MaterialColor(
    _successBase,
    <int, Color>{
      50: Color(0xFFECFDF5),
      100: Color(0xFFD1FAE5),
      200: Color(0xFFA7F3D0),
      300: Color(0xFF6EE7B7),
      400: Color(0xFF34D399),
      500: Color(_successBase),
      600: Color(0xFF059669),
      700: Color(0xFF047857),
      800: Color(0xFF065F46),
      900: Color(0xFF064E3B),
    },
  );

  static const MaterialColor warning = MaterialColor(
    _warningBase,
    <int, Color>{
      50: Color(0xFFFFF7ED),
      100: Color(0xFFFFEDD5),
      200: Color(0xFFFED7AA),
      300: Color(0xFFFDBA74),
      400: Color(0xFFFB923C),
      500: Color(_warningBase),
      600: Color(0xFFEA580C),
      700: Color(0xFFC2410C),
      800: Color(0xFF9A3412),
      900: Color(0xFF7C2D12),
    },
  );

  static const MaterialColor danger = MaterialColor(
    _dangerBase,
    <int, Color>{
      50: Color(0xFFFEF2F2),
      100: Color(0xFFFEE2E2),
      200: Color(0xFFFECACA),
      300: Color(0xFFFCA5A5),
      400: Color(0xFFF87171),
      500: Color(_dangerBase),
      600: Color(0xFFDC2626),
      700: Color(0xFFB91C1C),
      800: Color(0xFF991B1B),
      900: Color(0xFF7F1D1D),
    },
  );

  static const MaterialColor info = MaterialColor(
    _infoBase,
    <int, Color>{
      50: Color(0xFFECFEFF),
      100: Color(0xFFCFFAFE),
      200: Color(0xFFA5F3FC),
      300: Color(0xFF67E8F9),
      400: Color(0xFF22D3EE),
      500: Color(_infoBase),
      600: Color(0xFF0891B2),
      700: Color(0xFF0E7490),
      800: Color(0xFF155E75),
      900: Color(0xFF164E63),
    },
  );

  static const MaterialColor gray = MaterialColor(
    _grayBase,
    <int, Color>{
      50: Color(0xFFE1E5F0),
      100: Color(0xFFB8BFD3),
      200: Color(0xFF939CB6),
      300: Color(0xFF727C99),
      400: Color(0xFF545E7C),
      500: Color(_grayBase),
      600: Color(0xFF1F2937),
      700: Color(0xFF111827),
      800: Color(0xFF0D131F),
      900: Color(0xFF080C14),
    },
  );

  static const int _primaryBase = 0xFF7796BF;
  static const int _secondaryBase = 0xFF9198A4;
  static const int _successBase = 0xFF10B981;
  static const int _dangerBase = 0xFFEF4444;
  static const int _infoBase = 0xFF06B6D4;
  static const int _grayBase = 0xFF3A435E;
  static const int _warningBase = 0xFFF97316;
  static const int _acentoBase = 0xFFE61F6C;
}
