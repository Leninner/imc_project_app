import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;

    if (session != null) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SvgPicture.asset('assets/images/splash.svg'),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
