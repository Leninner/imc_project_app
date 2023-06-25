import 'package:flutter/material.dart';
import 'package:imc_project_app/pages/home_page.dart';
import 'package:imc_project_app/pages/login_page.dart';
import 'package:imc_project_app/pages/register_page.dart';
import 'package:imc_project_app/pages/splash_page.dart';

class Routes {
  static String home = '/';
  static String login = '/login';
  static String account = '/account';
  static String register = '/register';
  static String splash = '/splash';
}

Map<String, Widget Function(BuildContext)> AppRoutes(BuildContext context) {
  return {
    Routes.home: (context) => const HomePage(),
    Routes.login: (context) => const LoginPage(),
    Routes.register: (context) => const RegisterPage(),
    Routes.splash: (context) => const SplashPage(),
  };
}
