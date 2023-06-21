import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/constants/breakpoints.dart';
import 'package:imc_project_app/constants/environments.dart';
import 'package:imc_project_app/constants/navigation_service.dart';
import 'package:imc_project_app/constants/styles/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: SUPABASE_ANON_KEY,
    authFlowType: AuthFlowType.pkce,
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: Breakpoints,
      title: 'IMC Project App',
      theme: theme,
      initialRoute: Routes.home,
      routes: AppRoutes(context),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
