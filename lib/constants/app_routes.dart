import 'package:flutter/material.dart';
import 'package:imc_project_app/pages/login_page.dart';
import 'package:imc_project_app/pages/register_page.dart';

class Routes {
  static String home = '/';
  static String login = '/login';
  static String account = '/account';
  static String register = '/register';
}

Map<String, Widget Function(BuildContext)> AppRoutes(BuildContext context) {
  return {
    // Routes.home: (context) => const SplashPage(),
    Routes.login: (context) => const LoginPage(),
    // Routes.account: (context) => const AccountPage(),
    Routes.register: (context) => const RegisterPage(),
  };
}
