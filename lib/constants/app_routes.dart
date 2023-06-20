import 'package:flutter/material.dart';
import 'package:imc_project_app/pages/home_screen.dart';

class Routes {
  static String home = '/';
  static String dashboard = '/dashboard';
  static String location = '/location';
  static String counter = '/counter';
  static String register = '/register';
}

Map<String, Widget Function(BuildContext)> AppRoutes(BuildContext context) {
  return {
    Routes.home: (context) => const HomeScreen(),
  };
}
