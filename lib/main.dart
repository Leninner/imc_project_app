import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/constants/breakpoints.dart';
import 'package:imc_project_app/constants/navigation_service.dart';
import 'package:imc_project_app/constants/styles/theme.dart';
import 'package:imc_project_app/services/imc/bloc/imc_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    authFlowType: AuthFlowType.pkce,
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ImcBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: Breakpoints,
        title: 'IMC Project App',
        theme: theme,
        initialRoute: Routes.splash,
        routes: AppRoutes(context),
        navigatorKey: NavigationService.navigatorKey,
      ),
    );
  }
}
