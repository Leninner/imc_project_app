import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/constants/breakpoints.dart';
import 'package:imc_project_app/constants/navigation_service.dart';
import 'package:imc_project_app/constants/styles/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: Breakpoints,
      title: 'IMC Project App',
      theme: theme,
      routes: AppRoutes(context),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
